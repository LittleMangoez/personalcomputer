//
//  ContentView.swift
//  pc
//
//  Created by Matthew Smith on 10/14/24.
//

import SwiftUI

struct ContentView: View {
    @State var user: UserModel
    @State var prompt: String = ""
    @ObservedObject var manager = DataManager()
    var body: some View {
        ZStack {
            VStack {
                Text("Hey, \(user.name)!")
                Spacer()
                TextField("What can I do for you?", text: $prompt)
                    .submitLabel(.send)
                    .onSubmit {
                        print("Sending to parser")
                        manager.handleUserInput(prompt)
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(user: genericUser)
}
