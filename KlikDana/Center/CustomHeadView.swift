//
//  CustomHeadView.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class CustomHeadView: UIView {
    
    var backBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nameLabel.textAlignment = .center
        nameLabel.text = "Klik Dana"
        return nameLabel
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "back_icon_image"), for: .normal)
        backBtn.adjustsImageWhenHighlighted = false
        backBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return backBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(backBtn)
        
        bgView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.top).offset(44)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14)
            make.width.equalTo(260)
        }
        backBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 16, height: 28))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomHeadView {
    
    @objc func btnClick() {
        self.backBlock?()
    }
}
