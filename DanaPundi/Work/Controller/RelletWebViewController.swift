//
//  RelletWebViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa
import StoreKit

class RelletWebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = HomeViewModel()
    
    private let progressView = UIProgressView(progressViewStyle: .bar)
    
    private let locationManager = OneTimeLocationManager()
    
    lazy var wkWebView: WKWebView = {
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        let jsMethods = [
            "sollise",
            "archacreateice",
            "egriness",
            "xyl",
            "pastdom",
            "betweenot"
        ]
        
        jsMethods.forEach {
            userContentController.add(self, name: $0)
        }
        
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = .clear
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindWebView()
        loadPage()
        
    }
    
}

extension RelletWebViewController {
    
    private func setupUI() {
        
        view.addSubview(headView)
        headView.nameLabel.textColor = UIColor(hexString: "#FFFFFF")
        headView.contentView.backgroundColor = UIColor(hexString: "#686CFF")
        headView.statusBarView.backgroundColor = UIColor(hexString: "#686CFF")
        headView.backBtn.setImage(UIImage(named: "wh_ad_b_image"), for: .normal)
        
        headView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headView.snp.bottom)
        }
        
        view.addSubview(progressView)
        progressView.trackTintColor = .clear
        progressView.progressTintColor = .green
        
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(wkWebView)
            make.height.equalTo(2)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.wkWebView.canGoBack {
                self.wkWebView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
}

extension RelletWebViewController {
    
    private func bindWebView() {
        
        wkWebView.rx.observe(String.self, "title")
            .compactMap { $0 }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind { [weak self] title in
                self?.headView.nameLabel.text = title
            }
            .disposed(by: disposeBag)
        
        wkWebView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .bind { [weak self] progress in
                self?.progressView.isHidden = progress >= 1.0
                self?.progressView.setProgress(Float(progress), animated: true)
                
                if progress >= 1.0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self?.progressView.setProgress(0, animated: false)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}

extension RelletWebViewController {
    
    private func loadPage() {
        let apiUrl = APIRequestBuilder.buildURLString(api: pageUrl) ?? ""
        guard let url = URL(string: apiUrl) else { return }
        print("apiUrl===\(apiUrl)")
        wkWebView.load(URLRequest(url: url))
    }
}

extension RelletWebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        
        print("JS==name==:", message.name)
        print("JS==para==:", message.body)
        
        switch message.name {
            
        case "sollise":
            handleSollise(message.body as? [String] ?? [])
            
        case "archacreateice":
            handleArchacreateice(message.body)
            
        case "egriness":
            handleEgriness(message.body)
            
        case "xyl":
            handleXyl(message.body)
            
        case "pastdom":
            handlePastdom(message.body)
            
        case "betweenot":
            handleBetweenot(message.body)
            
        default:
            break
        }
    }
}

extension RelletWebViewController {
    
    private func handleSollise(_ body: [String]) {
        
        locationManager.locateOnce { result in }
        
        let productID = body.first ?? ""
        let orderID = body.last ?? ""
        Task {
            await self.twoLocino(productID: productID, orderID: orderID)
        }
    }
    
    private func handleArchacreateice(_ body: Any) {
        guard let pageUrl = body as? String, !pageUrl.isEmpty else { return }
        self.goPageUrl(with: pageUrl)
    }
    
    private func handleEgriness(_ body: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func handleXyl(_ body: Any) {
        self.notiRootVc(with: "0")
    }
    
    private func handlePastdom(_ body: Any) {
        guard let email = body as? String, !email.isEmpty else { return }
        sendEmailInfo(with: email)
    }
    
    private func handleBetweenot(_ body: Any) {
        self.toAppStore()
    }
}

extension RelletWebViewController {
    
    func toAppStore() {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
    func sendEmailInfo(with email: String) {
        let phone = SaveLoginInfo.getPhone() ?? ""
        let body = "Dana Pundi: \(phone)"
        
        guard let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let emailURL = URL(string: "mailto:\(email)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(emailURL) else {
            return
        }
        
        UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
    }
    
    func goPageUrl(with pageUrl: String) {
        if pageUrl.isEmpty {
            return
        }
        if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
            URLSchemeRouter.handle(pageURL: pageUrl, from: self)
        } else if pageUrl.hasPrefix("http") || pageUrl.hasPrefix("https") {
            self.pageUrl = pageUrl
            loadPage()
        }
    }
    
    private func twoLocino(productID: String,
                           orderID: String) async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        let lon = LocationStorage.getLon() ?? ""
        let lat = LocationStorage.getLat() ?? ""
        let parameters = ["stichette": productID,
                          "designetic": orderID,
                          "sideile": String(Int(9)),
                          "violenceitude": lon,
                          "stultiia": lat,
                          "cupety": String(Int(Date().timeIntervalSince1970)),
                          "put": String(Int(Date().timeIntervalSince1970))]
        await self.upKeyerConfig(with: viewModel, parameters: parameters)
    }
}
