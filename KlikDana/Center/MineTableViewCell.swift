//
//  MineTableViewCell.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit
import Kingfisher

class MineTableViewCell: UITableViewCell {
    
    var model: pharmacivityModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.val ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.canfy ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return nameLabel
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "arrow_icon_image")
        return arrowImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.init(hexString: "#DAEBFF")
        
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(arrowImageView)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(68)
            make.bottom.equalToSuperview().offset(-20)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(48)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(20)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 8, height: 16))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
