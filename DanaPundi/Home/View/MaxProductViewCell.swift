//
//  MaxProductViewCell.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import UIKit
import SnapKit

class MaxProductViewCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 20.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        return bgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 96.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
