//
//  pcApp.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import SwiftUI
import SwiftData

var genericUser = UserModel(id: UUID(), name: "Generic", preferences: UserPreferences(nudgeFrequency: .high), carPreferences: CarPreferences(), theme: AppTheme())

@main
struct pcApp: App {
    @State var userManager = UserManagement(user: genericUser)
    var container: ModelContainer
    
    init() {
            do {
                let storeURL = URL.documentsDirectory.appending(path: "database.sqlite")
                let config = ModelConfiguration(url: storeURL)
                let schema = Schema([Conversation.self, UserModel.self])
                container = try ModelContainer(for: schema, configurations: config)
            } catch {
                fatalError("Failed to configure SwiftData container.")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(userManager)
        }
    }
}
