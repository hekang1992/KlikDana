//
//  MaxBnnViewCell.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MaxBnnViewCell: UITableViewCell {
    
    var model: appearModel? {
        didSet {
            guard let model = model else { return }
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var cellClickBlock: (() -> Void)?
    
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
    
    lazy var cellClickBtn: UIButton = {
        let cellClickBtn = UIButton(type: .custom)
        return cellClickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(laImageView)
        bgView.addSubview(cellClickBtn)
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
        cellClickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellClickBtn
            .rx
            .tap
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
