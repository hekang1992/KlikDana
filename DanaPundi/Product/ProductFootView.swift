//
//  ProductFootView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProductFootView: UIView {
    
    var nextBlock: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: -4)
        whiteView.layer.shadowRadius = 15
        whiteView.layer.shadowOpacity = 1.0
        return whiteView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle(LanguageManager.localizedString(for: "Next step"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(900))
        nextBtn.setBackgroundImage(UIImage(named: "fot_btn_click_image"), for: .normal)
        nextBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12.pix(), right: 0)
        return nextBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(whiteView)
        whiteView.addSubview(nextBtn)
        whiteView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nextBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.pix())
            make.size.equalTo(CGSize(width: 357.pix(), height: 56.pix()))
            make.centerX.equalToSuperview()
        }
        
        nextBtn
            .rx
            .tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.nextBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
