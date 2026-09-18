//
//  ShuttleView.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 15/09/26.
//

import SwiftUI

struct ShuttleAnimationView: View {
    @State private var animateLeft: Bool = false
    @State private var animateRight: Bool = false
    @State private var showCenter: Bool = false
    @State private var takeoff: Bool = false
    @State private var showShuttle = true
    @State private var showRoads = false
    
    @State private var leftScale: CGFloat = 1.10
    @State private var rightScale: CGFloat = 1.10
    
    var body: some View {
        ZStack {
            Color(red: 0.45, green: 0.40, blue: 0.90)
                .ignoresSafeArea()
            
            if showRoads {
                RoadAnimationView(isMoving: takeoff)
            }
            
            if showShuttle {
                ZStack {
                    HStack() {
                        ShuttleLeftSideCompAnimation()
                            .scaleEffect(leftScale)
                            .offset(
                                x: animateLeft ? 0 : -180,
                                y: animateLeft ? 0 : -400
                            )
                        
                        ShuttleRightSideCompAnimation()
                            .scaleEffect(rightScale)
                            .offset(
                                x: animateRight ? 0 : 180,
                                y: animateRight ? 0 : -400
                            )
                    }
                    
                    if showCenter {
                        ShuttleCenterCompAnimation()
                            .transition(.opacity)
                    }
                }
                .offset(y: takeoff ? -800 : 0)
            }
        }
        .onAppear {
            // Sequence 1: Left Wing Entry
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 14)) {
                    animateLeft = true
                }
            }
            
            // Left Wing Settle Bounce
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                withAnimation(.spring(response: 0.40, dampingFraction: 0.5)) {
                    leftScale = 1.0
                }
            }
            
            // Sequence 2: Right Wing Entry
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100, damping: 14)) {
                    animateRight = true
                }
                
                // Right Wing Settle Bounce
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation(.spring(response: 0.40, dampingFraction: 0.5)) {
                        rightScale = 1.0
                    }
                }
            }
            
            // Center Animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.50) {
                withAnimation {
                    showCenter = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.5){
                
                showRoads = true
                
                withAnimation(.easeOut(duration: 1.1)){
                    takeoff = true
                }
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
                    showShuttle = false
                    showRoads = false
                }
            }
        }
    }
}

#Preview {
    ShuttleAnimationView()
}
