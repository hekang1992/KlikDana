//
//  CustomHeadView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class CustomHeadView: UIView {
    
    // MARK: - Callback
    var backBlock: (() -> Void)?
    
    // MARK: - Views
    private lazy var statusBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#000000")
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "back_icon_image"), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomHeadView {
    
    func setupUI() {
        addSubview(statusBarView)
        addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(backBtn)
    }
    
    func setupConstraints() {
        
        statusBarView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(260)
        }
        
        backBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 16, height: 28))
        }
    }
}

extension CustomHeadView {
    
    @objc func backBtnClick() {
        backBlock?()
    }
    
    func configTitle(with title: String) {
        nameLabel.text = title
    }
}
