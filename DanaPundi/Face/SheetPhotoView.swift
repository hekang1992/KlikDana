//
//  SheetPhotoView.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/6.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import BRPickerView

class SheetPhotoView: UIView {
    
    // MARK: - Properties
    
    var model: anyablyModel? {
        didSet {
            guard let model = model else { return }
            updateUI(with: model)
        }
    }
    
    var cancelBlock: (() -> Void)?
    var sureBlock: (() -> Void)?
    var selectTimeBlock: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Constants
    
    private enum Constants {
        static let contentWidth: CGFloat = 315.pix()
        static let contentHeight: CGFloat = 392.pix()
        static let buttonWidth: CGFloat = 297.pix()
        static let buttonHeight: CGFloat = 56.pix()
        static let fieldWidth: CGFloat = 285.pix()
        static let fieldHeight: CGFloat = 44.pix()
        static let cornerRadius: CGFloat = 14
        static let horizontalPadding: CGFloat = 15.pix()
        static let fieldPadding: CGFloat = 10.pix()
        static let verticalSpacing: CGFloat = 10.pix()
        static let titleTopOffset: CGFloat = 20
        static let sectionSpacing: CGFloat = 15.pix()
        
        static let primaryColor = UIColor(hexString: "#000000")
        static let backgroundColor = UIColor(hexString: "#EFFAFE")
        static let doneButtonColor = UIColor(hexString: "#3800FF")
        
        static let titleFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let labelFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let fieldFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let pickerFont = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    private enum DateFormats {
        static let displayFormat = "dd/MM/yyyy"
        static let defaultDate = "16/12/1997"
        static let alternativeFormat = "yyyy/MM/dd"
    }
    
    // MARK: - UI Components
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pp_ac_image")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(LanguageManager.localizedString(for: "Confirming"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(900))
        button.setBackgroundImage(UIImage(named: "pp_fo_b_image"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12.pix(), right: 0)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        createLabel(
            text: LanguageManager.localizedString(for: "Identity information"),
            font: Constants.titleFont,
            alignment: .center
        )
    }()
    
    private lazy var nameLabel: UILabel = {
        createLabel(
            text: LanguageManager.localizedString(for: "Aadhaar name"),
            font: Constants.labelFont
        )
    }()
    
    private lazy var numberLabel: UILabel = {
        createLabel(
            text: LanguageManager.localizedString(for: "Aadhaar number"),
            font: Constants.labelFont
        )
    }()
    
    private lazy var birthdayLabel: UILabel = {
        createLabel(
            text: LanguageManager.localizedString(for: "Birthday"),
            font: Constants.labelFont
        )
    }()
    
    private lazy var nameFieldView: UIView = {
        createFieldContainerView()
    }()
    
    private lazy var numberFieldView: UIView = {
        createFieldContainerView()
    }()
    
    private lazy var birthdayFieldView: UIView = {
        createFieldContainerView()
    }()
    
    lazy var nameTextField: UITextField = {
        createTextField(placeholder: LanguageManager.localizedString(for: "Aadhaar name"))
    }()
    
    lazy var numberTextField: UITextField = {
        createTextField(placeholder: LanguageManager.localizedString(for: "Aadhaar number"))
    }()
    
    lazy var birthdayTextField: UITextField = {
        createTextField(placeholder: LanguageManager.localizedString(for: "Birthday"))
    }()
    
    private lazy var calendarIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_icon_image")
        return imageView
    }()
    
    private lazy var datePickerButton: UIButton = {
        UIButton(type: .custom)
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(backgroundImageView)
        
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(confirmButton)
        
        backgroundImageView.addSubview(nameLabel)
        backgroundImageView.addSubview(nameFieldView)
        
        backgroundImageView.addSubview(numberLabel)
        backgroundImageView.addSubview(numberFieldView)
        
        backgroundImageView.addSubview(birthdayLabel)
        backgroundImageView.addSubview(birthdayFieldView)
        
        nameFieldView.addSubview(nameTextField)
        numberFieldView.addSubview(numberTextField)
        
        birthdayFieldView.addSubview(birthdayTextField)
        birthdayFieldView.addSubview(calendarIconImageView)
        birthdayFieldView.addSubview(datePickerButton)
    }
    
