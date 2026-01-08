//
//  TimeManager.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/8.
//

import Foundation

class TimeManager {
    private static let startTimeKey = "startTime"
    private static let endTimeKey = "endTime"
    
    static func saveStartTime(_ date: String) {
        UserDefaults.standard.set(date, forKey: startTimeKey)
    }
    
    static func saveEndTime(_ date: String) {
        UserDefaults.standard.set(date, forKey: endTimeKey)
    }
    
    static func getStartTime() -> String? {
        return UserDefaults.standard.object(forKey: startTimeKey) as? String
    }
    
    static func getEndTime() -> String? {
        return UserDefaults.standard.object(forKey: endTimeKey) as? String
    }
    
    static func clearStartTime() {
        UserDefaults.standard.removeObject(forKey: startTimeKey)
    }
    
    static func clearEndTime() {
        UserDefaults.standard.removeObject(forKey: endTimeKey)
    }
    
    static func clearAllTimes() {
        clearStartTime()
        clearEndTime()
    }
    
}
