//
//  RelletWebViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import UIKit
import WebKit
import SnapKit
import RxSwift
import RxCocoa

class RelletWebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let disposeBag = DisposeBag()
    
    private let progressView = UIProgressView(progressViewStyle: .bar)
    
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

extension RelletWebViewController {
    
    private func handleSollise(_ body: Any) {
        print("处理 sollise")
    }
    
    private func handleArchacreateice(_ body: Any) {
        print("处理 archacreateice")
    }
    
    private func handleEgriness(_ body: Any) {
        print("处理 egriness")
    }
    
    private func handleXyl(_ body: Any) {
        print("处理 xyl")
    }
    
    private func handlePastdom(_ body: Any) {
        print("处理 pastdom")
    }
    
    private func handleBetweenot(_ body: Any) {
        print("处理 betweenot")
    }
}
