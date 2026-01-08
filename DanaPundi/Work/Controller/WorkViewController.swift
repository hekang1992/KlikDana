//
//  WorkViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/6.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import TYAlertController
import BRPickerView

class WorkViewController: BaseViewController {
    
    var productID: String = ""
    
    var appTitle: String = ""
    
    var orderID: String = ""
    
    private let viewMdoel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    var listModelArray: [olModel] = []
    
    var startTime: String = ""
    
    var endTime: String = ""
    
    private let locationManager = OneTimeLocationManager()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = languageCode == .id ? UIImage(named: "fa_d_c_bg_image") : UIImage(named: "fa_f_c_bg_image")
        return headImageView
    }()
    
    lazy var footerView: ProductFootView = {
        let footerView = ProductFootView(frame: .zero)
        return footerView
    }()
    
    lazy var stepView: ProductHeadView = {
        let stepView = ProductHeadView()
        let attributedString = NSMutableAttributedString()
        
        let numberAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#3800FF")
        ]
        attributedString.append(NSAttributedString(string: "2", attributes: numberAttributes))
        let slashAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#000000")
        ]
        attributedString.append(NSAttributedString(string: "/", attributes: slashAttributes))
        attributedString.append(NSAttributedString(string: "4", attributes: slashAttributes))
        stepView.stepLabel.attributedText = attributedString
        return stepView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 16.pix()
        whiteView.layer.masksToBounds = true
        whiteView.backgroundColor = .white
        whiteView.layer.borderWidth = 1.pix()
        whiteView.layer.borderColor = UIColor.init(hexString: "#B7CFE9").cgColor
        return whiteView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CleanTableViewCell.self, forCellReuseIdentifier: "CleanTableViewCell")
        tableView.register(SprayTableViewCell.self, forCellReuseIdentifier: "SprayTableViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.configTitle(with: appTitle)
        headView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            keepLeaveView()
        }
        
        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(80.pix())
        }
        
        view.addSubview(stepView)
        stepView.nameLabel.text = appTitle
        stepView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(108.pix())
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.bottom)
            make.left.right.equalToSuperview().inset(20.pix())
            make.bottom.equalTo(footerView.snp.top).offset(-10.pix())
        }
        
        whiteView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        footerView.nextBlock = { [weak self] in
            guard let self = self else { return }
            endTime = String(Int(Date().timeIntervalSince1970))
            let parameters = self.listModelArray
                .compactMap { model -> (String, String)? in
                    guard let key = model.peaceent, let value = model.stenics else {
                        return nil
                    }
                    return (key, value)
                }
                .reduce(into: ["seget": self.productID]) { dict, tuple in
                    dict[tuple.0] = tuple.1
                }
            Task {
                await self.saveWorkInfo(with: parameters)
            }
        }
        
        startTime = String(Int(Date().timeIntervalSince1970))
        
        locationManager.locateOnce { result in
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getWorkInfo()
        }
    }
    
}

extension WorkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = self.listModelArray[indexPath.row]
        let type = listModel.eitherency ?? ""
        if type == "novenownerosity" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CleanTableViewCell", for: indexPath) as! CleanTableViewCell
            cell.model = listModel
            cell.enterTextChanged = { text in
                listModel.hiblaughdom = text
                listModel.stenics = text
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SprayTableViewCell", for: indexPath) as! SprayTableViewCell
            cell.model = listModel
            cell.cellClickBlock = { [weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)
                if type == "designetic" {
                    self.presentSprayAlert(for: listModel, from: cell)
                }else {
                    self.presentCityAlert(for: listModel, from: cell)
                }
            }
            return cell
        }
    }
    
    
}

extension WorkViewController {
    
