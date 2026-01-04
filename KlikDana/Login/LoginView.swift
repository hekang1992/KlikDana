//
//  LoginView.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit

class LoginView: UIView {
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = ""
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(900))
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
