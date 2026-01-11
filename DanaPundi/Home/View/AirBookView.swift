//
//  AirBookView.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AirBookView: UIView {
    
    // MARK: - Constants
    private enum Constants {
        static let buttonHeight: CGFloat = 58
        static let buttonWidth: CGFloat = 277
        static let verticalSpacing: CGFloat = 15
        static let bottomPadding: CGFloat = 20
        static let nameLabelTopOffset: CGFloat = 150
        static let labelSpacing: CGFloat = 70
        static let lineViewHeight: CGFloat = 18
        static let lineViewBottomOffset: CGFloat = 13
        static let sideButtonOffset: CGFloat = 70
    }
    
    // MARK: - Callbacks
    var applyBlock: ((appearModel) -> Void)?
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    var model: appearModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI Components
    
    // Main Scroll View
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    // Header Image View
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_a_head_image")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // Content Image View
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        let imageName = LanguageManager.currentLanguage == .id ?
        "max_home_b_image" : "home_b_head_image"
        imageView.image = UIImage(named: imageName)
        
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        imageView.addGestureRecognizer(tapGesture)
        
        return imageView
    }()
    
    // Additional Image View (English only)
    private lazy var additionalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_c_head_image")
        return imageView
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
    private lazy var rightButton: UIButton = createSideButton(imageName: "ri_h_image")
    
    // Separator Line
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#D8E1FE")
        return view
    }()
    
    // Main Action Button (overlay)
    private lazy var actionButton: UIButton = {
        return UIButton(type: .custom)
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(scrollView)
        
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(contentImageView)
        
        if LanguageManager.currentLanguage == .en {
            scrollView.addSubview(additionalImageView)
        }
        
        // Add subviews to header image
        [nameLabel, subtitleLabel, valueLabel, applyButton,
         leftButton, rightButton, lineView, actionButton].forEach {
            headerImageView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupHeaderImageViewConstraints()
        setupContentImageViewConstraints()
        
        if LanguageManager.currentLanguage == .en {
            setupAdditionalImageViewConstraints()
        } else {
            setupContentImageAsBottomConstraint()
        }
        
        setupHeaderImageSubviewsConstraints()
    }
    
    private func setupBindings() {
        actionButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self, let model = self.model else { return }
                self.applyBlock?(model)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func handleImageTap() {
        if let model = self.model {
            self.applyBlock?(model)
        }
    }
    
    // MARK: - Constraint Setup Methods
    
    private func setupScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupHeaderImageViewConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 456.pix()))
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupContentImageViewConstraints() {
        contentImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerImageView.snp.bottom).offset(Constants.verticalSpacing)
        }
        
        let contentImageSize = LanguageManager.currentLanguage == .id ?
        CGSize(width: 335.pix(), height: 161.pix()) :
        CGSize(width: 335.pix(), height: 174.pix())
        
        contentImageView.snp.makeConstraints { make in
            make.size.equalTo(contentImageSize)
        }
    }
    
    private func setupAdditionalImageViewConstraints() {
        additionalImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentImageView.snp.bottom).offset(Constants.verticalSpacing)
            make.size.equalTo(CGSize(width: 351.pix(), height: 400.pix()))
            make.bottom.equalToSuperview().offset(-Constants.bottomPadding)
        }
    }
    
    private func setupContentImageAsBottomConstraint() {
        contentImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-Constants.bottomPadding)
        }
    }
    
    private func setupHeaderImageSubviewsConstraints() {
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
            make.right.equalTo(lineView.snp.left)
            make.left.equalToSuperview().offset(30.pix())
            make.centerY.equalTo(lineView)
            make.height.equalTo(16)
        }
        
        rightButton.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right)
            make.right.equalToSuperview().offset(-30.pix())
            make.centerY.equalTo(lineView)
            make.height.equalTo(16)
        }
        
        // Overlay Action Button
        actionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - UI Update
    
    private func updateUI() {
        guard let model = model else { return }
        
        nameLabel.text = model.jugespecially
        subtitleLabel.text = model.tornation
        valueLabel.text = model.urous
        applyButton.setTitle(model.fraterbedform, for: .normal)
        leftButton.setTitle(model.overitor, for: .normal)
        rightButton.setTitle(model.federalesque, for: .normal)
    }
    
    // MARK: - Factory Methods
    
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
