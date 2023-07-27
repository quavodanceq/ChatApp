import Foundation
import UIKit

extension UIViewController{
    
    func setupNavigatonBar(title: String){
        navigationItem.title = title
        navigationItem.titleView?.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showAlert(title: String, message: String, style: UIAlertAction.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: style)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
