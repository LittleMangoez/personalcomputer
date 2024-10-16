//
//  DataManger.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import Foundation
import SwiftUI
import NaturalLanguage

class DataManager: ObservableObject {
    
    @Published var currentConversation: Conversation?
    
    // Main function to handle user input and process actions
    func handleUserInput(input: String, completion: @escaping () -> Void) {
        // Normalize input
        let normalizedInput = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("Normalized Input: \(normalizedInput)")
        
        let (verb, noun, task) = detectVerbAndTask(input: normalizedInput)
        
        // Classify task based on verb and noun
        if let classification = classifyTask(verb: verb, noun: noun, task: task) {
            // Synthesize title for the task
            let title = synthesizeTitle(verb: verb, noun: noun, task: task, classification: classification)
            print("Task Title: \(title)")
            
            // Perform the associated action
            performTaskAction(for: classification, title: title)
        } else {
            print("Task could not be classified.")
        }
        
        // Call the completion handler
        completion()
    }

    // MARK: - Task Extraction Functions
    
    func detectVerbAndTask(input: String) -> (verb: String?, noun: String?, task: String?) {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = input
        
        var verb: String?
        var task: String?
        var noun: String?
        
        tagger.enumerateTags(in: input.startIndex..<input.endIndex, unit: .word, scheme: .lexicalClass) { tag, tokenRange in
            if tag == .verb {
                verb = String(input[tokenRange])
            } else if tag == .noun {
                noun = String(input[tokenRange])
            } else if task == nil { // Assume the first non-verb word after is the task
                task = String(input[tokenRange])
            }
            return true
        }
        return (verb, noun, task)
    }
    
    // MARK: - Task Classification
    
    func classifyTask(verb: String?, noun: String?, task: String?) -> String? {
        // Example classification logic based on detected verb and noun
        guard let verb = verb, let noun = noun else { return nil }
        
        if verb == "schedule" || noun.contains("appointment") || noun.contains("maintenance") {
            return "car_maintenance"
        } else if verb == "remind" || noun.contains("reminder") {
            return "reminder"
        }
        
        return nil // Return nil if no classification is made
    }
    
    // MARK: - Title Synthesis
    
    func synthesizeTitle(verb: String?, noun: String?, task: String?, classification: String) -> String {
        // Synthesize a title based on the classification
        switch classification {
        case "reminder":
            return "Reminder: \(verb ?? "") \(task ?? "")"
        case "car_maintenance":
            return "Car Maintenance: \(verb ?? "") \(task ?? "")"
        default:
            return "Unclassified Task"
        }
    }
    
    // MARK: - Task Actions
    
    func performTaskAction(for classification: String, title: String) {
        // Perform actions based on task classification
        switch classification {
        case "reminder":
            print("Creating a reminder: \(title)")
            // Call function to create a reminder
        case "car_maintenance":
            print("Scheduling car maintenance: \(title)")
            // Call function to schedule car maintenance
        default:
            print("No action associated with classification.")
        }
    }
}
