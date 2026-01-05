//
//  RequestParamBuilder.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//


import UIKit

final class RequestParamBuilder {

    static func build() -> [String: Any] {

        let idfv = IDFVManager.getIDFV()

        return [
            "ov": terminalVersion,
            "thus": appVersion,
            "lotfication": deviceName,
            "bagably": idfv,
            "doctesque": idfv,
            "opt": osVersion,
            "aurose": market,
            "pacho": SaveLoginInfo.getToken() ?? "",
            "controlety": language
        ]
    }
}

private extension RequestParamBuilder {

    static var terminalVersion: String {
        return "ios"
    }

    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    static var deviceName: String {
        return UIDevice.current.model
    }

    static var osVersion: String {
        return UIDevice.current.systemVersion
    }

    static var market: String {
        return "DanaPundi"
    }

    static var language: String {
        let code = LanguageManager.shared.currentLanguage.code
        return String(code)
    }
}

