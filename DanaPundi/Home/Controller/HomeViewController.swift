//
//  HomeViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import UIKit
import SnapKit
import MJRefresh
import CoreLocation
import FBSDKCoreKit
import TYAlertController

class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    private let locationManager = OneTimeLocationManager()
    
    lazy var airView: AirBookView = {
        let airView = AirBookView(frame: .zero)
        airView.isHidden = true
        return airView
    }()
    
    lazy var maxView: MaxBookView = {
        let maxView = MaxBookView(frame: .zero)
        maxView.isHidden = true
        return maxView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(airView)
        airView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(maxView)
        maxView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(5.pix())
            make.left.right.equalToSuperview()
        }
        
        airView.applyBlock = { [weak self] model in
            guard let self = self else { return }
            Task {
                await self.cilckProductInfo(with: model)
            }
        }
        
        airView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.homeInfo()
            }
        })
        
        maxView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.homeInfo()
            }
        })
        
        maxView.cellClickBlock = { [weak self] model in
            guard let self = self else { return }
            Task {
                await self.cilckProductInfo(with: model)
            }
        }
        
        maxView.cellBannerClickBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.semaair ?? ""
            if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
                URLSchemeRouter.handle(pageURL: pageUrl, from: self)
            }else if pageUrl.hasPrefix("http") || pageUrl.hasPrefix("https") {
                self.goRelletWebVc(with: pageUrl)
            }else {
                
            }
        }
        
        Task {
            await self.getCityListInfo()
            await self.toIDFAInfo()
        }
        
        locationManager.locateOnce { [weak self] result in
            guard let self = self else { return }
            if result.isEmpty {
                if languageCode == .id {
                    self.showLocationDeniedAlert()
                }
            }
        }
        
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
                var modelArray = model.anyably?.ruspay ?? []
                if let ligItem = modelArray.first(where: { $0.stenics == "lig" }) {
                    let appearArray = ligItem.appear ?? []
                    self.airView.model = appearArray.first
                    self.airView.isHidden = false
                    self.maxView.isHidden = true
                }else {
                    if modelArray.first(where: { $0.stenics == "paedoer" }) != nil {
                        modelArray.removeAll { $0.stenics == "paedoer" }
                        self.airView.isHidden = true
                        self.maxView.isHidden = false
                        self.maxView.modelArray = modelArray
                    }
                }
            }else if peaceent == "-2" {
                SaveLoginInfo.deleteLoginInfo()
                self.notiRootVc(with: "0")
            }
            await MainActor.run {
                self.airView.scrollView.mj_header?.endRefreshing()
                self.maxView.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.airView.scrollView.mj_header?.endRefreshing()
                self.maxView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func cilckProductInfo(with model: appearModel) async {
        
        if LanguageManager.currentLanguage == .id {
            let status = CLLocationManager().authorizationStatus
            if status != .authorizedAlways && status != .authorizedWhenInUse  {
                self.showLocationDeniedAlert()
                return
            }
        }
        
        locationManager.locateOnce { [weak self] result in
            guard let self = self else { return }
            Task {
                await self.uploadLocationInfo(with: result)
            }
        }
        
        DeviceInfoManager.shared.getAllDeviceInfo { [weak self] deviceInfo in
            DispatchQueue.main.async {
                if let info = deviceInfo {
                    Task {
                        await self?.processAndDisplayDeviceInfo(info)
                    }
                } else {
                    
                }
            }
        }
        
        Task {
            await self.upKeyer()
        }
        
        do {
            let productID = String(model.tinacithroughling ?? 0)
            let parameters = ["film": String(Int(1000 + 1)),
                              "trial": String(Int(200 + 800)),
                              "idacy": String(Int(300 + 700)),
                              "seget": productID]
            let model = try await viewModel.clickProductApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                let pageUrl = model.anyably?.semaair ?? ""
                if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
                    URLSchemeRouter.handle(pageURL: pageUrl, from: self)
                }else if pageUrl.hasPrefix("http") {
                    self.goRelletWebVc(with: pageUrl)
                }else {
                    if languageCode == .id {
                        let listModel = model.anyably?.treat?.plasee ?? []
                        
                        let popView = AppLogoutView(frame: self.view.bounds)
                        popView.backgroundImageView.image = LanguageManager.currentLanguage == .id ? UIImage(named: "f_id_en_image") : UIImage(named: "f_d_en_image")
                        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
                        self.present(alertVc!, animated: true)
                        
                        /// cancel
                        popView.cancelBlock = { [weak self] in
                            guard let self = self else { return }
                            self.dismiss(animated: true)
                        }
                        
                        /// apply
                        popView.cBlock = { [weak self] in
                            guard let self = self else { return }
                            self.dismiss(animated: true) {
                                let pageUrl = listModel.first?.semaair ?? ""
                                self.goRelletWebVc(with: pageUrl)
                            }
                        }
                        
                        /// detail
                        popView.leaveBlock = { [weak self] in
                            guard let self = self else { return }
                            self.dismiss(animated: true) {
                                let pageUrl = listModel.last?.semaair ?? ""
                                if pageUrl.hasPrefix(DeepLinkRoute.scheme_url) {
                                    URLSchemeRouter.handle(pageURL: pageUrl, from: self)
                                }
                            }
                        }
                    }else {
                        self.goProductVc(with: productID)
                    }
                }
            }else if peaceent == "-2" {
                SaveLoginInfo.deleteLoginInfo()
                self.notiRootVc(with: "0")
            }else {
                ToastManager.showMessage(model.cubage ?? "")
            }
        } catch {
            
        }
    }
    
    private func goProductVc(with productID: String) {
        let productVc = ProductViewController()
        productVc.productID = productID
        self.navigationController?.pushViewController(productVc, animated: true)
    }
    
}

