//
//  MaxBnnViewCell.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import FSPagerView

class MaxBnnViewCell: UITableViewCell {
    
    // MARK: - Properties
    var modelArray: [appearModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            updatePagerData(with: modelArray)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var cellClickBlock: ((appearModel) -> Void)?
    
    // MARK: - UI Components
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ma_ba_bg_image")
        return bgImageView
    }()
    
    lazy var laImageView: UIImageView = {
        let laImageView = UIImageView()
        laImageView.image = UIImage(named: "ma_la_bg_image")
        return laImageView
    }()

    lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.register(SimpleTextCell.self, forCellWithReuseIdentifier: "SimpleTextCell")
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.decelerationDistance = 1
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.interitemSpacing = 5.pix()
        pagerView.backgroundColor = .clear
        return pagerView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(laImageView)
        bgView.addSubview(pagerView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44.pix())
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 44.pix()))
        }
        
        laImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.size.equalTo(CGSize(width: 25.pix(), height: 28.pix()))
        }
        
        pagerView.snp.makeConstraints { make in
            make.left.equalTo(laImageView.snp.right).offset(8.pix())
            make.top.bottom.equalToSuperview().inset(2.pix())
            make.right.equalToSuperview().offset(-30.pix())
        }
        
    }
    
    private func updatePagerData(with modelArray: [appearModel]) {
        pagerView.reloadData()
    }

}

// MARK: - FSPagerViewDataSource
extension MaxBnnViewCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "SimpleTextCell", at: index) as! SimpleTextCell
        
        let model = modelArray?[index]
        
        cell.configure(with: model?.cubage ?? "")
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension MaxBnnViewCell: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let model = self.modelArray?[index] {
            self.cellClickBlock?(model)
        }
    }
    
}

