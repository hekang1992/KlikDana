//
//  MineViewController.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit
import MJRefresh

class MineViewController: BaseViewController {
    
    private let viewModel = MineViewModel()
    
    lazy var mineView: MineView = {
        let mineView = MineView(frame: .zero)
        return mineView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mineView)
        mineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mineView.cellBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if pageUrl.hasPrefix("http") {
                let webVc = H5WebViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
        self.mineView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.centerInfo()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.centerInfo()
        }
    }

}

extension MineViewController {
    
    private func centerInfo() async {
        do {
            let model = try await viewModel.centerApi()
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let listArray = model.anyably?.pharmacivity ?? []
                self.mineView.listArray = listArray
            }
            self.mineView.tableView.reloadData()
            await self.mineView.tableView.mj_header?.endRefreshing()
        } catch {
            await self.mineView.tableView.mj_header?.endRefreshing()
        }
    }
    
}
