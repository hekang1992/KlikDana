//
//  MaxHeadViewCell.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MaxHeadViewCell: UITableViewCell {
    
    private enum Constants {
        static let buttonHeight: CGFloat = 58
        static let buttonWidth: CGFloat = 277
        static let verticalSpacing: CGFloat = 15
        static let bottomPadding: CGFloat = 20
        static let nameLabelTopOffset: CGFloat = 30
        static let labelSpacing: CGFloat = 70
        static let lineViewHeight: CGFloat = 18
        static let lineViewBottomOffset: CGFloat = 13
        static let sideButtonOffset: CGFloat = 40
    }
    
    private let disposeBag = DisposeBag()
    
    var cellClickBlock: (() -> Void)?
    
    var model: appearModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.jugespecially
            subtitleLabel.text = model.tornation
            valueLabel.text = model.urous
            applyButton.setTitle(model.fraterbedform, for: .normal)
            leftButton.setTitle(model.overitor, for: .normal)
            rightButton.setTitle(model.federalesque, for: .normal)
        }
    }

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "max_he_bg_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    // Labels
    private lazy var nameLabel: UILabel = createLabel(
        font: .systemFont(ofSize: 18, weight: .medium),
        color: UIColor(hexString: "#FFFFFF"),
        alignment: .center
    )
    
    private lazy var subtitleLabel: UILabel = createLabel(
        font: .systemFont(ofSize: 16, weight: UIFont.Weight(700)),
        color: UIColor(hexString: "#000000"),
        alignment: .center
    )
    
    private lazy var valueLabel: UILabel = createLabel(
        font: .systemFont(ofSize: 60, weight: .bold),
        color: UIColor(hexString: "#3800FF"),
        alignment: .center
    )
    
    // Buttons
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .black)
        button.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15.pix(), right: 0)
        return button
    }()
    
    private lazy var leftButton: UIButton = createSideButton(imageName: "le_h_image")
    private lazy var rightButton: UIButton = createSideButton(imageName: "le_h_image")
    
    // Separator Line
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#D8E1FE")
        return view
    }()
    
    lazy var cellClickBtn: UIButton = {
        let cellClickBtn = UIButton(type: .custom)
        return cellClickBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(subtitleLabel)
        bgImageView.addSubview(valueLabel)
        bgImageView.addSubview(applyButton)
        bgImageView.addSubview(leftButton)
        bgImageView.addSubview(rightButton)
        bgImageView.addSubview(lineView)
        bgImageView.addSubview(cellClickBtn)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 333.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        
        // Name Label
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.nameLabelTopOffset.pix())
            make.height.equalTo(20.pix())
        }
        
        // Subtitle Label
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.labelSpacing.pix())
            make.height.equalTo(16.pix())
            make.centerX.equalToSuperview()
        }
        
        // Value Label
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(19.pix())
            make.centerX.equalToSuperview()
            make.height.equalTo(68.pix())
        }
        
        // Apply Button
        applyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(valueLabel.snp.bottom).offset(13.pix())
            make.size.equalTo(CGSize(
                width: Constants.buttonWidth.pix(),
                height: Constants.buttonHeight.pix()
            ))
        }
        
        // Side Buttons and Line
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Constants.lineViewBottomOffset.pix())
            make.size.equalTo(CGSize(width: 1.pix(), height: Constants.lineViewHeight.pix()))
        }
        
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constants.sideButtonOffset.pix())
            make.centerY.equalTo(lineView)
            make.height.equalTo(16)
        }
        
        rightButton.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(44.pix())
            make.centerY.equalTo(lineView)
            make.height.equalTo(16)
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

extension MaxHeadViewCell {
    
    private func createLabel(font: UIFont, color: UIColor?, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.textColor = color
        label.font = font
        return label
    }
    
    private func createSideButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        return button
    }
    
}
