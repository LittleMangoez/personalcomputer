//
//  pcApp.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import SwiftUI

var genericUser = UserModel(id: UUID(), name: "Generic", preferences: UserPreferences(nudgeFrequency: .high), carPreferences: CarPreferences(), theme: AppTheme())

@main
struct pcApp: App {
    @State var userManager = UserManagement(user: genericUser)
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(userManager)
        }
    }
}
