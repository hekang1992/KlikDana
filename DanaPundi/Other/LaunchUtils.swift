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
        let vpnInterfaces = ["utun0", "utun1", "utun2", "utun3"]
        var status = "0"
        
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                if let name = ptr?.pointee.ifa_name,
                   let interfaceName = String(validatingUTF8: name),
                   vpnInterfaces.contains(interfaceName) {
                    status = "1"
                    break
                }
                ptr = ptr?.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return status
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
