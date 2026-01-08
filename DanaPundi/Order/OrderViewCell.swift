//
//  OrderViewCell.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: olModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.potamosion ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.jugespecially ?? ""
            typeLabel.text = model.programlike?.deaditive ?? ""
            let problemitor = model.programlike?.problemitor ?? ""
            
            oneLeftLabel.text = "\(model.areaaster ?? ""):"
            twoLeftLabel.text = "\(model.programlike?.aloneible ?? ""):"
            threeLeftLabel.text = "\(model.programlike?.parthenose ?? ""):"
            
            oneRightLabel.text = "\(model.cordise ?? "")"
            twoRightLabel.text = "\(model.programlike?.rathertion ?? "")"
            threeRightLabel.text = "\(model.programlike?.federalesque ?? "")"
            
            let applyStr = model.programlike?.gemproof ?? ""
            applyLabel.text = applyStr
            if applyStr.isEmpty {
                applyImageView.isHidden = true
                logoImageView.snp.remakeConstraints { make in
                    make.left.top.equalToSuperview().inset(15.pix())
                    make.width.height.equalTo(25.pix())
                    make.bottom.equalToSuperview().offset(-86.pix())
                }
            }else {
                applyImageView.isHidden = false
                logoImageView.snp.remakeConstraints { make in
                    make.left.top.equalToSuperview().inset(15.pix())
                    make.width.height.equalTo(25.pix())
                    make.bottom.equalToSuperview().offset(-145.pix())
                }
            }
            
            switch problemitor {
            case "sisterise":
                typeLabel.textColor = UIColor.init(hexString: "#07B7E7")
                
            case "cumulfier":
                typeLabel.textColor = UIColor.init(hexString: "#F0300C")
                
            case "senseent":
                typeLabel.textColor = UIColor.init(hexString: "#FA9E40")
                
            case "alleloen":
                typeLabel.textColor = UIColor.init(hexString: "#91FA40")
                
            case "chancearian":
                typeLabel.textColor = UIColor.init(hexString: "#CCCCCC")
                
            default:
                break
            }
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 20.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#E7EDFF")
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
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .right
        typeLabel.textColor = UIColor.init(hexString: "#FA9E40")
        typeLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(900))
        return typeLabel
    }()
    
    lazy var oneLeftLabel: UILabel = {
        let oneLeftLabel = UILabel()
        oneLeftLabel.textAlignment = .left
        oneLeftLabel.textColor = UIColor.init(hexString: "#333333")
        oneLeftLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLeftLabel
    }()
    
    lazy var twoLeftLabel: UILabel = {
        let twoLeftLabel = UILabel()
        twoLeftLabel.textAlignment = .left
        twoLeftLabel.textColor = UIColor.init(hexString: "#333333")
        twoLeftLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return twoLeftLabel
    }()
    
    lazy var threeLeftLabel: UILabel = {
        let threeLeftLabel = UILabel()
        threeLeftLabel.textAlignment = .left
        threeLeftLabel.textColor = UIColor.init(hexString: "#333333")
        threeLeftLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return threeLeftLabel
    }()
    
    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.image = UIImage(named: "login_btn_image")
        return applyImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return applyLabel
    }()
    
    lazy var oneRightLabel: UILabel = {
        let oneRightLabel = UILabel()
        oneRightLabel.textAlignment = .right
        oneRightLabel.textColor = UIColor.init(hexString: "#333333")
        oneRightLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(700))
        return oneRightLabel
    }()
    
    lazy var twoRightLabel: UILabel = {
        let twoRightLabel = UILabel()
        twoRightLabel.textAlignment = .right
        twoRightLabel.textColor = UIColor.init(hexString: "#333333")
        twoRightLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(700))
        return twoRightLabel
    }()
    
    lazy var threeRightLabel: UILabel = {
        let threeRightLabel = UILabel()
        threeRightLabel.textAlignment = .right
        threeRightLabel.textColor = UIColor.init(hexString: "#333333")
        threeRightLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(700))
        return threeRightLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(typeLabel)
        bgView.addSubview(oneLeftLabel)
        bgView.addSubview(twoLeftLabel)
        bgView.addSubview(threeLeftLabel)
        bgView.addSubview(oneRightLabel)
        bgView.addSubview(twoRightLabel)
        bgView.addSubview(threeRightLabel)
        bgView.addSubview(applyImageView)
        applyImageView.addSubview(applyLabel)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.pix())
            make.centerX.equalToSuperview()
            make.width.equalTo(315.pix())
            make.bottom.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(15.pix())
            make.width.height.equalTo(25.pix())
            make.bottom.equalToSuperview().offset(-145.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5.pix())
            make.height.equalTo(14)
        }
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.height.equalTo(13.pix())
            make.right.equalToSuperview().offset(-15.pix())
        }
        oneLeftLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(12.pix())
            make.height.equalTo(12.pix())
        }
        twoLeftLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(oneLeftLabel.snp.bottom).offset(11.pix())
            make.height.equalTo(12.pix())
        }
        threeLeftLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(twoLeftLabel.snp.bottom).offset(11.pix())
            make.height.equalTo(12.pix())
        }
        applyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 277.pix(), height: 58.pix()))
            make.bottom.equalToSuperview()
        }
        applyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.pix())
            make.centerX.equalToSuperview()
            make.height.equalTo(14.pix())
        }
        oneRightLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.top.equalTo(logoImageView.snp.bottom).offset(12.pix())
            make.height.equalTo(12.pix())
        }
        twoRightLabel.snp.makeConstraints { make in
            make.right.equalTo(oneRightLabel)
            make.top.equalTo(oneLeftLabel.snp.bottom).offset(11.pix())
            make.height.equalTo(12.pix())
        }
        threeRightLabel.snp.makeConstraints { make in
            make.right.equalTo(oneRightLabel)
            make.top.equalTo(twoLeftLabel.snp.bottom).offset(11.pix())
            make.height.equalTo(12.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
