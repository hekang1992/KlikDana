//
//  FaceViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/6.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import TYAlertController

class FaceViewController: BaseViewController {
    
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
        headImageView.image = languageCode == .id ? UIImage(named: "fa_d_c_bg_image") : UIImage(named: "fa_f_c_bg_image")
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
        ftImageView.image = languageCode == .id ? UIImage(named: "d_p_fc_image") : UIImage(named: "fc_en_d_imge")
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
        logoImageView.image = UIImage(named: "fp_v_image")
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
        descLabel.text = LanguageManager.localizedString(for: "Facial Recognition")
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

extension FaceViewController {
    
    private func cameraInfo() {
        let config = CameraConfig(cameraDevice: .front)
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
        endTime = String(Int(Date().timeIntervalSince1970))
        do {
            let parameters = ["stenics": "10",
                              "roadaster": "2",
                              "activityier": "",
                              "pulmonate": "1",
                              "hypoprotectary": "1"]
            let model = try await viewMdoel.uploadImageApi(parameters: parameters, imageData: imageData)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                self.completeImageView.isHidden = false
                self.footerView.nextBtn.isEnabled = false
                try? await Task.sleep(nanoseconds: 200_000_000)
                await self.detailPageInfo(with: self.productID, orderID: self.orderID, viewMdoel: viewMdoel)
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
                          "sideile": String(Int(3)),
                          "violenceitude": lon,
                          "stultiia": lat,
                          "cupety": startTime,
                          "put": endTime]
        await self.upKeyerConfig(with: viewMdoel, parameters: parameters)
    }
    
}
