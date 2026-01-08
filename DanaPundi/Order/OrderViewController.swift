//
//  OrderViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import UIKit
import SnapKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    var type: String = "4"
    
    private let viewModel = HomeViewModel()
    
    lazy var orderView: OrderView = {
        let orderView = OrderView(frame: .zero)
        return orderView
    }()
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView(frame: .zero)
        emptyView.layer.cornerRadius = 20.pix()
        emptyView.layer.masksToBounds = true
        emptyView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        emptyView.isHidden = false
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92.pix())
            make.left.right.equalToSuperview().inset(20.pix())
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20.pix())
        }
        
        orderView.typeBlock = { [weak self] type in
            guard let self = self else { return }
            self.type = type
            Task {
                await self.orderListInfo(with: type)
            }
        }
        
        orderView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.corollel ?? ""
            if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
                URLSchemeRouter.handle(pageURL: pageUrl, from: self)
            }else if pageUrl.hasPrefix("http") || pageUrl.hasPrefix("https") {
                self.goRelletWebVc(with: pageUrl)
            }else {
                
            }
        }
        
        orderView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.orderListInfo(with: self.type)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.orderListInfo(with: type)
        }
    }
}

extension OrderViewController {
    
    private func orderListInfo(with type: String) async {
        do {
            let parameters = ["wrongeer": type, "almostably": "1", "one": "100"]
            let model = try await viewModel.orderListApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let modelArray = model.anyably?.ruspay ?? []
                if modelArray.count > 0 {
                    self.emptyView.isHidden = true
                }else {
                    self.emptyView.isHidden = false
                }
                self.orderView.modelArray = modelArray
                self.orderView.tableView.reloadData()
            }
            await self.orderView.tableView.mj_header?.endRefreshing()
        } catch {
            await self.orderView.tableView.mj_header?.endRefreshing()
        }
    }
    
}
