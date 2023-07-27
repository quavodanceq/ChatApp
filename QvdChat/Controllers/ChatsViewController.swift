import UIKit
import Foundation
import Firebase
import FirebaseFirestore
import Combine

class ChatsViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let currentUser: UserModel
    
    private var chats = [Chat]()
    
    private var foundUsers = [UserModel]()
    
    private var chatsListener: ListenerRegistration?

    private let db = Firestore.firestore()
    
    private var cancellable = [AnyCancellable]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListener()
        setupNavigation()
        setupViews()
        setupCombineSearch()
        setupConstraints()
        setupDelegates()
        
        
    }
    
    deinit {
        chatsListener?.remove()
    }
    
    init(currentUser: UserModel) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupListener() {
        chatsListener = FirestoreManager.shared.chatsListener(chats: chats, completion: { result in
            switch result {
            case .success(let chats):
                self.chats = chats
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setupViews() {
        setupTableView()
    }
    private func setupNavigation() {
        title = "Chats"
        let apperance = UINavigationBarAppearance()
        apperance.backgroundColor = .customGray
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .customGray
        navigationController?.navigationBar.backgroundColor = .customGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.backgroundColor = .black
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [.foregroundColor : UIColor.gray])
        searchController.searchBar.searchTextField.textColor = .white
    }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.rowHeight = view.safeAreaLayoutGuide.layoutFrame.height * 0.1
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.reuseIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
    }
    
    func setupCombineSearch() {
        
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher
        .map {
            ($0.object as! UISearchTextField).text ?? ""
        }
        .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
        .sink { value in
            AlgoliaManager.shared.search(username: value) { users in
                self.foundUsers = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        .store(in: &cancellable)
    }
    
    private func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private var isSearchBarEmpty: Bool {
        
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool{
        return searchController.isActive && !isSearchBarEmpty
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return foundUsers.count
        } else {
            return chats.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFiltering {
            if foundUsers[indexPath.row].uid == currentUser.uid {
                return SearchResultCell(user: foundUsers[indexPath.row])
            } else {
                return SearchResultCell(user: foundUsers[indexPath.row])
            }
            
        } else {
                let chat = chats[indexPath.row]
            return ChatCell(chat: chat)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            
            let companion = foundUsers[indexPath.row]
            let chat = chats.first { chat in
                chat.companionUID == companion.uid
            }
            let dialogVC = DialogViewController(currentUser: currentUser, companion: companion, chat: chat)
            self.navigationController?.pushViewController(dialogVC, animated: true)
        } else {
            let chat = chats[indexPath.row]
            let companion = UserModel(uid: chat.companionUID, username: chat.companionUsername)
            let dialogVC = DialogViewController(currentUser: currentUser, companion: companion, chat: chat)
            self.navigationController?.pushViewController(dialogVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
}

extension ChatsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        tableView.reloadData()
    }
}



