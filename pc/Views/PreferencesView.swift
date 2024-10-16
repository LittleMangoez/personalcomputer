//
//  PreferencesView.swift
//  pc
//
//  Created by Matthew Smith on 10/15/24.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var userManager: UserManagement
    @State private var dragOffset: CGFloat = 0
        @State private var currentMode: Int = 1 // 0: Top, 1: Middle, 2: Bottom

        // The three positions: Top, Middle, Bottom
        let positions: [CGFloat] = [-100, 0, 100] // Adjust as needed based on screen size
    
    @State var selectedPreference: 
        
        var body: some View {
            HStack {
                List {
                    <#code#>
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 50) // Adjust bar size
                    .foregroundColor(.blue)
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
                                        currentMode = min(currentMode + 1, 2)
                                    }
                                    
                                    // Set bar position to the new mode
                                    dragOffset = positions[currentMode]
                                }
                            }
                    )
                    .offset(y: positions[currentMode])
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
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
}
