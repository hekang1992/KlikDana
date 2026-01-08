//
//  ProductListView.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/5.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class ProductListView: UIView {
    
    var cellBlock: ((amorModel) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 15.pix()
        bgView.layer.masksToBounds = true
        bgView.layer.shadowColor = UIColor.init(hexString: "#1839BB").withAlphaComponent(0.1).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowOpacity = 1.0
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
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
        descLabel.numberOfLines = 0
        descLabel.textColor = UIColor.init(hexString: "#999999")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return descLabel
    }()
    
    lazy var typeView: UIView = {
        let typeView = UIView()
        typeView.layer.cornerRadius = 19.pix()
        typeView.layer.masksToBounds = true
        typeView.backgroundColor = UIColor.init(hexString: "#EEEEEE")
        return typeView
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .center
        typeLabel.textColor = UIColor.init(hexString: "#999999")
        typeLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return typeLabel
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(48)
        }
        
        bgView.addSubview(nameLabel)
        bgView.addSubview(typeView)
        typeView.addSubview(typeLabel)
        bgView.addSubview(descLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(15.pix())
            make.top.equalToSuperview().offset(20.pix())
            make.height.equalTo(14.pix())
        }
        
        typeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.pix())
            make.size.equalTo(CGSize(width: 85.pix(), height: 38.pix()))
        }
        
        typeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12.pix())
            make.right.equalTo(typeView.snp.left).offset(-10.pix())
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    func config(with model: amorModel) {
        let logoUrl = model.greg ?? ""
        logoImageView.kf.setImage(with: URL(string: logoUrl))
        nameLabel.text = model.canfy ?? ""
        descLabel.text = model.actship ?? ""
        let byly = model.byly ?? 0
        if byly == 1 {
            typeView.backgroundColor = UIColor.init(hexString: "#EEEEEE")
            typeLabel.text = LanguageManager.localizedString(for: "Completed")
            typeLabel.textColor = UIColor.init(hexString: "#999999")
        }else {
            typeView.backgroundColor = UIColor.init(hexString: "#3800FF")
            typeLabel.text = LanguageManager.localizedString(for: "GO")
            typeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        }
        
        clickBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.cellBlock?(model)
        }).disposed(by: disposeBag)
    }
}
