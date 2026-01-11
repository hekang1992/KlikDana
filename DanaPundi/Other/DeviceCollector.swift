//
//  DeviceCollector.swift
//  DanaPundi
//
//  Created by Ethan Carter on 2026/1/8.
//

import UIKit
import SystemConfiguration
import CoreTelephony
import NetworkExtension
import DeviceKit
import SystemConfiguration.CaptiveNetwork

struct DeviceInfo: Codable {
    struct Duria: Codable {
        let lus: String
        let fuscdom: String
        let gastroetic: String
        let roborlaw: String
    }
    
    struct CompanyLike: Codable {
        let clivuous: Int
        let stasisacy: Int
        let himfaction: Int
    }
    
    struct Experienceitious: Codable {
        let issueuous: String
        let scelspringish: String
        let trogloior: String
        let ponsion: String
        let rapacly: Int
        let visain: Int
        let linquess: String
    }
    
    struct Actie: Codable {
        let citous: Int
        let conditionlet: String
        let beyondive: Int
        let awayarian: Int
        let vianeou: Int
    }
    
    struct Timefold: Codable {
        let myxness: String
        let heterofingero: String
        let greenfy: String
        let bagkin: String
        let tragial: String
        let shakeain: String
        let heartacle: String
        let seminard: String
        let sentiice: String
        let lig: Int
        let beacity: String?
        let femin: String
        let ecoesque: String
    }
    
    struct WifiInfo: Codable {
        let pamoon: String
        let mancyship: String
        let femin: String
        let catchtic: String
        let pooral: String
    }
    
    struct Concernial: Codable {
        let kilooon: [WifiInfo]
    }
    
    let duria: Duria
    let companylike: CompanyLike
    let experienceitious: Experienceitious
    let acriform: [String: String]
    let themselves: String
    let actie: Actie
    let timefold: Timefold
    let concernial: Concernial
}

class DeviceInfoManager {
    static let shared = DeviceInfoManager()
    
    private init() {}
    
    private func getStorageInfo() -> (available: UInt64, total: UInt64) {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            let freeSize = (systemAttributes[.systemFreeSize] as? NSNumber)?.uint64Value ?? 0
            let totalSize = (systemAttributes[.systemSize] as? NSNumber)?.uint64Value ?? 0
            return (freeSize, totalSize)
        } catch {
            return (0, 0)
        }
    }
    
    func getMemoryInfoString() -> (total: String, free: String) {
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        var vmStats = vm_statistics64_data_t()
        var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: vmStats) / MemoryLayout<integer_t>.size)
        
        let result = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
            }
        }
        
        var freeMemory: UInt64 = 0
        if result == KERN_SUCCESS {
            let pageSize = UInt64(vm_kernel_page_size)
            freeMemory = UInt64(vmStats.free_count + vmStats.inactive_count) * pageSize
        }
        
        return (
            total: "\(totalMemory)",
            free: "\(freeMemory)"
        )
    }
    
    private func getBatteryInfo() -> (level: Int, isCharging: Int) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let isCharging: Int = UIDevice.current.batteryState == .charging ||
        UIDevice.current.batteryState == .full ? 1 : 0
        return (max(batteryLevel, 0), isCharging)
    }
    
    func getWifiInfo(completion: @escaping (String?, String?) -> Void) {
        if #available(iOS 14.0, *) {
            NEHotspotNetwork.fetchCurrent { network in
                if let network = network {
                    completion(network.bssid, network.ssid)
                } else {
                    self.getWifiInfoLegacy(completion: completion)
                }
            }
        } else {
            getWifiInfoLegacy(completion: completion)
        }
    }
    
    private func getWifiInfoLegacy(completion: @escaping (String?, String?) -> Void) {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            completion(nil, nil)
            return
        }
        
        for interface in interfaces {
            if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] {
                let bssid = interfaceInfo["BSSID"] as? String
                let ssid = interfaceInfo["SSID"] as? String
                completion(bssid, ssid)
                return
            }
        }
        completion(nil, nil)
    }
    
    private func isJailbroken() -> Int {
        let jailbreakFilePaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/"
        ]
        
        for path in jailbreakFilePaths {
            if FileManager.default.fileExists(atPath: path) {
                return 1
            }
        }
        
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(toFile: "/private/JailbreakTest.txt",
                                    atomically: true,
                                    encoding: .utf8)
            return 1
        } catch {
            return 0
        }
    }
    
    func getAllDeviceInfo(completion: @escaping (DeviceInfo?) -> Void) {
        getWifiInfo { [weak self] bssid, ssid in
            guard let self = self else {
                completion(nil)
                return
            }
            
            let storageInfo = self.getStorageInfo()
            
            let memoryInfo = self.getMemoryInfoString()
            
            let batteryInfo = self.getBatteryInfo()
            
#if targetEnvironment(simulator)
            let isSimulator = 1
#else
            let isSimulator = 0
#endif
            
            let isJailbroken = self.isJailbroken()
            
            let info = DeviceInfo(
                duria: DeviceInfo.Duria(
                    lus: "\(storageInfo.available)",
                    fuscdom: "\(storageInfo.total)",
                    gastroetic: "\(memoryInfo.total)",
                    roborlaw: "\(memoryInfo.free)"
                ),
                companylike: DeviceInfo.CompanyLike(
                    clivuous: batteryInfo.level,
                    stasisacy: 180,
                    himfaction: batteryInfo.isCharging
                ),
                experienceitious: DeviceInfo.Experienceitious(
                    issueuous: UIDevice.current.systemVersion,
                    scelspringish: "",
                    trogloior: Device.identifier,
                    ponsion: Device.current.model ?? "",
                    rapacly: Int(UIScreen.main.bounds.height),
                    visain: Int(UIScreen.main.bounds.width),
                    linquess: String(Device.current.diagonal)
                ),
                acriform: [:],
                themselves: "",
                actie: DeviceInfo.Actie(
                    citous: 100,
                    conditionlet: "0",
                    beyondive: isSimulator,
                    awayarian: isJailbroken,
                    vianeou: 0
                ),
                timefold: DeviceInfo.Timefold(
                    myxness: TimeZone.current.abbreviation() ?? "",
                    heterofingero: LaunchUtils.allInfo()["heterofingero"] ?? "",
                    greenfy: LaunchUtils.allInfo()["greenfy"] ?? "",
                    bagkin: "",
                    tragial: IDFVManager.getIDFV(),
                    shakeain: Locale.preferredLanguages.first ?? "en",
                    heartacle: "did",
                    seminard: "89",
                    sentiice: UserDefaults.standard.object(forKey: "net_work_type") as? String ?? "",
                    lig: 1,
                    beacity: getIPAddress() ?? "",
                    femin: bssid ?? "",
                    ecoesque: IDFAManager.shared.getCurrentIDFA()
                ),
                concernial: DeviceInfo.Concernial(
                    kilooon: [
                        DeviceInfo.WifiInfo(
                            pamoon: bssid ?? "",
                            mancyship: ssid ?? "",
                            femin: bssid ?? "",
                            catchtic: ssid ?? "",
                            pooral: "0"
                        )
                    ]
                )
            )
            
            completion(info)
        }
    }
    
    func getIPAddress() -> String? {
        var address: String?
        
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                
                let name = String(cString: interface.ifa_name)
                if name == "en0" || name == "pdp_ip0" {
                    
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }
    
    
}
