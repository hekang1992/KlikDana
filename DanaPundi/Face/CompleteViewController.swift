//
//  CompleteViewController.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/6.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import TYAlertController

class CompleteViewController: BaseViewController {
    
    var productID: String = ""
    
    var appTitle: String = ""
    
    var orderID: String = ""
    
    private let viewMdoel = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = languageCode == .id ? UIImage(named: "suc_com_d_image") : UIImage(named: "suc_com_e_image")
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LanguageManager.localizedString(for: "Certification Information")
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(700))
        return nameLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "id_c_de_image")
        return iconImageView
    }()
    
    lazy var aLabel: UILabel = {
        let aLabel = UILabel()
        aLabel.textAlignment = .left
        aLabel.text = LanguageManager.localizedString(for: "Full Name:")
        aLabel.textColor = UIColor.init(hexString: "#999999")
        aLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return aLabel
    }()
    
    lazy var bLabel: UILabel = {
        let bLabel = UILabel()
        bLabel.textAlignment = .left
        bLabel.text = LanguageManager.localizedString(for: "ID NO.:")
        bLabel.textColor = UIColor.init(hexString: "#999999")
        bLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return bLabel
    }()
    
    lazy var cLabel: UILabel = {
        let cLabel = UILabel()
        cLabel.textAlignment = .left
        cLabel.text = LanguageManager.localizedString(for: "Date of Birth:")
        cLabel.textColor = UIColor.init(hexString: "#999999")
        cLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return cLabel
    }()
    
    lazy var alineView: DotLineView = {
        let alineView = DotLineView(frame: .zero)
        return alineView
    }()
    
    lazy var blineView: DotLineView = {
        let blineView = DotLineView(frame: .zero)
        return blineView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .right
        oneLabel.textColor = UIColor.init(hexString: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.textColor = UIColor.init(hexString: "#000000")
        twoLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .right
        threeLabel.textColor = UIColor.init(hexString: "#000000")
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        return threeLabel
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
            make.top.equalToSuperview().offset(30.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 318.pix(), height: 378.pix()))
        }
        
        scrollView.addSubview(whiteView)
        
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImageView.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 335.pix(), height: 180.pix()))
            make.bottom.equalToSuperview().offset(-40.pix())
        }
        
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(iconImageView)
        whiteView.addSubview(aLabel)
        whiteView.addSubview(alineView)
        whiteView.addSubview(bLabel)
        whiteView.addSubview(blineView)
        whiteView.addSubview(cLabel)
        whiteView.addSubview(oneLabel)
        whiteView.addSubview(twoLabel)
        whiteView.addSubview(threeLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(12)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.size.equalTo(CGSize(width: 18, height: 13))
            make.right.equalToSuperview().offset(-15)
        }
        
        aLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(20.pix())
            make.height.equalTo(14)
        }
        
        alineView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(aLabel.snp.bottom).offset(15.pix())
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(alineView.snp.bottom).offset(20.pix())
            make.height.equalTo(14)
        }
        
        blineView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(bLabel.snp.bottom).offset(15.pix())
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        cLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(blineView.snp.bottom).offset(20.pix())
            make.height.equalTo(14)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.centerY.equalTo(aLabel)
            make.height.equalTo(14)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.centerY.equalTo(bLabel)
            make.height.equalTo(14)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.centerY.equalTo(cLabel)
            make.height.equalTo(14)
        }
        
        footerView.nextBlock = { [weak self] in
            guard let self = self else { return }
            Task {
                await self.detailPageInfo(with: self.productID, orderID: self.orderID, viewMdoel: self.viewMdoel)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.userDetailInfo()
        }
    }
    
}

extension CompleteViewController {
    
    private func userDetailInfo() async {
        do {
            let parameters = ["seget": productID]
            let model = try await viewMdoel.userDetailApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                self.oneLabel.text = model.anyably?.abilityfaction?.pleasphone?.catchtic ?? ""
                self.twoLabel.text = model.anyably?.abilityfaction?.pleasphone?.bank ?? ""
                self.threeLabel.text = model.anyably?.abilityfaction?.pleasphone?.hemeror ?? ""
            }
        } catch {
            
        }
    }
    
}
