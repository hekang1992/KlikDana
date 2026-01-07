//
//  SprayAlertView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/7.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SprayAlertView: UIView {
    
    var modelArray: [discussenModel]? {
        didSet {
//            tableView.reloadData()
        }
    }
    
    var selectedIndex: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedModel: discussenModel? {
        guard let index = selectedIndex,
              let models = modelArray,
              index >= 0 && index < models.count else {
            return nil
        }
        return models[index]
    }
    
    var sureBlock: ((discussenModel) -> Void)?
    
    var cancelBlock: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let selectedColor = UIColor(hexString: "#D7CCFF")
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pp_ac_a_image")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setBackgroundImage(UIImage(named: "fork_c_image"), for: .normal)
        return cancelBtn
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(LanguageManager.localizedString(for: "Confirming"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(900))
        button.setBackgroundImage(UIImage(named: "pp_fo_b_image"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12.pix(), right: 0)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(900))
        return nameLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20.pix()
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 46.pix()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(confirmButton)
        addSubview(cancelBtn)
        backgroundImageView.addSubview(nameLabel)
        backgroundImageView.addSubview(whiteView)
        whiteView.addSubview(tableView)
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30.pix())
            make.size.equalTo(CGSize(width: 315.pix(), height: 416.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.pix())
            make.height.equalTo(16.pix())
        }
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 285.pix(), height: 270.pix()))
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 297.pix(),
                                     height: 56.pix()))
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(15.pix())
            make.width.height.equalTo(34.pix())
            make.centerX.equalToSuperview()
        }
        
        cancelBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        confirmButton
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self, let selectedModel = selectedModel else {
                    ToastManager.showMessage(LanguageManager.localizedString(for: "Please select your authentication method first."))
                    return
                }
                self.sureBlock?(selectedModel)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearSelection() {
        selectedIndex = nil
    }
    
    func setSelectedIndex(_ index: Int) {
        if let count = modelArray?.count, index >= 0 && index < count {
            selectedIndex = index
        }
    }
}

extension SprayAlertView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        let model = self.modelArray?[indexPath.row]
        cell.textLabel?.text = model?.catchtic ?? ""
        
        if indexPath.row == selectedIndex {
            cell.contentView.backgroundColor = selectedColor
            cell.textLabel?.textColor = UIColor.init(hexString: "#3800FF")
        } else {
            cell.contentView.backgroundColor = .clear
            cell.textLabel?.textColor = UIColor.init(hexString: "#000000")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex == indexPath.row {
            selectedIndex = nil
        } else {
            selectedIndex = indexPath.row
        }
    }
}
