import UIKit

class ProgressView: UIView {
    
    let lineWidth: CGFloat
    
    var isAnimating: Bool = false {
        
        didSet {
            if isAnimating {
                self.animateStroke()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
    
    private lazy var shapeLayer: ProgressShapeLayer = {
        
        return ProgressShapeLayer(linewidth: lineWidth)
        }()

    init(frame: CGRect, lineWidth: CGFloat) {
        
        self.lineWidth = lineWidth
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    convenience init(lineWidth: CGFloat) {
        
        self.init(frame: .zero, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.layer.cornerRadius = self.frame.width / 2
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let path = UIBezierPath(ovalIn:
                CGRect(
                    x: 0,
                    y: 0,
                    width: self.bounds.width,
                    height: self.bounds.width
                )
            )

            shapeLayer.path = path.cgPath
    }
    
    func animateStroke() {
        
            let startAnimation = StrokeAnimation(
                type: .start,
                beginTime: 0.25,
                fromValue: 0.0,
                toValue: 1.0,
                duration: 0.75
            )
        
            let endAnimation = StrokeAnimation(
                type: .end,
                fromValue: 0.0,
                toValue: 1.0,
                duration: 0.75
            )
        
            let strokeAnimationGroup = CAAnimationGroup()
            strokeAnimationGroup.duration = 1
            strokeAnimationGroup.repeatDuration = .infinity
            strokeAnimationGroup.animations = [startAnimation, endAnimation]
        
            shapeLayer.add(strokeAnimationGroup, forKey: nil)
            self.layer.addSublayer(shapeLayer)
        }
}

class ProgressShapeLayer: CAShapeLayer {
    
    public init(linewidth: CGFloat) {
        
        super.init()
        self.strokeColor = UIColor.customGreen.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StrokeAnimation: CABasicAnimation {
    
    
    enum StrokeType {
        case start
        case end
    }
    
    
    override init() {
        super.init()
    }
    
    
    init(type: StrokeType,
         beginTime: Double = 0.0,
         fromValue: CGFloat,
         toValue: CGFloat,
         duration: Double) {
        
        super.init()
        
        self.keyPath = type == .start ? "strokeStart" : "strokeEnd"
        
        self.beginTime = beginTime
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.timingFunction = .init(name: .easeInEaseOut)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
