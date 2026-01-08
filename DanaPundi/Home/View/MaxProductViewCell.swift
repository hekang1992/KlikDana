//
//  MaxProductViewCell.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import SnapKit
import Kingfisher

class MaxProductViewCell: UITableViewCell {
    
    var model: appearModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.potamosion ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            
            nameLabel.text = model.jugespecially ?? ""
            moneyLabel.text = model.urous ?? ""
            applyLabel.text = model.fraterbedform ?? ""
            itemLabel.text = model.auriroomfy ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 20.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5.pix()
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hexString: "#3800FF")
        moneyLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(700))
        return moneyLabel
    }()
    
    lazy var itemLabel: UILabel = {
        let itemLabel = UILabel()
        itemLabel.textAlignment = .right
        itemLabel.textColor = UIColor.init(hexString: "#999999")
        itemLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return itemLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "max_type_image")
        return typeImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return applyLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(moneyLabel)
        bgView.addSubview(itemLabel)
        bgView.addSubview(typeImageView)
        typeImageView.addSubview(applyLabel)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 96.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(15.pix())
            make.width.height.equalTo(24.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5.pix())
            make.height.equalTo(15.pix())
        }
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(10.pix())
            make.height.equalTo(32.pix())
        }
        itemLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.right.equalToSuperview().offset(-14.pix())
            make.height.equalTo(15.pix())
        }
        typeImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.bottom.equalToSuperview().offset(-15.pix())
            make.size.equalTo(CGSize(width: 81.pix(), height: 38.pix()))
        }
        applyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
