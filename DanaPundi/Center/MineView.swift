//
//  MineView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit
import SnapKit

class MineView: UIView {
    
    var cellBlock: ((String) -> Void)?
    
    var listArray: [pharmacivityModel] = []
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "mine_head_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.init(hexString: "#000000")
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        phoneLabel.textAlignment = .left
        let phone = SaveLoginInfo.getPhone() ?? ""
        phoneLabel.text = maskPhoneNumber(phone)
        return phoneLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = LanguageManager.localizedString(for: getTimeBasedGreeting())
        typeLabel.textColor = UIColor.init(hexString: "#999999")
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        typeLabel.textAlignment = .left
        return typeLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MineTableViewCell.self, forCellReuseIdentifier: "MineTableViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(tableView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(260)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(375)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MineView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "mine_head_p_image")
        headView.addSubview(headImageView)
        headImageView.addSubview(phoneLabel)
        headImageView.addSubview(typeLabel)
        headImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375, height: 180))
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(95)
            make.height.equalTo(18)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.left.equalTo(phoneLabel)
            make.height.equalTo(14)
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineTableViewCell", for: indexPath) as! MineTableViewCell
        let model = listArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = listArray[indexPath.row]
        let pageUrl = model.discuss ?? ""
        self.cellBlock?(pageUrl)
    }
    
}

extension MineView {
    
    private func getTimeBasedGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return "Good Morning ☀️"
        case 12..<18:
            return "Good Afternoon 🌤️"
        case 18..<24:
            return "Good Evening 🌙"
        default:
            return "Hello 👋"
        }
    }
    
    func maskPhoneNumber(_ number: String) -> String {
        let totalDigits = number.count
        
        if totalDigits <= 8 {
            return number
        }

        let leadingCount = 3
        let trailingCount = 5
        let hiddenCount = 4
        
        let actualTrailingCount = min(trailingCount, totalDigits - leadingCount - hiddenCount)
        
        let leadingPart = String(number.prefix(leadingCount))
        let trailingPart = String(number.suffix(actualTrailingCount))
        
        return leadingPart + "****" + trailingPart
    }
    
}
