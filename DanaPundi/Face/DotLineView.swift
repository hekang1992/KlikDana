//
//  DotLineView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/7.
//

import UIKit

class DotLineView: UIView {
    
    var lineColor: UIColor = UIColor(hexString: "#000000") {
        didSet {
            shapeLayer.strokeColor = lineColor.cgColor
        }
    }
    
    var lineWidth: CGFloat = 1.0 {
        didSet {
            shapeLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    var dashPattern: [NSNumber] = [5, 5] {
        didSet {
            shapeLayer.lineDashPattern = dashPattern
        }
    }
    
    var linePosition: LinePosition = .center {
        didSet {
            updatePath()
        }
    }
    
    enum LinePosition {
        case center
        case top
        case bottom
        case custom(y: CGFloat)
        
        func yPosition(in bounds: CGRect) -> CGFloat {
            switch self {
            case .center:
                return bounds.midY
            case .top:
                return 0
            case .bottom:
                return bounds.height
            case .custom(let y):
                return y
            }
        }
    }
    
    private let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.lineJoin = .round
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        isOpaque = false
        layer.addSublayer(shapeLayer)
        configureShapeLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShapeLayerFrame()
        updatePath()
    }
    
    private func updateShapeLayerFrame() {
        shapeLayer.frame = bounds
    }
    
    private func configureShapeLayer() {
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = dashPattern
    }
    
    private func updatePath() {
        let y = linePosition.yPosition(in: bounds)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: bounds.width, y: y))
        
        shapeLayer.path = path.cgPath
    }
    
    func setDashPattern(onLength: CGFloat, offLength: CGFloat) {
        dashPattern = [NSNumber(value: Double(onLength)), NSNumber(value: Double(offLength))]
    }
    
    func setLineColor(hexString: String) {
        lineColor = UIColor(hexString: hexString)
    }
    
    override func display(_ layer: CALayer) {
        super.display(layer)
    }
    
    deinit {
        shapeLayer.removeFromSuperlayer()
    }
}

