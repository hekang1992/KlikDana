//
//  IDFVManager.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//


import UIKit
import Security

final class IDFVManager {

    private static let keychainKey = "com.yourapp.idfv"

    static func getIDFV() -> String {
        if let idfv = readFromKeychain() {
            return idfv
        }

        let newIDFV = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        saveToKeychain(value: newIDFV)
        return newIDFV
    }

    private static func saveToKeychain(value: String) {
        let data = value.data(using: .utf8)!

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private static func readFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataRef)

        if status == errSecSuccess,
           let data = dataRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
