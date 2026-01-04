//
//  AppLanguage.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import Foundation

enum AppLanguage: String {
    case en = "70622"
    case id = "70611"
    
    var localeIdentifier: String {
        switch self {
        case .en: return "en"
        case .id: return "id"
        }
    }
    
    var code: String {
        switch self {
        case .en: return "70622"
        case .id: return "70611"
        }
    }
    
    init?(code: String) {
        switch code {
        case "70622":
            self = .en
        case "70611":
            self = .id
        default:
            return nil
        }
    }
}

class LanguageManager {
    static let shared = LanguageManager()
    
    private let userDefaultsKey = "app_language"
    private var currentBundle: Bundle = .main
    
    private init() {
        setupInitialLanguage()
    }
    
    private func setupInitialLanguage() {
        let savedRawValue = UserDefaults.standard.string(forKey: userDefaultsKey)
        let language = AppLanguage(rawValue: savedRawValue ?? "") ?? .en
        updateBundle(for: language)
    }
    
    func setLanguage(_ language: AppLanguage) {
        updateBundle(for: language)
        UserDefaults.standard.set(language.rawValue, forKey: userDefaultsKey)
    }
    
    func setLanguage(code: String) {
        guard let language = AppLanguage(code: code) else {
            print("Warning: Invalid language code: \(code), defaulting to English")
            setLanguage(.en)
            return
        }
        setLanguage(language)
    }
    
    private func updateBundle(for language: AppLanguage) {
        if let path = Bundle.main.path(forResource: language.localeIdentifier, ofType: "lproj"),
           let langBundle = Bundle(path: path) {
            currentBundle = langBundle
        } else {
            currentBundle = .main
            print("Warning: Could not load bundle for language: \(language.localeIdentifier)")
        }
    }
    
    func localizedString(for key: String) -> String {
        return currentBundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    var currentLanguage: AppLanguage {
        guard let savedRawValue = UserDefaults.standard.string(forKey: userDefaultsKey),
              let language = AppLanguage(rawValue: savedRawValue) else {
            return .en
        }
        return language
    }
    
    static var bundle: Bundle {
        return shared.currentBundle
    }
    
    static func setLanguage(code: String) {
        shared.setLanguage(code: code)
    }
    
    static func setLanguage(_ language: AppLanguage) {
        shared.setLanguage(language)
    }
    
    static func localizedString(for key: String) -> String {
        return shared.localizedString(for: key)
    }
    
    static var currentLanguage: AppLanguage {
        return shared.currentLanguage
    }
}
