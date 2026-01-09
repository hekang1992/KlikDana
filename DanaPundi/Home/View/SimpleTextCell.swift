//
//  SimpleTextCell.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/9.
//

import UIKit
import FSPagerView
import SnapKit

class SimpleTextCell: FSPagerViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.init(hexString: "#FF0000")
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        contentView.layer.shadowColor = UIColor.clear.cgColor
        contentView.layer.shadowRadius = 0
        contentView.layer.shadowOpacity = 0
        contentView.layer.shadowOffset = .zero
        
        contentView.transform = CGAffineTransform.identity
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1.pix())
        }
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
    
}
