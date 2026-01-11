//
//  LaunchUtils.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/4.
//

import Foundation
import Network
import SystemConfiguration.CaptiveNetwork

class LaunchUtils {
    
    static func isUsingProxy() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let HTTPEnable = proxySettings[kCFNetworkProxiesHTTPEnable as String] as? Int {
            return HTTPEnable == 1 ? "1" : "0"
        }
        return "0"
    }
    
    static func isUsingVPN() -> String {
        var vpnFound = false
        
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return "0"
        }
        
        if let scoped = settings["__SCOPED__"] as? [String: Any] {
            for (key, _) in scoped {
                if key.contains("tap") || key.contains("tun") ||
                    key.contains("ppp") || key.contains("ipsec") ||
                    key.contains("utun") || key.contains("ipsec0") {
                    vpnFound = true
                    break
                }
            }
        }
        
        return vpnFound ? "1" : "0"
    }
    
    class func religiousmost() -> String {
        return Locale.preferredLanguages.first ?? "en"
    }
    
    class func allInfo() -> [String: String] {
        return [
            "heterofingero": isUsingProxy(),
            "greenfy": isUsingVPN(),
            "religiousmost": religiousmost()
        ]
    }
}
