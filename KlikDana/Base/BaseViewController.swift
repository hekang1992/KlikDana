//
//  BaseViewController.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit

class BaseViewController: UIViewController {

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
