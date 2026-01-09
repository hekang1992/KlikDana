//
//  BaseViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import UIKit
import TYAlertController

class BaseViewController: UIViewController {
    
    lazy var headView: CustomHeadView = {
        let headView = CustomHeadView(frame: .zero)
        return headView
    }()
    
    let languageCode = LanguageManager.currentLanguage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#DAEBFF")
    }
    
}

extension BaseViewController {
    
    func keepLeaveView() {
        let popView = AppLogoutView(frame: self.view.bounds)
        popView.backgroundImageView.image = LanguageManager.currentLanguage == .id ? UIImage(named: "kep_id_l_image") : UIImage(named: "kep_en_l_image")
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
            self.dismiss(animated: true) {}
            self.backDetailPageVc()
        }
    }
    
}

extension BaseViewController {
    
    func goRelletWebVc(with pageUrl: String) {
        let webVc = RelletWebViewController()
        webVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
}

extension BaseViewController {
    
    /// noti_root_vc
    func notiRootVc() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil
            )
        }
    }
    
    /// back_detail_page
    func backDetailPageVc() {
        guard let nav = navigationController,
              let productVC = nav.viewControllers.first(where: { $0 is ProductViewController })
        else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        nav.popToViewController(productVC, animated: true)
    }
    
    func detailPageInfo(with productID: String,
                        orderID: String,
                        viewMdoel: HomeViewModel) async {
        do {
            let parameters = ["seget": productID, "idea": "1"]
            let model = try await viewMdoel.detailApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let mostess = model.anyably?.cortwhiteible?.mostess ?? ""
                let canfy = model.anyably?.cortwhiteible?.canfy ?? ""
                
                switch mostess {
                case "pathtic":
                    break
                    
                case "accept":
                    let workVc = WorkViewController()
                    workVc.productID = productID
                    workVc.appTitle = canfy
                    workVc.orderID = orderID
                    self.navigationController?.pushViewController(workVc, animated: true)
                    
                case "thermtrade":
                    let contactVc = ContactViewController()
                    contactVc.productID = productID
                    contactVc.appTitle = canfy
                    contactVc.orderID = orderID
                    self.navigationController?.pushViewController(contactVc, animated: true)
                    
                case "thalass":
                    let walletVc = WalletViewController()
                    walletVc.productID = productID
                    walletVc.appTitle = canfy
                    walletVc.orderID = orderID
                    self.navigationController?.pushViewController(walletVc, animated: true)
                    
                case "":
                    Task {
                        await self.orderApply(with: model,
                                              viewModel: viewMdoel,
                                              productID: productID)
                    }
                    
                default:
                    break
                }
                
            }
        } catch {
            
        }
    }
    
    func orderApply(with model: BaseModel,
                    viewModel: HomeViewModel,
                    productID: String) async {
        let ogy = model.anyably?.recentable?.designetic ?? ""
        let vadant = model.anyably?.recentable?.vadant ?? ""
        let plas = model.anyably?.recentable?.plas ?? ""
        let gestspecial = model.anyably?.recentable?.gestspecial ?? ""
        let ramer = SaveLoginInfo.getPhone() ?? ""
        let rockive = "1"
        do {
            let parameters = ["ogy": ogy,
                              "vadant": vadant,
                              "plas": plas,
                              "gestspecial": gestspecial,
                              "ramer": ramer,
                              "rockive": rockive]
            let model = try await viewModel.toOrderApplyApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let semaair = model.anyably?.semaair ?? ""
                if semaair.hasPrefix(DeepLinkRoute.scheme_url) {
                    URLSchemeRouter.handle(pageURL: semaair, from: self)
                }else if semaair.hasPrefix("http") || semaair.hasPrefix("https") {
                    self.goRelletWebVc(with: semaair)
                }
            }
            await self.twoLocino(viewModel: viewModel,
                                 productID: productID,
                                 orderID: ogy)
        } catch  {
            
        }
    }
    
}

extension BaseViewController {
    
    func upKeyerConfig(with viewModel: HomeViewModel, parameters: [String: String]) async {
        do {
            let _ = try await viewModel.uploadKeyerApi(parameters: parameters)
        } catch {
            
        }
    }
    
    private func twoLocino(viewModel: HomeViewModel,
                           productID: String,
                           orderID: String) async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        let lon = LocationStorage.getLon() ?? ""
        let lat = LocationStorage.getLat() ?? ""
        let parameters = ["stichette": productID,
                          "designetic": orderID,
                          "sideile": String(Int(8)),
                          "violenceitude": lon,
                          "stultiia": lat,
                          "cupety": String(Int(Date().timeIntervalSince1970)),
                          "put": String(Int(Date().timeIntervalSince1970))]
        await self.upKeyerConfig(with: viewModel, parameters: parameters)
    }
    
}
