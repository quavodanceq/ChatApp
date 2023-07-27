

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore



class InfoViewController: UIViewController {
    
   
    let nameTextField = UITextField()
    let imagePickerButton = UIButton()
    let submitButton = UIButton()
    var profileImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
    
        addViews()
        
        setupConstraints()
        setupImagePickerButton()
        setupNameTextField()
        setupSubmitButton()
    }
    
    private func addViews(){
        view.addSubview(nameTextField)
        view.addSubview(imagePickerButton)
        view.addSubview(submitButton)
    }

    private func setupConstraints(){
        
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePickerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imagePickerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            imagePickerButton.heightAnchor.constraint(equalTo: imagePickerButton.widthAnchor)
        ])
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 50),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupImagePickerButton(){
        
        imagePickerButton.layer.cornerRadius = view.frame.width * 0.2 / 2
        imagePickerButton.layer.masksToBounds = true
        let image = UIImage(systemName: "plus.circle")
        imagePickerButton.setBackgroundImage(image, for: .normal)
        imagePickerButton.imageView?.contentMode = .scaleAspectFit
        imagePickerButton.addTarget(self, action: #selector(imagePickerButtonTapped), for: .touchUpInside)
    }
    
    private func setupNameTextField(){
        
        nameTextField.placeholder = "Enter your name"
    }
    
    private func setupSubmitButton(){
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    @objc private func submitButtonTapped(){
        guard nameTextField.text != "" && profileImage != nil else { return }
        
        let db = Firestore.firestore()
        let currentUserID = Auth.auth().currentUser?.uid
        db.collection("users").document(currentUserID!).setData(["username" : nameTextField.text])
        
    }
   

}

extension InfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc private func imagePickerButtonTapped(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imagePickerButton.setBackgroundImage(image, for: .normal)
            self.profileImage = image
        }
        
        dismiss(animated: true)
        
    }
    
    
}



