//
//  LoadingIndicator.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import UIKit

class LoadingIndicator {
    
    static let shared = LoadingIndicator()
    
    private var containerView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {}
    
    private func getCurrentWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    func show(on view: UIView? = nil) {
        DispatchQueue.main.async {
            if self.containerView != nil {
                return
            }
            
            guard let parentView = view ?? self.getCurrentWindow() else { return }
            
            let container = UIView(frame: parentView.bounds)
            container.backgroundColor = UIColor(white: 0, alpha: 0.3)
            container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            let whiteBox = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            whiteBox.center = container.center
            whiteBox.backgroundColor = UIColor(hexString: "#FFFAF0")
            whiteBox.layer.cornerRadius = 12
            whiteBox.clipsToBounds = true
            
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = CGPoint(x: whiteBox.bounds.width/2, y: whiteBox.bounds.height/2)
            indicator.startAnimating()
            
            whiteBox.addSubview(indicator)
            container.addSubview(whiteBox)
            parentView.addSubview(container)
            
            self.containerView = container
            self.activityIndicator = indicator
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.containerView?.removeFromSuperview()
            self.activityIndicator = nil
            self.containerView = nil
        }
    }
}
