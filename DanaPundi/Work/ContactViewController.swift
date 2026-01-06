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

class ContactViewController: BaseViewController {
    
    var productID: String = ""
    
    var appTitle: String = ""
    
    var orderID: String = ""
    
    private let viewMdoel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.configTitle(with: appTitle)
        headView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.backDetailPageVc()
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
        
        footerView.nextBlock = { [weak self] in
            guard let self = self else { return }
            
        }
        
    }
    
}

extension ContactViewController {
    
}
