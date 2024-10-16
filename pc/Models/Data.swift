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

@Model
class RollingNote: Identifiable {
    var id: UUID = UUID()
    var content: String
    var timestamp: Date
    
    init(id: UUID, content: String, timestamp: Date) {
        self.id = id
        self.content = content
        self.timestamp = timestamp
    }
}

@Model
class CarModel: Identifiable {
    var id: UUID = UUID()
    var make: String
    var model: String
    var year: Int
    var mileage: Double
    var maintenanceLog: [MaintenanceEntry]
    
    init(id: UUID, make: String, model: String, year: Int, mileage: Double, maintenanceLog: [MaintenanceEntry]) {
        self.id = id
        self.make = make
        self.model = model
        self.year = year
        self.mileage = mileage
        self.maintenanceLog = maintenanceLog
    }
}

@Model
class MaintenanceEntry: Identifiable {
    var id: UUID = UUID()
    var type: String
    var date: Date
    var notes: String
    
    init(id: UUID, type: String, date: Date, notes: String) {
        self.id = id
        self.type = type
        self.date = date
        self.notes = notes
    }
}

@Model
class Conversation: Identifiable {
    var id: UUID = UUID()
    var messages: [ConvMessage]
    var timestamp: Date
    
    init(id: UUID, messages: [ConvMessage], timestamp: Date) {
        self.id = id
        self.messages = messages
        self.timestamp = timestamp
    }
}

@Model
class ConvMessage: Identifiable {
    var text: String
    var deepLink: DeepLinkType
    var carModel: CarModel?
    var Note: RollingNote?
    var id: UUID = UUID()
    
    init(text: String, deepLink: DeepLinkType, carModel: CarModel? = nil, Note: RollingNote? = nil, id: UUID) {
        self.text = text
        self.deepLink = deepLink
        self.carModel = carModel
        self.Note = Note
        self.id = id
    }
}

enum DeepLinkType: String, Codable {
    case car
    case note
    case none
}
