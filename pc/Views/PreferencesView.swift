//
//  PreferencesView.swift
//  pc
//
//  Created by Matthew Smith on 10/15/24.
//

import SwiftUI
import UIKit

enum preferenceType: String, CaseIterable, Identifiable {
    case nudgeFreq = "Nudge Frequency"
    case notifSound = "Notification Sound"
    case showTasks = "Show Tasks"
    case streakTrack = "Streak Tracking"
    
    var id: String { self.rawValue }
}

struct PreferencesView: View {
    @EnvironmentObject var userManager: UserManagement
    @State private var dragOffset: CGFloat = 0
    @State private var nudgeMode: Int = 1 // 0: Top, 1: Middle, 2: Bottom
    @State private var currentMode: Int = 0 // 0: Top, 1: Bottom
    
    @State var prefTypes: [preferenceType] = [.nudgeFreq, .notifSound, .showTasks, .streakTrack]

    // The three positions: Top, Middle, Bottom
    let nudgePositions: [CGFloat] = [-100, 0, 100] // Adjust as needed based on screen size
    let positions: [CGFloat] = [-100, 100] // Adjust as needed based on screen size
    
    @State var selectedPreference: preferenceType = .nudgeFreq
    
    // Helper function to display user's preference based on type
    func displayPreference(for pref: preferenceType) -> Any {
        switch pref {
        case .nudgeFreq:
            return userManager.user.preferences.nudgeFrequency
        case .notifSound:
            return userManager.user.preferences.notificationSounds
        case .showTasks:
            return userManager.user.preferences.showCompletedTasks
        case .streakTrack:
            return userManager.user.preferences.streakTracking
        }
    }
        
        var body: some View {
            HStack {
                VStack(spacing: 50) {
                    ForEach(prefTypes) { type in
                        Button {
                            selectedPreference = type
                            initializeSliders()
                        } label: {
                            VStack {
                                Text(type.rawValue)
                                
                                Text("\(displayPreference(for: type))")
                            }
                            .padding(5)
                        }
                    }
                    
                }.padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    DotGrid(rows: 50, columns: 8).opacity(0.08)
                    
                    VStack {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundStyle(Color.gray)
                            .symbolEffect(.bounce, value: 2)
                            .padding(.top, 25)
                        Spacer()
                        Image(systemName: "arrow.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundStyle(Color.gray)
                            .symbolEffect(.bounce, value: 2)
                    }.padding()
                    
                    if selectedPreference == .nudgeFreq {
                        nudgeSlider
                            .padding(.horizontal)
                    } else {
                        slider
                            .padding(.horizontal)
                    }
                }.frame(width: 60)
                    .padding()
                    .ignoresSafeArea(.container)
                
            }.onAppear {
                initializeSliders()
            }
        }
    
    var slider: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 100) // Adjust bar size
            .foregroundColor(.gray)
            .offset(y: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.height + positions[currentMode]
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            // Detect flick/swipe direction
                            let swipeDirection = value.predictedEndTranslation.height
                            
                            // Move to next/previous mode based on swipe direction
                            if swipeDirection < -100 {
                                currentMode = max(currentMode - 1, 0)
                            } else if swipeDirection > 100 {
                                currentMode = min(currentMode + 1, 1)
                            }
                            
                            // Set bar position to the new mode
                            dragOffset = positions[currentMode]
                        }
                        
                        // Trigger light impact haptic feedback
                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                        impactFeedback.impactOccurred()
                    }
            )
            .offset(y: positions[currentMode])
            .onChange(of: currentMode) { oldValue, newValue in
                if selectedPreference == .nudgeFreq {
                    print("Not applicable")
                } else if selectedPreference == .notifSound {
                    print("Notification Sounds")
                    if newValue == 0 {
                        userManager.user.preferences.notificationSounds = true
                    } else {
                        userManager.user.preferences.notificationSounds = false
                    }
                } else if selectedPreference == .showTasks {
                    print("Show tasks")
                    if newValue == 0 {
                        userManager.user.preferences.showCompletedTasks = true
                    } else {
                        userManager.user.preferences.showCompletedTasks = false
                    }
                } else if selectedPreference == .streakTrack {
                    print("Streak tracking")
                    if newValue == 0 {
                        userManager.user.preferences.streakTracking = true
                    } else {
                        userManager.user.preferences.streakTracking = false
                    }
                }
            }
    }
    var nudgeSlider: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 100) // Adjust bar size
            .foregroundColor(.gray)
            .offset(y: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.height + nudgePositions[nudgeMode]
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            // Detect flick/swipe direction
                            let swipeDirection = value.predictedEndTranslation.height
                            
                            // Move to next/previous mode based on swipe direction
                            if swipeDirection < -100 {
                                nudgeMode = max(nudgeMode - 1, 0)
                            } else if swipeDirection > 100 {
                                nudgeMode = min(nudgeMode + 1, 2)
                            }
                            
                            // Set bar position to the new mode
                            dragOffset = nudgePositions[nudgeMode]
                        }
                        // Trigger light impact haptic feedback
                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                        impactFeedback.impactOccurred()
                    }
            )
            .offset(y: nudgePositions[nudgeMode])
            .onChange(of: nudgeMode) { oldValue, newValue in
                if nudgeMode == 2 {
                    userManager.user.preferences.nudgeFrequency = .low
                } else if nudgeMode == 1 {
                    userManager.user.preferences.nudgeFrequency = .medium
                } else if nudgeMode == 0 {
                    userManager.user.preferences.nudgeFrequency = .high
                }
            }
    }
    
    func initializeSliders() {
            // Set nudgeMode based on saved preference
            switch userManager.user.preferences.nudgeFrequency {
            case .low:
                nudgeMode = 2
            case .medium:
                nudgeMode = 1
            case .high:
                nudgeMode = 0
            }
            
            // Set dragOffset for nudgeSlider
        withAnimation {
            dragOffset = nudgePositions[nudgeMode]
        }
            
            // Set currentMode based on saved preference
            if selectedPreference == .notifSound {
                currentMode = userManager.user.preferences.notificationSounds ? 0 : 1
            } else if selectedPreference == .showTasks {
                currentMode = userManager.user.preferences.showCompletedTasks ? 0 : 1
            } else if selectedPreference == .streakTrack {
                currentMode = userManager.user.preferences.streakTracking ? 0 : 1
            }
            
            // Set dragOffset for other sliders
        withAnimation {
            dragOffset = positions[currentMode]
        }
    }
}

struct DotGrid: Shape {
    var rows: Int
    var columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSpacing = rect.height / CGFloat(rows)
        let columnSpacing = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                let x = columnSpacing * CGFloat(column) + columnSpacing / 2
                let y = rowSpacing * CGFloat(row) + rowSpacing / 2
                path.addEllipse(in: CGRect(x: x, y: y, width: 5, height: 5))
            }
        }
        
        return path
    }
}


#Preview {
    PreferencesView()
        .environmentObject(UserManagement(user: genericUser))
}
