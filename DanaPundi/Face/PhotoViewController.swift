//
//  PhotoViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/6.
//

import UIKit
import SnapKit

class PhotoViewController: BaseViewController {
    
    var productID: String = ""
    
    var appTitle: String = ""
    
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
        completeImageView.isHidden = false
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headView)
        headView.configTitle(with: appTitle)
        headView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
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
    }

}
