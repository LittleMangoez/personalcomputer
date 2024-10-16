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
                
                if (manager.currentConversation != nil) {
                    ForEach(manager.currentConversation!.messages) { message in
                        Text(message.text)
                    }
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
        }.onAppear(perform: {
            let newConversation = Conversation(id: UUID(), messages: [], timestamp: Date())
            manager.currentConversation = newConversation
            print("Conversation Created")
            let newMessage = ConvMessage(text: "Hey, what's on your mind?", deepLink: .none, id: UUID())
            manager.currentConversation!.messages.append(newMessage)
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
