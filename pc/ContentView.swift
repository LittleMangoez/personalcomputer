//
//  ContentView.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userManager: UserManagement
    @State var prompt: String = ""
    @ObservedObject var manager = DataManager()
    var body: some View {
        ZStack {
            VStack {
                NavigationLink {
                    PreferencesView()
                } label: {
                    Text("Hey, \(userManager.user.name)!")
                }

                Spacer()
                TextField("What can I do for you?", text: $prompt)
                    .submitLabel(.send)
                    .onSubmit {
                        print("Sending to parser")
                        manager.handleUserInput(input: prompt) {
                            prompt = ""
                        }
                            
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
