//
//  LaunchViewController.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class LaunchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_app_image")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.notiRootVc()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
