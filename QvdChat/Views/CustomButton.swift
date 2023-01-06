
import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init()
        setTitleColor(.white, for: .normal)
        setTitle(text, for: .normal)
        layer.cornerRadius = 10
        backgroundColor = .customGray
        titleLabel?.font = .appleSDGothicNeo?.withSize(22)
        layer.cornerCurve = .continuous
        translatesAutoresizingMaskIntoConstraints = false
    }
}
