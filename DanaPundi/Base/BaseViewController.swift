//
//  BaseViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit

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
                    
                default:
                    break
                }
                
            }
        } catch {
            
        }
    }
    
    func orderApply(with model: BaseModel) async {
        
    }
    
}
