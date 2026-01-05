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
    
}