    private func presentCityAlert(for model: olModel, from cell: SprayTableViewCell) {
        guard let cityModelArray = CitysArrayModel.shared.modelArray,
              !cityModelArray.isEmpty else {
            return
        }
        
        let listArray = CitysArrayModel.getAddressModelArray(dataSourceArr: cityModelArray)
        
        let pickerView = BRTextPickerView()
        pickerView.pickerMode = .componentCascade
        pickerView.title = model.canfy ?? ""
        pickerView.dataSourceArr = listArray
        
        let style = BRPickerStyle()
        style.rowHeight = 44
        style.language = "en"
        let themeColor = UIColor(hexString: "#3800FF")
        style.doneTextColor = themeColor
        style.selectRowTextColor = themeColor
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        style.pickerTextFont = font
        style.selectRowTextFont = font
        pickerView.pickerStyle = style
        
        pickerView.multiResultBlock = { [weak cell, weak model] models, _ in
            guard let cell = cell, let model = model else { return }
            
            let selectText = models?
                .compactMap { $0.text }
                .joined(separator: "-") ?? ""
            
            cell.txFiled.text = selectText
            model.hiblaughdom = selectText
            model.stenics = selectText
        }
        
        pickerView.show()
    }
    
}

extension WorkViewController {
    
    private func presentSprayAlert(for model: olModel, from cell: SprayTableViewCell) {
        
        let alertView = createSprayAlertView(with: model, cell: cell)
        
        guard let alertController = TYAlertController(alert: alertView, preferredStyle: .actionSheet) else {
            return
        }
        
        present(alertController, animated: true)
        
        setupAlertCallbacks(for: alertView, with: model, cell: cell)
    }
    
    private func createSprayAlertView(with model: olModel, cell: SprayTableViewCell) -> SprayAlertView {
        let alertView = SprayAlertView(frame: view.bounds)
        
        alertView.nameLabel.text = model.canfy ?? ""
        
        let discussionArray = model.discussen ?? []
        alertView.modelArray = discussionArray
        
        if let selectedValue = cell.txFiled.text,
           let selectedIndex = discussionArray.firstIndex(where: { $0.catchtic == selectedValue }) {
            alertView.selectedIndex = selectedIndex
        }
        
        return alertView
    }
    
    private func setupAlertCallbacks(for alertView: SprayAlertView,
                                     with model: olModel,
                                     cell: SprayTableViewCell) {
        alertView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        alertView.sureBlock = { [weak self] selectedModel in
            self?.handleSpraySelection(selectedModel, for: model, cell: cell)
        }
    }
    
    private func handleSpraySelection(_ selectedModel: discussenModel,
                                      for model: olModel,
                                      cell: SprayTableViewCell) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            cell.txFiled.text = selectedModel.catchtic ?? ""
            
            self.updateModel(model, with: selectedModel)
        }
    }
    
    private func updateModel(_ model: olModel, with selectedModel: discussenModel) {
        model.hiblaughdom = selectedModel.catchtic ?? ""
        model.stenics = selectedModel.stenics ?? ""
    }
}

extension WorkViewController {
    
    private func getWorkInfo() async {
        do {
            let parameters = ["seget": productID, "stenics": "2"]
            let model = try await viewMdoel.workApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                self.listModelArray = model.anyably?.ol ?? []
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    private func saveWorkInfo(with parameters: [String: String]) async {
        do {
            let model = try await viewMdoel.saveWorkApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                await self.detailPageInfo(with: productID, orderID: orderID, viewMdoel: viewMdoel)
                await self.twoLocino()
            }else {
                ToastManager.showMessage(model.cubage ?? "")
            }
        } catch {
            
        }
    }
    
    private func twoLocino() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        let lon = LocationStorage.getLon() ?? ""
        let lat = LocationStorage.getLat() ?? ""
        let parameters = ["stichette": productID,
                          "designetic": orderID,
                          "sideile": String(Int(4)),
                          "violenceitude": lon,
                          "stultiia": lat,
                          "cupety": startTime,
                          "put": endTime]
        await self.upKeyerConfig(with: viewMdoel, parameters: parameters)
    }
    
}
