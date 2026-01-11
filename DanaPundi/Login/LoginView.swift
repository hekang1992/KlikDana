//
//  LoginView.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    var ameBlock: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = LanguageManager.localizedString(for: "Secure Login")
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight(900))
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        descLabel.text = LanguageManager.localizedString(for: "Manage your loans, repayments and limits in one place")
        descLabel.textColor = UIColor.init(hexString: "#666666")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        return descLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_desc_image")
        return bgImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.text = LanguageManager.localizedString(for: "Phone Number")
        oneLabel.textColor = UIColor.init(hexString: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 15
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = .white
        return oneView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Enter your number"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#666666") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(400))
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(600))
        phoneTx.textColor = UIColor.init(hexString: "#000000")
        phoneTx.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        phoneTx.leftViewMode = .always
        return phoneTx
    }()

    lazy var nationImageView: UIImageView = {
        let nationImageView = UIImageView()
        let code = LanguageManager.currentLanguage
        nationImageView.image = code == .id ? UIImage(named: "id_nation_image") : UIImage(named: "en_nation_image")
        nationImageView.contentMode = .scaleAspectFit
        return nationImageView
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.text = LanguageManager.localizedString(for: "Verification Code")
        twoLabel.textColor = UIColor.init(hexString: "#000000")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 15
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = .white
        return twoView
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LanguageManager.localizedString(for: "Please enter"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#666666") as Any,
            .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(400))
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(600))
        codeTx.textColor = UIColor.init(hexString: "#000000")
        codeTx.leftView = UIView(frame: CGRectMake(0, 0, 15, 10))
        codeTx.leftViewMode = .always
        return codeTx
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle(LanguageManager.localizedString(for: "Send Code"), for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.backgroundColor = UIColor.init(hexString: "#3800FF")
        codeBtn.layer.cornerRadius = 12
        codeBtn.layer.masksToBounds = true
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle(LanguageManager.localizedString(for: "Log in"), for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(900))
        loginBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        loginBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 7, right: 0)
        return loginBtn
    }()
    
    lazy var agreementBtn: UIButton = {
        let agreementBtn = UIButton(type: .custom)
        agreementBtn.isSelected = true
        agreementBtn.setImage(UIImage(named: "btn_nor_image"), for: .normal)
        agreementBtn.setImage(UIImage(named: "btn_sel_image"), for: .selected)
        agreementBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return agreementBtn
    }()
    
    lazy var agreementLabel: UILabel = {
        let agreementLabel = UILabel()
        agreementLabel.text = LanguageManager.localizedString(for: "Confirm and agree to the <Privacy Agreement>")
        agreementLabel.textAlignment = .left
        agreementLabel.textColor = .black
        agreementLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(400))
        agreementLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(agreeLabelTapped))
        agreementLabel.addGestureRecognizer(tapGesture)
        return agreementLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descLabel)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(oneLabel)
        scrollView.addSubview(oneView)
        oneView.addSubview(phoneTx)
        oneView.addSubview(nationImageView)
        scrollView.addSubview(twoLabel)
        scrollView.addSubview(twoView)
        twoView.addSubview(codeTx)
        twoView.addSubview(codeBtn)
        scrollView.addSubview(loginBtn)
        scrollView.addSubview(agreementBtn)
        scrollView.addSubview(agreementLabel)
        
        let languageCode = LanguageManager.currentLanguage
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(54)
            make.height.equalTo(28)
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(239)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        bgImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 303, height: 194))
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(26)
        }
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(35)
            make.height.equalTo(14)
        }
        oneView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.left.equalTo(oneLabel)
            make.height.equalTo(54)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-100)
        }
        nationImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 60, height: 24))
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(20)
            make.left.equalTo(oneLabel)
            make.height.equalTo(14)
        }
        twoView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.left.equalTo(oneLabel)
            make.height.equalTo(54)
        }
        codeTx.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-100)
        }
        codeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 74, height: 36))
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoView.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 317, height: 56))
        }
        agreementBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 14, height: 14))
            if languageCode == .id {
                make.left.equalToSuperview().offset(60)
            }else {
                make.left.equalToSuperview().offset(35)
            }
            make.top.equalTo(loginBtn.snp.bottom).offset(50)
        }
        agreementLabel.snp.makeConstraints { make in
            make.top.equalTo(agreementBtn)
            make.left.equalTo(agreementBtn.snp.right).offset(5)
            if languageCode == .id {
                make.width.equalTo(UIScreen.main.bounds.size.width - 90)
            }else {
                make.width.equalTo(UIScreen.main.bounds.size.width - 70)
            }
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    @objc func agreeLabelTapped() {
        self.ameBlock?()
    }
    
    @objc func btnClick() {
        agreementBtn.isSelected.toggle()
    }
    
}
