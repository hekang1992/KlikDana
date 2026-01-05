//
//  LoginViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    private var countdownTimer: Timer?
    private var countdownSeconds = 60
    private let totalCountdownSeconds = 60
    private let viewModel = LoginViewModel()
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCountdown()
    }
    
    @MainActor
    deinit {
        stopCountdown()
    }
    
    private func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        loginView.codeBtn.addTarget(self, action: #selector(codeButtonTapped), for: .touchUpInside)
        loginView.loginBtn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func startCountdown() {
        countdownSeconds = totalCountdownSeconds
        loginView.codeBtn.isEnabled = false
        loginView.codeBtn.setTitle("\(countdownSeconds)s", for: .normal)
        
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateCountdown),
            userInfo: nil,
            repeats: true
        )
        
        RunLoop.main.add(countdownTimer!, forMode: .common)
    }
    
    @objc private func updateCountdown() {
        countdownSeconds -= 1
        
        if countdownSeconds > 0 {
            loginView.codeBtn.setTitle("\(countdownSeconds)s", for: .normal)
        } else {
            stopCountdown()
            resetCodeButton()
        }
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    private func resetCodeButton() {
        loginView.codeBtn.isEnabled = true
        loginView.codeBtn.setTitle(LanguageManager.localizedString(for: "Send Code"), for: .normal)
    }
    
}

extension LoginViewController {
    
    @objc private func codeButtonTapped() {
        guard let phone = loginView.phoneTx.text, !phone.isEmpty else {
            ToastManager.showMessage(LanguageManager.localizedString(for: "Enter your number"))
            return
        }
        
        sendVerificationCode(to: phone)
    }
    
    @objc private func loginButtonTapped() {
        guard let phone = loginView.phoneTx.text, !phone.isEmpty else {
            ToastManager.showMessage(LanguageManager.localizedString(for: "Enter your number"))
            return
        }
        
        guard let code = loginView.codeTx.text, !code.isEmpty else {
            ToastManager.showMessage(LanguageManager.localizedString(for: "Please enter"))
            return
        }
        
        self.loginView.phoneTx.resignFirstResponder()
        self.loginView.codeTx.resignFirstResponder()
        
        loginInfo(to: phone, code: code)
    }
    
    private func sendVerificationCode(to phone: String) {
        
        Task {
            do {
                let parameters = ["paginitor": phone, "vid": "1"]
                let model = try await viewModel.codeApi(parameters: parameters)
                let peaceent = model.peaceent ?? ""
                if peaceent == "0" || peaceent == "00" {
                    self.loginView.codeTx.becomeFirstResponder()
                    self.startCountdown()
                }
                ToastManager.showMessage(model.cubage ?? "")
            } catch {
                
            }
        }
        
    }
    
    private func loginInfo(to phone: String, code: String) {
        
        Task {
            do {
                let parameters = ["radiwise": phone,
                                  "secondion": code,
                                  "western": "1"]
                let model = try await viewModel.loginApi(parameters: parameters)
                let peaceent = model.peaceent ?? ""
                ToastManager.showMessage(model.cubage ?? "")
                if peaceent == "0" || peaceent == "00" {
                    let radiwise = model.anyably?.radiwise ?? ""
                    let pacho = model.anyably?.pacho ?? ""
                    SaveLoginInfo.saveLoginInfo(phone: radiwise, token: pacho)
                    try? await Task.sleep(nanoseconds: 250_000_000)
                    self.notiRootVc()
                }
            } catch {
                
            }
        }
        
    }
    
}
