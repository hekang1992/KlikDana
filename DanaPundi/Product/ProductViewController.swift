//
//  ProductViewController.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

import UIKit
import SnapKit
import MJRefresh

class ProductViewController: BaseViewController {
    
    var productID = ""
    
    private let viewMdoel = HomeViewModel()
    
    // MARK: - Views
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "mine_head_bg_image")
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = LanguageManager.localizedString(for: "Complete certification")
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var aImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "de_head_bg_image")
        return imageView
    }()
    
    lazy var footerView: ProductFootView = {
        let view = ProductFootView(frame: .zero)
        return view
    }()
    
    lazy var layerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#F6FAFF")
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textAlignment = .left
        moneyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        moneyLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return moneyLabel
    }()
    
    lazy var lockLabel: UILabel = {
        let lockLabel = UILabel()
        lockLabel.textAlignment = .left
        lockLabel.text = LanguageManager.localizedString(for: "Unlock quota")
        lockLabel.textColor = UIColor.init(hexString: "#3800FF")
        lockLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return lockLabel
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.detailInfo()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await detailInfo()
        }
    }
}

// MARK: - UI
extension ProductViewController {
    
    private func setupUI() {
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(338.pix())
        }
        
        view.addSubview(headView)
        headView.contentView.backgroundColor = .clear
        headView.statusBarView.backgroundColor = .clear
        headView.nameLabel.textColor = .white
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(80.pix())
        }
        
        view.addSubview(layerView)
        layerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
            make.height.equalTo(420.pix())
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80.pix())
        }
        
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        scrollView.addSubview(aImageView)
        aImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalToSuperview().offset(20.pix())
            make.size.equalTo(CGSize(width: 355.pix(), height: 172.pix()))
        }
        
        aImageView.addSubview(descLabel)
        aImageView.addSubview(moneyLabel)
        aImageView.addSubview(lockLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34.pix())
            make.left.equalToSuperview().offset(25.pix())
            make.height.equalTo(16.pix())
        }
        moneyLabel.snp.makeConstraints { make in
            make.left.equalTo(descLabel)
            make.top.equalTo(descLabel.snp.bottom).offset(4.pix())
            make.height.equalTo(48.pix())
        }
        lockLabel.snp.makeConstraints { make in
            make.left.equalTo(descLabel)
            make.top.equalTo(moneyLabel.snp.bottom).offset(25.pix())
            make.height.equalTo(16.pix())
        }
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - Network
extension ProductViewController {
    
    private func detailInfo() async {
        do {
            let parameters = ["seget": productID]
            let model = try await viewMdoel.detailApi(parameters: parameters)
            let peaceent = model.peaceent ?? ""
            if peaceent == "0" || peaceent == "00" {
                setupUI(with: model)
            }
            await self.scrollView.mj_header?.endRefreshing()
        } catch {
            await self.scrollView.mj_header?.endRefreshing()
        }
    }
    
    private func setupUI(with model: BaseModel) {
        
        footerView.nextBtn.setTitle(
            model.anyably?.recentable?.fraterbedform ?? "",
            for: .normal
        )
        
        headView.configTitle(
            with: model.anyably?.recentable?.jugespecially ?? ""
        )
        
        descLabel.text = model.anyably?.recentable?.allelist ?? ""
        moneyLabel.text = model.anyably?.recentable?.vadant ?? ""
        
        let listArray = model.anyably?.amor ?? []
        
        setupListViews(listArray)
    }
}

extension ProductViewController {
    
    private func setupListViews(_ listArray: [amorModel]) {
        
        scrollView.subviews
            .filter { $0 is ProductListView }
            .forEach { $0.removeFromSuperview() }
        
        var lastView: UIView = aImageView
        
        for (index, model) in listArray.enumerated() {
            
            let listView = ProductListView()
            listView.config(with: model)
            scrollView.addSubview(listView)
            
            listView.snp.makeConstraints { make in
                if index == 0 {
                    make.top.equalTo(aImageView.snp.bottom).offset(40.pix())
                } else {
                    make.top.equalTo(lastView.snp.bottom).offset(15.pix())
                }
                
                make.left.equalToSuperview().offset(20.pix())
                make.centerX.equalToSuperview()
            }
            
            lastView = listView
        }
        
        if let last = lastView as? ProductListView {
            last.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-40.pix())
            }
        }
    }
}
