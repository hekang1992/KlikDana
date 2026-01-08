//
//  ContactTableViewCell.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/7.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var phoneBlock: (() -> Void)?
    var relationBlock: (() -> Void)?
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.pix()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.pix()
        view.layer.borderColor = UIColor(hexString: "#B7CFE9").cgColor
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        createLabel(
            font: .systemFont(ofSize: 16, weight: .bold),
            color: .init(hexString: "#000000")
        )
    }()
    
    lazy var firstSectionView: InputSectionView = {
        return InputSectionView()
    }()
    
    lazy var secondSectionView: InputSectionView = {
        return InputSectionView()
    }()
    
    // MARK: - Data Model
    var model: olModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.tendade ?? ""
            
            // Configure first section
            firstSectionView.titleLabel.text = model.an ?? ""
            firstSectionView.textField.placeholder = model.problemel ?? ""
            
            let tactad = model.tactad ?? ""
            if let foundItem = model.itinerling?.first(where: { $0.stenics == tactad }) {
                firstSectionView.textField.text = foundItem.catchtic ?? ""
            } else {
                firstSectionView.textField.text = ""
            }
            
            // Configure second section
            secondSectionView.titleLabel.text = model.defenseule ?? ""
            secondSectionView.textField.placeholder = model.pageorium ?? ""
            let catchtic = model.catchtic ?? ""
            let thankia = model.thankia ?? ""
            let nps = String(format: "%@-%@", catchtic, thankia)
            secondSectionView.textField.text = nps == "-" ? "" : nps
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(containerView)
        
        [titleLabel, firstSectionView, secondSectionView].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.pix())
            make.centerX.equalToSuperview()
            make.width.equalTo(335.pix())
            make.height.equalTo(228.pix())
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.pix())
            make.leading.equalToSuperview().offset(15.pix())
            make.height.equalTo(16)
        }
        
        firstSectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20.pix())
            make.leading.trailing.equalToSuperview().inset(15.pix())
            make.height.equalTo(66.pix())
        }
        
        secondSectionView.snp.makeConstraints { make in
            make.top.equalTo(firstSectionView.snp.bottom).offset(20.pix())
            make.leading.trailing.equalToSuperview().inset(15.pix())
            make.height.equalTo(66.pix())
        }
    }
    
    // MARK: - Helper Methods
    private func createLabel(font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = color
        label.font = font
        return label
    }
    
    private func bindActions() {
        // First section button tap
        firstSectionView.actionButton.rx.tap
            .bind { [weak self] in
                self?.relationBlock?()
            }
            .disposed(by: disposeBag)
        
        // Second section button tap
        secondSectionView.actionButton.rx.tap
            .bind { [weak self] in
                self?.phoneBlock?()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - InputSectionView (Reusable Component)
class InputSectionView: UIView {
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#000000")
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12.pix()
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#EEEEEE")
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14, weight: UIFont.Weight(400))
        textField.textColor = UIColor(hexString: "#333333")
        textField.isEnabled = false
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return textField
    }()
    
    let rightIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12.pix()
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = UIColor(hexString: "#3800FF")
        return view
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wi_ir_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Add subviews in correct hierarchy
        addSubview(titleLabel)
        addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(rightIndicatorView)
        rightIndicatorView.addSubview(arrowImageView)
        containerView.addSubview(actionButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(14)
            make.bottom.equalToSuperview().offset(-54.pix())
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.pix())
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12.pix())
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(rightIndicatorView.snp.leading)
        }
        
        rightIndicatorView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(38.pix())
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.pix(), height: 16.pix()))
        }
        
        actionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
