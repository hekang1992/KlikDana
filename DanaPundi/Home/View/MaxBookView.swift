//
//  MaxBookView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

import UIKit
import SnapKit

class MaxBookView: UIView {
    
    private struct Constants {
        static let headCellID = "MaxHeadViewCell"
        static let bannerCellID = "MaxBnnViewCell"
        static let productCellID = "MaxProductViewCell"
        
        static let headType = "eemee"
        static let bannerType = "recentable"
        static let productType = "trainingent"
    }
    
    var cellClickBlock: ((appearModel) -> Void)?
    
    var modelArray: [olModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(MaxHeadViewCell.self, forCellReuseIdentifier: Constants.headCellID)
        tableView.register(MaxBnnViewCell.self, forCellReuseIdentifier: Constants.bannerCellID)
        tableView.register(MaxProductViewCell.self, forCellReuseIdentifier: Constants.productCellID)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func getCellType(for section: Int) -> String? {
        return modelArray?[section].stenics
    }
}

extension MaxBookView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellType = getCellType(for: section) else { return 0 }
        
        if cellType == Constants.bannerType {
            return 1
        } else {
            return modelArray?[section].appear?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = getCellType(for: indexPath.section) else {
            return UITableViewCell()
        }
        let model = modelArray?[indexPath.section].appear?[indexPath.row]
        if cellType == Constants.headType {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.headCellID, for: indexPath) as! MaxHeadViewCell
            cell.model = model
            cell.cellClickBlock = { [weak self] in
                guard let self = self, let model = model else { return }
                self.cellClickBlock?(model)
            }
            return cell
            
        } else if cellType == Constants.bannerType {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bannerCellID, for: indexPath) as! MaxBnnViewCell
            cell.model = model
            cell.cellClickBlock = { [weak self] in
                guard let self = self, let model = model else { return }
                self.cellClickBlock?(model)
            }
            return cell
            
        } else if cellType == Constants.productType {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.productCellID, for: indexPath) as! MaxProductViewCell
            cell.model = model
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = modelArray?[indexPath.section].appear?[indexPath.row] {
            self.cellClickBlock?(model)
        }
    }
}
