//
//  ProductHeadView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/6.
//

import UIKit
import SnapKit

class ProductHeadView: UIView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16.pix()
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1.pix()
        bgView.backgroundColor = UIColor(hexString: "#FFFFFF")
        bgView.layer.borderColor = UIColor(hexString: "#B7CFE9").cgColor
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "plac_d_image")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = LanguageManager.localizedString(for: "Information Security")
        descLabel.textColor = UIColor.init(hexString: "#999999")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return descLabel
    }()
    
    lazy var stepLabel: UILabel = {
        let stepLabel = UILabel()
        stepLabel.textAlignment = .right
        stepLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return stepLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(stepLabel)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 78.pix()))
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.width.height.equalTo(48.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.pix())
            make.left.equalTo(logoImageView.snp.right).offset(10.pix())
            make.height.equalTo(14.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12.pix())
            make.left.equalTo(logoImageView.snp.right).offset(10.pix())
            make.height.equalTo(12.pix())
        }
        stepLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.pix())
            make.height.equalTo(20.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
