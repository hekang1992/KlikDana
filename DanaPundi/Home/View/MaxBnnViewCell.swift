//
//  MaxBnnViewCell.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import UIKit
import SnapKit

class MaxBnnViewCell: UITableViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ma_ba_bg_image")
        return bgImageView
    }()
    
    lazy var laImageView: UIImageView = {
        let laImageView = UIImageView()
        laImageView.image = UIImage(named: "ma_la_bg_image")
        return laImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(laImageView)
        bgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44.pix())
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 44.pix()))
        }
        laImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.size.equalTo(CGSize(width: 25.pix(), height: 28.pix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
