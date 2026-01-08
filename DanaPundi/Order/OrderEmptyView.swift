//
//  OrderEmptyView.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

class OrderEmptyView: UIView {

    var onImageTap: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = LanguageManager.currentLanguage == .id ? UIImage(named: "o_emd_l_image") : UIImage(named: "o_em_l_image")
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        bgImageView.addGestureRecognizer(tap)
        
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        backgroundColor = .white
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 165.pix(), height: 255.pix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func imageTapped() {
        onImageTap?()
    }
}
