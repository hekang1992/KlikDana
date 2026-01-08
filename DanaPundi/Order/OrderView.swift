//
//  OrderView.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import UIKit
import SnapKit

class OrderView: UIView {
    
    var modelArray: [olModel] = []
    
    var typeBlock: ((String) -> Void)?
    
    private var selectedButton: UIButton?
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#6B67FF")
        view.isHidden = false
        view.layer.cornerRadius = 1.pix()
        return view
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = LanguageManager.currentLanguage == .id ? UIImage(named: "oc_desc_dd_image") : UIImage(named: "oc_desc_en_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var coverImageView: UIImageView = {
        let coverImageView = UIImageView()
        coverImageView.image = UIImage(named: "oc_bg_en_image")
        coverImageView.isUserInteractionEnabled = true
        return coverImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle(LanguageManager.localizedString(for: "All"), for: .normal)
        oneBtn.setTitleColor(UIColor.init(hexString: "#000000"), for: .normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        oneBtn.setBackgroundImage(UIImage(named: "oc_one_imge"), for: .normal)
        oneBtn.tag = 0
        oneBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle(LanguageManager.localizedString(for: "Applying"), for: .normal)
        twoBtn.setTitleColor(UIColor.init(hexString: "#000000"), for: .normal)
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        twoBtn.setBackgroundImage(UIImage(named: "oc_two_imge"), for: .normal)
        twoBtn.tag = 1
        twoBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setTitle(LanguageManager.localizedString(for: "Repayment"), for: .normal)
        threeBtn.setTitleColor(UIColor.init(hexString: "#000000"), for: .normal)
        threeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        threeBtn.setBackgroundImage(UIImage(named: "oc_three_imge"), for: .normal)
        threeBtn.tag = 2
        threeBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setTitle(LanguageManager.localizedString(for: "Finish"), for: .normal)
        fourBtn.setTitleColor(UIColor.init(hexString: "#000000"), for: .normal)
        fourBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        fourBtn.setBackgroundImage(UIImage(named: "oc_four_imge"), for: .normal)
        fourBtn.tag = 3
        fourBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        tableView.layer.cornerRadius = 20.pix()
        tableView.layer.masksToBounds = true
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.selectButton(self.oneBtn, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(coverImageView)
        coverImageView.addSubview(oneBtn)
        coverImageView.addSubview(twoBtn)
        coverImageView.addSubview(threeBtn)
        coverImageView.addSubview(fourBtn)
        coverImageView.addSubview(lineView)
        addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 337.pix(), height: 64.pix()))
        }
        coverImageView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(-16.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 337.pix(), height: 40.pix()))
        }
        oneBtn.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(81.5.pix())
        }
        twoBtn.snp.makeConstraints { make in
            make.left.equalTo(oneBtn.snp.right).offset(-10.pix())
            make.top.bottom.equalToSuperview()
            make.width.equalTo(91.pix())
        }
        threeBtn.snp.makeConstraints { make in
            make.left.equalTo(twoBtn.snp.right).offset(-5.pix())
            make.top.bottom.equalToSuperview()
            make.width.equalTo(109.pix())
        }
        fourBtn.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(81.5.pix())
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom)
            make.left.right.equalTo(coverImageView)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10.pix())
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectButton(sender, animated: true)
        
        let typeValue: String
        switch sender.tag {
        case 0:
            typeValue = "4"
        case 1:
            typeValue = "7"
        case 2:
            typeValue = "6"
        case 3:
            typeValue = "5"
        default:
            typeValue = "4"
        }
        
        typeBlock?(typeValue)
    }
    
    private func selectButton(_ button: UIButton, animated: Bool) {
        updateBackgroundImages(for: button)
        
        moveLineView(to: button, animated: animated)
        
        selectedButton = button
    }
    
    private func updateBackgroundImages(for selectedButton: UIButton) {
        let buttons = [oneBtn, twoBtn, threeBtn, fourBtn]
        
        for button in buttons {
            let imageName: String
            switch button.tag {
            case 0:
                imageName = button == selectedButton ? "oc_one_imge" : ""
            case 1:
                imageName = button == selectedButton ? "oc_two_imge" : ""
            case 2:
                imageName = button == selectedButton ? "oc_three_imge" : ""
            case 3:
                imageName = button == selectedButton ? "oc_four_imge" : ""
            default:
                imageName = ""
            }
            
            if !imageName.isEmpty {
                button.setBackgroundImage(UIImage(named: imageName), for: .normal)
            } else {
                button.setBackgroundImage(nil, for: .normal)
            }
        }
    }
    
    private func moveLineView(to button: UIButton, animated: Bool) {
        layoutIfNeeded()
        
        if let titleLabel = button.titleLabel,
           let titleText = button.title(for: .normal) {
            
            let textSize = (titleText as NSString).size(
                withAttributes: [.font: titleLabel.font as Any]
            )
            
            let buttonFrameInCover = coverImageView.convert(button.frame, from: button.superview)
            
            let titleFrameInButton = button.titleLabel?.frame ?? CGRect.zero
            
            let titleCenterXInButton = titleFrameInButton.midX
            let titleCenterXInCover = buttonFrameInCover.origin.x + titleCenterXInButton
            
            let lineWidth = textSize.width
            let lineHeight = 2.pix()
            let lineY = buttonFrameInCover.maxY - lineHeight - 2.pix()
            
            let lineX = titleCenterXInCover - (lineWidth / 2)
            
            let constrainedLineX = max(0, min(lineX, coverImageView.frame.width - lineWidth))
            
            if animated {
                UIView.animate(withDuration: 0.25) {
                    self.lineView.frame = CGRect(
                        x: constrainedLineX,
                        y: lineY,
                        width: lineWidth,
                        height: lineHeight
                    )
                }
            } else {
                lineView.frame = CGRect(
                    x: constrainedLineX,
                    y: lineY,
                    width: lineWidth,
                    height: lineHeight
                )
            }
        }
    }
    
    private func moveLineView2(to button: UIButton, animated: Bool) {
        layoutIfNeeded()
        
        if let titleLabel = button.titleLabel {
            let titleFrameInCover = coverImageView.convert(titleLabel.frame, from: button)
            
            let lineWidth = titleFrameInCover.width
            let lineHeight = 2.pix()
            let lineY = titleFrameInCover.maxY + 2.pix()
            
            if animated {
                UIView.animate(withDuration: 0.25) {
                    self.lineView.frame = CGRect(
                        x: titleFrameInCover.origin.x,
                        y: lineY,
                        width: lineWidth,
                        height: lineHeight
                    )
                }
            } else {
                lineView.frame = CGRect(
                    x: titleFrameInCover.origin.x,
                    y: lineY,
                    width: lineWidth,
                    height: lineHeight
                )
            }
        }
    }
    
    private func moveLineView3(to button: UIButton, animated: Bool) {
        layoutIfNeeded()
        
        let titleRect = button.titleRect(forContentRect: button.bounds)
        let titleFrameInCover = coverImageView.convert(titleRect, from: button)
        
        let lineWidth = titleFrameInCover.width
        let lineHeight = 2.pix()
        let lineY = titleFrameInCover.maxY + 2.pix()
        
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.lineView.frame = CGRect(
                    x: titleFrameInCover.origin.x,
                    y: lineY,
                    width: lineWidth,
                    height: lineHeight
                )
            }
        } else {
            lineView.frame = CGRect(
                x: titleFrameInCover.origin.x,
                y: lineY,
                width: lineWidth,
                height: lineHeight
            )
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let selectedButton = selectedButton {
            moveLineView3(to: selectedButton, animated: false)
        }
    }
}

extension OrderView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        let model = modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
}
