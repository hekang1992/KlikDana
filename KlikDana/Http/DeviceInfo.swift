//
//  DeviceInfo.swift
//  KlikDana
//
//  Created by hekang on 2026/1/4.
//

import Foundation
import SystemConfiguration

class LaunchParaInfo {
    
    class func heterofingero() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let HTTPEnable = proxySettings[kCFNetworkProxiesHTTPEnable as String] as? Int {
            return HTTPEnable == 1 ? "1" : "0"
        }
        return "0"
    }
    
    class func greenfy() -> String {
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
        return Locale.current.identifier
    }
    
    class func allInfo() -> [String: String] {
        return [
            "heterofingero": heterofingero(),
            "greenfy": greenfy(),
            "religiousmost": religiousmost()
        ]
    }
}
