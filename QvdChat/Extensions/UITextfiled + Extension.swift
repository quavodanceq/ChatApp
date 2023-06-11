import Foundation
import UIKit
import Combine

extension UITextField {
    
     var textPublisher: AnyPublisher<String?, Never> {
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification,
                object: self
            )
            .compactMap { ($0.object as? UITextField)?.text }
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
}
