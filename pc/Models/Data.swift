//
//  Data.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import Foundation
import SwiftUI
import SwiftData

struct Task: Identifiable {
    var id: UUID = UUID()
    var title: String
    var dueDate: Date?
    var completed: Bool
    var nudged: Bool
    
    init(id: UUID, title: String, dueDate: Date? = nil, completed: Bool, nudged: Bool) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.completed = completed
        self.nudged = nudged
    }
}

struct PersonalComputationConversation: Identifiable, Codable {
    var id: UUID = UUID()
    var message: String
    var response: String
    var timestamp: Date
}

struct RollingNote: Identifiable, Codable {
    var id: UUID = UUID()
    var content: String
    var timestamp: Date
}

struct CarModel: Identifiable, Codable {
    var id: UUID = UUID()
    var make: String
    var model: String
    var year: Int
    var mileage: Double
    var maintenanceLog: [MaintenanceEntry]
}

struct MaintenanceEntry: Identifiable, Codable {
    var id: UUID = UUID()
    var type: String
    var date: Date
    var notes: String
}
