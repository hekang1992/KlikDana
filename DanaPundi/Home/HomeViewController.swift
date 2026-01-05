//
//  HomeViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    lazy var airView: AirBookView = {
        let airView = AirBookView(frame: .zero)
        return airView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(airView)
        airView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        airView.applyBlock = { [weak self] model in
            guard let self = self else { return }
            Task {
                await self.applyProductInfo(with: model)
            }
        }
        
        airView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.homeInfo()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.homeInfo()
        }
    }
    
}

extension HomeViewController {
    
    private func homeInfo() async {
        do {
            let model = try await viewModel.homeApi()
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let modelArray = model.anyably?.ruspay ?? []
                if let ligItem = modelArray.first(where: { $0.stenics == "lig" }) {
                    let appearArray = ligItem.appear ?? []
                    self.airView.model = appearArray.first
                }
            }
            await MainActor.run {
                self.airView.scrollView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.airView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func applyProductInfo(with model: appearModel) async {
        
    }
    
}
