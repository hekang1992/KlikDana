//
//  SettingViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/5.
//

import UIKit
import SnapKit
import TYAlertController

class SettingViewController: BaseViewController {
    
    private let viewModel = MineViewModel()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "v_icon_image")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LanguageManager.localizedString(for: "Versions")
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return nameLabel
    }()
    
    lazy var versionLabel: UILabel = {
        let versionLabel = UILabel()
        versionLabel.textAlignment = .right
        versionLabel.textColor = UIColor.init(hexString: "#000000")
        versionLabel.text = "1.0.0"
        versionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return versionLabel
    }()
    
    lazy var outView: UIView = {
        let outView = UIView()
        outView.layer.cornerRadius = 15
        outView.layer.masksToBounds = true
        outView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return outView
    }()
    
    lazy var outImageView: UIImageView = {
        let outImageView = UIImageView()
        outImageView.image = UIImage(named: "t_icon_image")
        return outImageView
    }()
    
    lazy var outLabel: UILabel = {
        let outLabel = UILabel()
        outLabel.textAlignment = .left
        outLabel.text = LanguageManager.localizedString(for: "Go out")
        outLabel.textColor = UIColor.init(hexString: "#000000")
        outLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return outLabel
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "arrow_icon_image")
        return arrowImageView
    }()
    
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.setTitle("Deregister account", for: .normal)
        deleteBtn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        deleteBtn.setImage(UIImage(named: "de_icon_image"), for: .normal)
        deleteBtn.isHidden = false
        deleteBtn.semanticContentAttribute = .forceLeftToRight
        deleteBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        deleteBtn.addTarget(self, action: #selector(deleteBtnClick), for: .touchUpInside)
        deleteBtn.isHidden = true
        return deleteBtn
    }()
    
    lazy var outBtn: UIButton = {
        let outBtn = UIButton(type: .custom)
        outBtn.addTarget(self, action: #selector(outBtnClick), for: .touchUpInside)
        return outBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headView)
        headView.configTitle(with: LanguageManager.localizedString(for: "Set up"))
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        
        view.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(versionLabel)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(25)
            make.height.equalTo(68)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(48)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(20)
        }
        versionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(100)
        }
        
        view.addSubview(outView)
        outView.addSubview(outImageView)
        outView.addSubview(outLabel)
        outView.addSubview(arrowImageView)
        view.addSubview(outBtn)
        outView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(14)
            make.height.equalTo(68)
        }
        outImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(48)
        }
        outLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(20)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 8, height: 16))
        }
        outBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(14)
            make.height.equalTo(68)
        }
        
        view.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 140, height: 16))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        deleteBtn.isHidden = LanguageManager.currentLanguage == .id
        
    }
    
    @MainActor
    deinit {
        print("SettingViewController---deinit---")
    }
    
}

extension SettingViewController {
    
    @objc func deleteBtnClick() {
        let popView = AppDeleteView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.leaveBlock = { [weak self] in
            guard let self = self else { return }
            if popView.grand == false {
                ToastManager.showMessage(LanguageManager.localizedString(for: "Please confirm the account closure agreement first."))
                return
            }
            Task {
                await self.deleteInfo()
            }
        }
    }
    
    @objc func outBtnClick() {
        let popView = AppLogoutView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.cBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.leaveBlock = { [weak self] in
            guard let self = self else { return }
            Task {
                await self.logoutInfo()
            }
        }
    }
    
}

extension SettingViewController {
    
    private func logoutInfo() async {
        do {
            let model = try await viewModel.logoutApi()
            let peaceent = model.peaceent ?? ""
            ToastManager.showMessage(model.cubage ?? "")
            if peaceent == "0" || peaceent == "00" {
                self.dismiss(animated: true) {
                    SaveLoginInfo.deleteLoginInfo()
                    self.notiRootVc(with: "0")
                }
            }
        } catch {
            
        }
    }
    
    private func deleteInfo() async {
        do {
            let model = try await viewModel.deleteAccountApi()
            let peaceent = model.peaceent ?? ""
            ToastManager.showMessage(model.cubage ?? "")
            if peaceent == "0" || peaceent == "00" {
                self.dismiss(animated: true) {
                    SaveLoginInfo.deleteLoginInfo()
                    self.notiRootVc(with: "0")
                }
            }
        } catch {
            
        }
    }
    
}
