//
//  LaunchViewController.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class LaunchViewController: BaseViewController {
    
    private let viewModel = LaunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_app_image")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        NetworkMonitor.shared.startListening { [weak self] status in
            if status == .reachableViaCellular || status == .reachableViaWiFi {
                guard let self = self else { return }
                NetworkMonitor.shared.stopListening()
                Task {
                    await self.initInfo()
                }
            }
        }
        
        
    }
    
}

extension LaunchViewController {
    
    private func initInfo() async {
        do {
            let parameters = LaunchUtils.allInfo()
            let model = try await viewModel.launchInfo(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let controlety = model.anyably?.controlety ?? ""
                LanguageManager.setLanguage(code: controlety)
                self.notiRootVc()
            }
        } catch {
            
        }
    }
}
