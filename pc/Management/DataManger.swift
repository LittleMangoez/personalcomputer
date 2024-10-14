//
//  DataManger.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import Foundation
import SwiftUI

class DataManager: ObservableObject {
    func handleUserInput(_ input: String) {
        // Normalize input
        let normalizedInput = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // Check for nudges
        if normalizedInput.contains("nudge") {
            // Extract the task (e.g., "drink water")
            if let task = extractTask(from: normalizedInput) {
                scheduleNudge(for: task)
            }
        } else if normalizedInput.contains("car") {
            // Extract details for car maintenance
            if let details = extractCarMaintenanceDetails(from: normalizedInput) {
                scheduleCarMaintenance(details)
            }
        } else {
            // Handle other commands or feedback
            print("I didn't understand that. Please try again.")
        }
    }
    
    // Function to extract task from the input
    func extractTask(from input: String) -> String? {
        // Simple extraction logic (you can enhance this with regex or more complex logic)
        let components = input.components(separatedBy: "nudge me to ")
        guard components.count > 1 else { return nil }
        return components[1] // Returns the task part
    }

    // Function to schedule a nudge
    func scheduleNudge(for task: String) {
        // Implement scheduling logic here
        print("Scheduling a nudge for: \(task)")
    }

    // Function to extract car maintenance details from input
    func extractCarMaintenanceDetails(from input: String) -> String? {
        // Simple logic to extract car maintenance details
        let components = input.components(separatedBy: "car maintenance ")
        guard components.count > 1 else { return nil }
        return components[1] // Returns the details part
    }

    // Function to schedule car maintenance
    func scheduleCarMaintenance(_ details: String) {
        // Implement car maintenance scheduling logic here
        print("Scheduling car maintenance for: \(details)")
    }
}
