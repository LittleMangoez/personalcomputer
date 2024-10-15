//
//  DataManger.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import Foundation
import SwiftUI

class DataManager: ObservableObject {
    
    // Updated handleUserInput with a completion handler for running functions after processing
        func handleUserInput(input: String, completion: @escaping () -> Void) {
            // Normalize input
            let normalizedInput = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

            // Process the input and determine action
            if containsCarMaintenanceKeywords(in: normalizedInput) {
                // Handle car-related tasks
                if let task = extractCarTask(from: normalizedInput) {
                    scheduleCarMaintenance(task)
                    print("Scheduled car maintenance for: \(task)")
                } else {
                    print("Could not recognize car maintenance task.")
                }
            } else if containsNudgeKeywords(in: normalizedInput) {
                // Handle nudge-related tasks
                if let task = extractTask(from: normalizedInput) {
                    scheduleNudge(for: task)
                    print("Scheduled nudge for: \(task)")
                } else {
                    print("Could not recognize nudge task.")
                }
            } else {
                // Default case if the input doesn't match any known types
                print("I didn't understand that. Please try again.")
            }
            
            // Call the completion handler
            completion()
        }
    
    // MARK: - Keyword and Context Detection Functions

    // Detects if the input relates to car maintenance
    func containsCarMaintenanceKeywords(in input: String) -> Bool {
        let carKeywords = ["oil change", "maintenance", "tire rotation", "brakes", "service", "car", "engine"]
        return carKeywords.contains { input.contains($0) }
    }

    // Detects if the input relates to nudges
    func containsNudgeKeywords(in input: String) -> Bool {
        let nudgeKeywords = ["nudge", "remind", "check", "drink", "exercise", "stand up", "meditate", "take a break"]
        return nudgeKeywords.contains { input.contains($0) }
    }

    // MARK: - Task Handlers

    // Handles car-related requests by extracting relevant details
    func handleCarRequest(_ input: String) {
        // Extract car-related task (e.g., "change oil" or "rotate tires")
        if let task = extractCarTask(from: input) {
            scheduleCarMaintenance(task)
        } else {
            print("Unable to parse the car task. Please provide more details.")
        }
    }

    // Handles nudge-related requests by extracting the task to nudge
    func handleNudgeRequest(_ input: String) {
        if let task = extractTask(from: input) {
            scheduleNudge(for: task)
        } else {
            print("Unable to parse the nudge task. Please provide more details.")
        }
    }
    
    // MARK: - Extraction Functions

    // Extracts car maintenance tasks from input
    func extractCarTask(from input: String) -> String? {
        // You could make this more flexible with regex or NLP-based parsing
        let components = input.components(separatedBy: " ")
        // Simple logic: grab keywords after a car-related word
        let maintenanceKeywords = ["change", "rotate", "check", "service"]
        if let keywordIndex = components.firstIndex(where: { maintenanceKeywords.contains($0) }) {
            return components.dropFirst(keywordIndex).joined(separator: " ")
        }
        return nil
    }

    // Extracts nudge tasks from input (similar to original function)
    func extractTask(from input: String) -> String? {
        let components = input.components(separatedBy: "nudge me to ")
        guard components.count > 1 else { return nil }
        return components[1] // Returns the task part
    }
    
    // MARK: - Scheduling Functions

    // Schedule a nudge task
    func scheduleNudge(for task: String) {
        print("Scheduling a nudge for: \(task)")
        // Implement actual scheduling logic here
    }

    // Schedule car maintenance task
    func scheduleCarMaintenance(_ details: String) {
        print("Scheduling car maintenance for: \(details)")
        // Implement actual scheduling logic here
    }
}
