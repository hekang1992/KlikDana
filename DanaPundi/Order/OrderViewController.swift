//
//  OrderViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class OrderViewController: BaseViewController {
    
    lazy var orderView: OrderView = {
        let orderView = OrderView(frame: .zero)
        return orderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(orderView)
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
