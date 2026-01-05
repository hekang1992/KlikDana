//
//  H5WebViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa

class H5WebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let disposeBag = DisposeBag()
    
    private lazy var progressView: UIProgressView = {
        let v = UIProgressView(progressViewStyle: .default)
        v.progress = 0
        return v
    }()
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let userContent = WKUserContentController()
        
        [
            "sollise",
            "archacreateice",
            "egriness",
            "xyl",
            "pastdom",
            "betweenot"
        ].forEach {
            userContent.add(self, name: $0)
        }
        
        config.userContentController = userContent
        let web = WKWebView(frame: .zero, configuration: config)
        web.allowsBackForwardNavigationGestures = true
        web.navigationDelegate = self
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindWebView()
        loadRequest()
    }
    
    @MainActor
    deinit {
        webView.configuration.userContentController.removeAllScriptMessageHandlers()
    }
}

private extension H5WebViewController {
    
    func setupUI() {
        view.addSubview(headView)
        view.addSubview(webView)
        view.addSubview(progressView)
        
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

private extension H5WebViewController {
    
    func bindWebView() {
        
        webView.rx.observe(String.self, "title")
            .compactMap { $0 }
            .bind(onNext: { [weak self] title in
                self?.headView.nameLabel.text = title
            })
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .bind(onNext: { [weak self] progress in
                self?.progressView.progress = Float(progress)
                self?.progressView.isHidden = progress >= 1.0
            })
            .disposed(by: disposeBag)
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

private extension H5WebViewController {
    
    func loadRequest() {
        let apiUrl = APIRequestBuilder.buildURLString(api: pageUrl) ?? ""
        guard let url = URL(string: apiUrl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension H5WebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        self.progressView.isHidden = true
    }
    
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        
        switch message.name {
            
        case "sollise":
            handleSollise(message.body)
            
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

private extension H5WebViewController {
    
    func handleSollise(_ body: Any) {
        print("sollise:", body)
    }
    
    func handleArchacreateice(_ body: Any) {
        print("archacreateice:", body)
    }
    
    func handleEgriness(_ body: Any) {
        print("egriness:", body)
    }
    
    func handleXyl(_ body: Any) {
        print("xyl:", body)
    }
    
    func handlePastdom(_ body: Any) {
        print("pastdom:", body)
    }
    
    func handleBetweenot(_ body: Any) {
        print("betweenot:", body)
    }
}
