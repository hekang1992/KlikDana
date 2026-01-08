//
//  CleanTableViewCell.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/7.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CleanTableViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    var enterTextChanged: ((String?) -> Void)?
    
    var model: olModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.canfy ?? ""
            txFiled.placeholder = model.actship ?? ""
            txFiled.text = model.hiblaughdom ?? ""
            let aristition = model.aristition ?? ""
            txFiled.keyboardType = aristition == "1" ? .numberPad : .default
        }
    }
    
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
        return txFiled
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(txFiled)
        
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
        
        txFiled.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                self.enterTextChanged?(text)
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CleanTableViewCell {
    
}