    private func setupConstraints() {
        // Background ImageView
        backgroundImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: Constants.contentWidth,
                                     height: Constants.contentHeight))
        }
        
        // Title Label
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.titleTopOffset)
            make.height.equalTo(16)
        }
        
        // Confirm Button
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: Constants.buttonWidth,
                                     height: Constants.buttonHeight))
        }
        
        // Name Section
        setupFieldConstraints(
            label: nameLabel,
            fieldView: nameFieldView,
            topView: titleLabel,
            topOffset: Constants.sectionSpacing
        )
        
        setupTextFieldConstraints(nameTextField, in: nameFieldView)
        
        // Number Section
        setupFieldConstraints(
            label: numberLabel,
            fieldView: numberFieldView,
            topView: nameFieldView,
            topOffset: Constants.sectionSpacing
        )
        
        setupTextFieldConstraints(numberTextField, in: numberFieldView)
        
        // Birthday Section
        setupFieldConstraints(
            label: birthdayLabel,
            fieldView: birthdayFieldView,
            topView: numberFieldView,
            topOffset: Constants.sectionSpacing
        )
        
        // Birthday TextField
        birthdayTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25.pix())
            make.left.equalToSuperview().offset(Constants.fieldPadding)
            make.height.equalTo(40.pix())
        }
        
        // Calendar Icon
        calendarIconImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-Constants.fieldPadding)
            make.size.equalTo(CGSize(width: 8.pix(), height: 16.pix()))
            make.centerY.equalToSuperview()
        }
        
        // Date Picker Button
        datePickerButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindActions() {
        // Confirm Button Action
        confirmButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.sureBlock?()
            })
            .disposed(by: disposeBag)
        
        // Date Picker Button Action
        datePickerButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.showDatePicker()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper Methods
    
    private func updateUI(with model: anyablyModel) {
        nameTextField.text = model.catchtic ?? ""
        numberTextField.text = model.bank ?? ""
        updateBirthdayTextField(with: model.hemeror)
    }
    
    private func updateBirthdayTextField(with dateString: String?) {
        guard let dateString = dateString,
              !dateString.isEmpty,
              dateString != "//" else {
            birthdayTextField.text = ""
            return
        }
        birthdayTextField.text = dateString
    }
    
    private func createLabel(text: String, font: UIFont, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textAlignment = alignment
        label.text = text
        label.textColor = Constants.primaryColor
        label.font = font
        return label
    }
    
    private func createFieldContainerView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        view.backgroundColor = Constants.backgroundColor
        return view
    }
    
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = Constants.fieldFont
        textField.textColor = Constants.primaryColor
        return textField
    }
    
    private func setupFieldConstraints(label: UILabel, fieldView: UIView, topView: UIView, topOffset: CGFloat) {
        label.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(topOffset)
            make.left.equalToSuperview().offset(Constants.horizontalPadding)
            make.width.equalTo(120)
        }
        
        fieldView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(Constants.verticalSpacing)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: Constants.fieldWidth,
                                     height: Constants.fieldHeight))
        }
    }
    
    private func setupTextFieldConstraints(_ textField: UITextField, in containerView: UIView) {
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-Constants.fieldPadding)
            make.left.equalToSuperview().offset(Constants.fieldPadding)
            make.height.equalTo(40.pix())
        }
    }
    
    // MARK: - Date Picker Methods
    
    private func showDatePicker() {
        let datePickerView = createDatePickerView()
        datePickerView.selectDate = parseDate(from: birthdayTextField.text)
        datePickerView.pickerStyle = createDatePickerStyle()
        
        datePickerView.resultBlock = { [weak self] selectDate, _ in
            self?.handleDateSelection(selectDate)
        }
        
        datePickerView.show()
    }
    
    private func createDatePickerView() -> BRDatePickerView {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = LanguageManager.localizedString(for: "Select Date")
        return datePickerView
    }
    
    private func parseDate(from dateString: String?) -> Date {
        guard let dateString = dateString, !dateString.isEmpty else {
            return getDefaultDate()
        }
        
        let dateFormatter = DateFormatter()
        
        // Try different date formats
        dateFormatter.dateFormat = DateFormats.displayFormat
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        dateFormatter.dateFormat = DateFormats.alternativeFormat
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        return getDefaultDate()
    }
    
    private func getDefaultDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.displayFormat
        return dateFormatter.date(from: DateFormats.defaultDate) ?? Date()
    }
    
    private func createDatePickerStyle() -> BRPickerStyle {
        let style = BRPickerStyle()
        style.rowHeight = 44
        style.language = "en"
        style.doneBtnTitle = LanguageManager.localizedString(for: "OK")
        style.cancelBtnTitle = LanguageManager.localizedString(for: "Cancel")
        style.doneTextColor = Constants.doneButtonColor
        style.selectRowTextColor = Constants.doneButtonColor
        style.pickerTextFont = Constants.pickerFont
        style.selectRowTextFont = Constants.pickerFont
        return style
    }
    
    private func handleDateSelection(_ selectedDate: Date?) {
        guard let selectedDate = selectedDate else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.displayFormat
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        birthdayTextField.text = formattedDate
        selectTimeBlock?()
    }
}
