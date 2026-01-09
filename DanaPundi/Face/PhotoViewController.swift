//
//  PhotoViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/6.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import TYAlertController

class PhotoViewController: BaseViewController {
    
    var productID: String = ""
    
    var appTitle: String = ""
    
    var orderID: String = ""
    
    private let viewMdoel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    var startTime: String = ""
    
    var endTime: String = ""
    
    private let locationManager = OneTimeLocationManager()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = languageCode == .id ? UIImage(named: "d_p_bg_image") : UIImage(named: "e_p_bg_image")
        return headImageView
    }()
    
    lazy var footerView: ProductFootView = {
        let footerView = ProductFootView(frame: .zero)
        return footerView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20.pix()
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var ftImageView: UIImageView = {
        let ftImageView = UIImageView()
        ftImageView.image = languageCode == .id ? UIImage(named: "d_p_fc_image") : UIImage(named: "e_p_fc_image")
        return ftImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "pla_desc_image")
        return logoImageView
    }()
    
    lazy var completeImageView: UIImageView = {
        let completeImageView = UIImageView()
        completeImageView.image = UIImage(named: "suc_pla_bg_image")
        completeImageView.isHidden = true
        return completeImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.text = LanguageManager.localizedString(for: "Front of ID card")
        descLabel.textColor = UIColor.init(hexString: "#000000")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
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
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        
        scrollView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 74.pix()))
        }
        
        scrollView.addSubview(whiteView)
        
        scrollView.addSubview(ftImageView)
        
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(25.pix())
            make.size.equalTo(CGSize(width: 335.pix(), height: 220.pix()))
        }
        
        ftImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(whiteView.snp.bottom).offset(10.pix())
            make.size.equalTo(CGSize(width: 335.pix(), height: 281.pix()))
            make.bottom.equalToSuperview().offset(-40.pix())
        }
        
        whiteView.addSubview(logoImageView)
        logoImageView.addSubview(completeImageView)
        whiteView.addSubview(descLabel)
        whiteView.addSubview(clickBtn)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 261.pix(), height: 140.pix()))
        }
        completeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(64.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(15)
            make.height.equalTo(15)
            make.centerX.equalToSuperview()
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cameraInfo()
            })
            .disposed(by: disposeBag)
        
        footerView.nextBlock = { [weak self] in
            guard let self = self else { return }
            self.cameraInfo()
        }
        
        startTime = String(Int(Date().timeIntervalSince1970))
        
        locationManager.locateOnce { result in
            
        }
    }
    
}

extension PhotoViewController {
    
    private func cameraInfo() {
        let config = CameraConfig(cameraDevice: .rear)
        CameraManager.shared.takePhoto(from: self, config: config) { [weak self] image in
            guard let self = self, let image = image else { return }
            Task {
                if let data = image.jpegData(compressionQuality: 0.3) {
                    await self.uploadImage(with: data)
                }
            }
        }
    }
    
    private func uploadImage(with imageData: Data) async {
        do {
            let parameters = ["stenics": "11",
                              "roadaster": "2",
                              "activityier": "2",
                              "pulmonate": "1",
                              "hypoprotectary": "1"]
            let model = try await viewMdoel.uploadImageApi(parameters: parameters, imageData: imageData)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                if let anyablyModel = model.anyably {
                    self.popPhotoView(with: anyablyModel)
                }
            }else {
                ToastManager.showMessage(model.cubage ?? "")
            }
        } catch {
            
        }
    }
    
    
    private func detailInfo(with productID: String) async {
        do {
            let parameters = ["seget": productID, "idea": "1"]
            let model = try await viewMdoel.detailApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                
            }
        } catch {
            
        }
    }
    
    private func popPhotoView(with model: anyablyModel) {
        let popView = SheetPhotoView(frame: self.view.bounds)
        popView.model = model
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            endTime = String(Int(Date().timeIntervalSince1970))
            Task {
                await self.saveUserInfo(with: popView)
            }
        }
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
    }
    
    private func saveUserInfo(with listView: SheetPhotoView) async {
        let brithday = listView.birthdayTextField.text ?? ""
        let number = listView.numberTextField.text ?? ""
        let name = listView.nameTextField.text ?? ""
        do {
            let parameters = ["hemeror": brithday,
                              "bank": number,
                              "catchtic": name,
                              "thankia": orderID,
                              "seget": productID,
                              "ogy": SaveLoginInfo.getPhone() ?? ""]
            let model = try await viewMdoel.saveImageApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                self.dismiss(animated: true) {
                    self.completeImageView.isHidden = false
                    let faceVc = FaceViewController()
                    faceVc.productID = self.productID
                    faceVc.orderID = self.orderID
                    faceVc.appTitle = self.appTitle
                    self.navigationController?.pushViewController(faceVc, animated: true)
                }
                Task {
                    await self.twoLocino()
                }
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
                          "sideile": String(Int(2)),
                          "violenceitude": lon,
                          "stultiia": lat,
                          "cupety": startTime,
                          "put": endTime]
        await self.upKeyerConfig(with: viewMdoel, parameters: parameters)
    }
    
}
