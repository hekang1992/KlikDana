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
    
    private func getMemoryInfo() -> (total: UInt64, free: UInt64) {
        var totalMemory: UInt64 = 0
        var freeMemory: UInt64 = 0
        
        var size = MemoryLayout<UInt64>.size
        sysctlbyname("hw.memsize", &totalMemory, &size, nil, 0)
        
        var vmStats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size) / 4
        
        let hostPort = mach_host_self()
        let status = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &count)
            }
        }
        
        if status == KERN_SUCCESS {
            let pageSize = UInt64(vm_kernel_page_size)
            freeMemory = UInt64(vmStats.free_count) * pageSize
        }
        
        return (totalMemory, freeMemory)
    }
    
    private func getBatteryInfo() -> (level: Int, isCharging: Int) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
        let isCharging: Int = UIDevice.current.batteryState == .charging ||
        UIDevice.current.batteryState == .full ? 1 : 0
        return (max(batteryLevel, 0), isCharging)
    }
    
    private func getDeviceInfo() -> (model: String, originalModel: String, screenSize: (width: Int, height: Int), physicalSize: String) {
        let device = UIDevice.current
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String(cString: ptr)
            }
        }
        
        let screenSize = UIScreen.main.bounds
        let width = Int(screenSize.width * UIScreen.main.scale)
        let height = Int(screenSize.height * UIScreen.main.scale)
        
        let physicalSize: String
        switch modelCode {
        case "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3":
            physicalSize = "6.7"
        case "iPhone14,6", "iPhone15,4", "iPhone15,5":
            physicalSize = "6.1"
        case "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4":
            physicalSize = "6.1"
        case "iPhone12,1", "iPhone12,3", "iPhone12,5":
            physicalSize = "6.1"
        case "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8":
            physicalSize = "6.5"
        case "iPhone10,1", "iPhone10,4", "iPhone10,2", "iPhone10,5":
            physicalSize = "5.5"
        default:
            physicalSize = "Unknown"
        }
        
        return (device.model, modelCode, (width, height), physicalSize)
    }
    
    private func getNetworkInfo() -> (carrierName: String, networkType: String, ipAddress: String?) {
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.serviceSubscriberCellularProviders?.values.first
        let carrierName = carrier?.carrierName ?? ""
        
        var networkType = ""
        if let currentRadioTech = networkInfo.serviceCurrentRadioAccessTechnology?.values.first {
            switch currentRadioTech {
            case CTRadioAccessTechnologyGPRS,
                CTRadioAccessTechnologyEdge,
            CTRadioAccessTechnologyCDMA1x:
                networkType = "2G"
            case CTRadioAccessTechnologyWCDMA,
                CTRadioAccessTechnologyHSDPA,
                CTRadioAccessTechnologyHSUPA,
                CTRadioAccessTechnologyCDMAEVDORev0,
                CTRadioAccessTechnologyCDMAEVDORevA,
                CTRadioAccessTechnologyCDMAEVDORevB,
            CTRadioAccessTechnologyeHRPD:
                networkType = "3G"
            case CTRadioAccessTechnologyLTE:
                networkType = "4G"
            default:
                networkType = "Unknown Network"
            }
        } else {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = []
            if let defaultRouteReachability = defaultRouteReachability,
               SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                if flags.contains(.reachable) && !flags.contains(.isWWAN) {
                    networkType = "WIFI"
                }
            }
        }
        
        var ipAddress: String? = nil
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name = String(cString: (interface?.ifa_name)!)
                    if name == "en0" || name.hasPrefix("en") {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr,
                                    socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname,
                                    socklen_t(hostname.count),
                                    nil,
                                    0,
                                    NI_NUMERICHOST)
                        ipAddress = String(cString: hostname)
                        break
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return (carrierName, networkType, ipAddress)
    }
    
    func getWifiInfo(completion: @escaping (String?, String?) -> Void) {
        if #available(iOS 14.0, *) {
            NEHotspotNetwork.fetchCurrent { network in
                if let network = network {
                    completion(network.bssid, network.ssid)
                } else {
                    // 回退到旧方法
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
            
            let memoryInfo = self.getMemoryInfo()
            
            let batteryInfo = self.getBatteryInfo()
            
            let deviceInfo = self.getDeviceInfo()
            
            let networkInfo = self.getNetworkInfo()
            
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
                    scelspringish: "Apple",
                    trogloior: deviceInfo.originalModel,
                    ponsion: deviceInfo.model,
                    rapacly: deviceInfo.screenSize.height,
                    visain: deviceInfo.screenSize.width,
                    linquess: deviceInfo.physicalSize
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
                    bagkin: networkInfo.carrierName,
                    tragial: IDFVManager.getIDFV(),
                    shakeain: Locale.preferredLanguages.first ?? "en",
                    heartacle: "did",
                    seminard: "89",
                    sentiice: networkInfo.networkType,
                    lig: 1,
                    beacity: networkInfo.ipAddress,
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
}
