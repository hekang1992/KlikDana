//
//  SprayTableViewCell.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/7.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SprayTableViewCell: UITableViewCell {
    
    var model: olModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.canfy ?? ""
            txFiled.placeholder = model.actship ?? ""
            txFiled.text = model.hiblaughdom ?? ""
        }
    }
    
    var cellClickBlock: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 12.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor(hexString: "#EEEEEE")
        return bgView
    }()
    
    lazy var txFiled: UITextField = {
        let txFiled = UITextField()
        txFiled.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(400))
        txFiled.textColor = UIColor.init(hexString: "#333333")
        txFiled.isEnabled = false
        return txFiled
    }()
    
    lazy var rightView: UIView = {
        let rightView = UIView()
        rightView.layer.cornerRadius = 12.pix()
        rightView.layer.masksToBounds = true
        rightView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        rightView.backgroundColor = UIColor.init(hexString: "#3800FF")
        return rightView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "wi_ir_image")
        return arrowImageView
    }()
    
    lazy var cellBtn: UIButton = {
        let cellBtn = UIButton(type: .custom)
        return cellBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(txFiled)
        bgView.addSubview(rightView)
        rightView.addSubview(arrowImageView)
        contentView.addSubview(cellBtn)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(14)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10.pix())
            make.left.equalTo(nameLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(44.pix())
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        txFiled.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12.pix())
        }
        rightView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 38.pix(), height: 44.pix()))
        }
        arrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.pix(), height: 16.pix()))
        }
        cellBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cellClickBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
