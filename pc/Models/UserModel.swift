//
//  UserModel.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class UserModel: Identifiable {
    var id: UUID
    var name: String
    var preferences: UserPreferences
    var carPreferences: CarPreferences
    var theme: AppTheme
    
    init(id: UUID, name: String, preferences: UserPreferences, carPreferences: CarPreferences, theme: AppTheme) {
        self.id = id
        self.name = name
        self.preferences = preferences
        self.carPreferences = carPreferences
        self.theme = theme
    }
}

struct UserPreferences: Codable {
    var nudgeFrequency: NudgeFrequency
    var taskReminderTime: Date?
    var notificationSounds: Bool
    var showCompletedTasks: Bool
    var streakTracking: Bool
    
    init(nudgeFrequency: NudgeFrequency, taskReminderTime: Date? = nil, notificationSounds: Bool = true, showCompletedTasks: Bool = true, streakTracking: Bool = true) {
        self.nudgeFrequency = nudgeFrequency
        self.taskReminderTime = taskReminderTime
        self.notificationSounds = notificationSounds
        self.showCompletedTasks = showCompletedTasks
        self.streakTracking = streakTracking
    }
}

enum NudgeFrequency: String, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct CarPreferences: Codable {
    var preferredMaintenanceInterval: Double // In miles or kilometers
    var mileageUnits: MileageUnit
    var notifyForService: Bool
    
    init(preferredMaintenanceInterval: Double = 5000.0, mileageUnits: MileageUnit = .miles, notifyForService: Bool = true) {
        self.preferredMaintenanceInterval = preferredMaintenanceInterval
        self.mileageUnits = mileageUnits
        self.notifyForService = notifyForService
    }
}

enum MileageUnit: String, Codable {
    case miles = "Miles"
    case kilometers = "Kilometers"
    case america = "Glazed Donuts per Bald Eagle"
}

struct AppTheme: Codable {
    var darkMode: Bool
    var accentColor: AppColor
    var fontSize: Double
    
    init(darkMode: Bool = false, accentColor: AppColor = .blue, fontSize: Double = 14.0) {
        self.darkMode = darkMode
        self.accentColor = accentColor
        self.fontSize = fontSize
    }
}

enum AppColor: String, Codable {
    case blue = "Blue"
    case pink = "Pink"
    case green = "Green"
    case purple = "Purple"
    case yellow = "Yellow"
}
