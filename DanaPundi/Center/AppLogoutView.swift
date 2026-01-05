//
//  AppLogoutView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AppLogoutView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    
    var leaveBlock: (() -> Void)?
    
    private enum Constants {
        static let bgImageSize = CGSize(width: 295, height: 393)
        static let cancelButtonSize: CGFloat = 30
        static let stayButtonSize = CGSize(width: 267, height: 56)
        static let leaveButtonSize = CGSize(width: 200, height: 12)
        static let leaveButtonBottomOffset: CGFloat = -40
        static let stayButtonBottomOffset: CGFloat = -10
    }
    
    private(set) lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = getBackgroundImage()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private(set) lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.accessibilityIdentifier = "logout_cancel_button"
        return button
    }()
    
    private(set) lazy var stayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.accessibilityIdentifier = "logout_stay_button"
        return button
    }()
    
    private(set) lazy var leaveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.accessibilityIdentifier = "logout_leave_button"
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backgroundImageView)
        
        backgroundImageView.addSubview(cancelButton)
        backgroundImageView.addSubview(leaveButton)
        backgroundImageView.addSubview(stayButton)
    }
    
    private func setupLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Constants.bgImageSize)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(Constants.cancelButtonSize)
        }
        
        leaveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(cancelButton.snp.top).offset(Constants.leaveButtonBottomOffset)
            make.size.equalTo(Constants.leaveButtonSize)
        }
        
        stayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(leaveButton.snp.top).offset(Constants.stayButtonBottomOffset)
            make.size.equalTo(Constants.stayButtonSize)
        }
    }
    
    private func setupBinds() {
        stayButton
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        cancelButton
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        leaveButton
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.leaveBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    private func getBackgroundImage() -> UIImage? {
        let imageName: String
        switch LanguageManager.currentLanguage {
        case .id:
            imageName = "id_out_bg_image"
        default:
            imageName = "en_out_bg_image"
        }
        return UIImage(named: imageName)
    }
    
    func updateBackgroundForCurrentLanguage() {
        backgroundImageView.image = getBackgroundImage()
    }
}
