//
//  SaveLoginInfo.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

import UIKit

class SaveLoginInfo: NSObject {
    
    private enum Keys {
        static let phone = "user_phone_key"
        static let token = "user_token_key"
    }
    
    static func saveLoginInfo(phone: String, token: String) {
        let defaults = UserDefaults.standard
        defaults.set(phone, forKey: Keys.phone)
        defaults.set(token, forKey: Keys.token)
        defaults.synchronize()
    }
    
    static func getPhone() -> String? {
        return UserDefaults.standard.string(forKey: Keys.phone)
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.token)
    }
    
    static func getLoginInfo() -> (phone: String?, token: String?) {
        return (getPhone(), getToken())
    }
    
    static func deleteLoginInfo() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Keys.phone)
        defaults.removeObject(forKey: Keys.token)
        defaults.synchronize()
    }
    
    static func isLoggedIn() -> Bool {
        return getPhone() != nil && getToken() != nil
    }
}