extension HomeViewController {
    
    private func getCityListInfo() async {
        do {
            let model = try await viewModel.cityListApi()
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                CitysArrayModel.shared.modelArray = model.anyably?.ruspay ?? []
            }
        } catch {
            
        }
    }
    
    private func uploadLocationInfo(with parameters: [String: String]) async {
        do {
            let _ = try await viewModel.uploadLocationApi(parameters: parameters)
        } catch {
            
        }
    }
    
    private func processAndDisplayDeviceInfo(_ info: DeviceInfo) async {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let jsonData = try encoder.encode(info)
            guard String(data: jsonData, encoding: .utf8) != nil else {
                return
            }
            let base64String = jsonData.base64EncodedString()
            Task {
                let parameters = ["anyably": base64String]
                let _ =  try await viewModel.uploadDeviceApi(parameters: parameters)
            }
        } catch {
            
        }
    }
    
    private func upKeyer() async {
        do {
            let lon = LocationStorage.getLon() ?? ""
            let lat = LocationStorage.getLat() ?? ""
            let startTime = TimeManager.getStartTime() ?? ""
            let endTime = TimeManager.getEndTime() ?? ""
            if startTime.isEmpty || endTime.isEmpty {
                return
            }
            let parameters = ["sideile": String(Int(1)),
                              "stichette": "",
                              "designetic": "",
                              "violenceitude": lon,
                              "stultiia": lat,
                              "cupety": startTime,
                              "put": endTime]
            let model = try await viewModel.uploadKeyerApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                TimeManager.clearAllTimes()
            }
        } catch {
            
        }
    }
    
    private func toIDFAInfo() async {
        do {
            let parameters = ["tragial": IDFVManager.getIDFV(),
                              "ecoesque": IDFAManager.shared.getCurrentIDFA()]
            
            let model = try await viewModel.uploadIdfaApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                if let fbModel = model.anyably?.playeer {
                    uploadFInfo(with: fbModel)
                }
            }
        } catch {
            print("uploadIDFAInfo error: \(error)")
        }
    }
    
    private func uploadFInfo(with model: playeerModel) {
        Settings.shared.displayName = model.you ?? ""
        Settings.shared.appURLSchemeSuffix = model.serveitor ?? ""
        Settings.shared.appID = model.author ?? ""
        Settings.shared.clientToken = model.muchtion ?? ""
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
    
}

extension HomeViewController {
    
    func showLocationDeniedAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: LanguageManager.localizedString(for: "Location Permission"),
                message: LanguageManager.localizedString(for: "NSLocationWhenInUseUsageDescription"),
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Cancel"), style: .cancel))
            
            alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Go to  settings"), style: .default) { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url)
            })
            
            self.present(alert, animated: true)
        }
    }
    
}
