//
//  ShuttleMainPlaneView.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 16/09/26.
//

import SwiftUI

struct ShuttleCenterCompAnimation: View {
    @State private var showMainBody: Bool = false
    @State private var showInnerCapsule: Bool = false
    @State private var showMainCap: Bool = false
    @State private var showInnerCap: Bool = false
    @State private var showFlameBody: Bool = false
    @State private var showFlameAndCylinderAnimation = false
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: 35,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 8,
                topTrailingRadius: 35,
                style: .continuous
            )
            .fill(Color(red: 0.93, green: 0.95, blue: 0.96))
            .scaleEffect(showMainBody ? 1.0 : 0.01)
            .frame(width: 100, height: 320)
            
            UnevenRoundedRectangle(
                topLeadingRadius: 35,
                bottomLeadingRadius: 4,
                bottomTrailingRadius: 4,
                topTrailingRadius: 35,
                style: .continuous
            )
            .fill(Color(red: 0.15, green: 0.17, blue: 0.23))
            .frame(width: 100, height: 45)
            .offset(y: -138)
            .scaleEffect(showMainCap ? 1.0 : 0.001, anchor: .center)
            
            UnevenRoundedRectangle(
                topLeadingRadius: 80,
                bottomLeadingRadius: 4,
                bottomTrailingRadius: 4,
                topTrailingRadius: 80,
                style: .continuous
            )
            .fill(Color(red: 0.15, green: 0.17, blue: 0.23))
            .frame(width: 32, height: 30)
            .offset(y: -88)
            .scaleEffect(showInnerCap ? 1.0 : 0.001, anchor: .center)
            
            Capsule(style: .continuous)
                .fill(Color.white)
                .frame(width: 40, height: 225)
                .offset(y: 20)
                .scaleEffect(showInnerCapsule ? 1.0 : 0.001)
            
            FlameBody(startAnimation: showFlameAndCylinderAnimation)
                .offset(y: 155)
                .scaleEffect(showFlameBody ? 1.0 : 0.001, anchor: .center)
        }
        
        .onAppear {

            // Main body
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                showMainBody = true
            }

            // Inner capsule
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {

                withAnimation(.spring(response: 0.4, dampingFraction: 0.65)) {
                    showInnerCapsule = true
                }

                // Wait for inner capsule to finish
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {

                    // Cap + inner cap + flame
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.90)) {
                        showMainCap = true     
                        showInnerCap = true
                        showFlameBody = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.99){
                    showFlameAndCylinderAnimation = true
                }
            }
        }
    }
}

#Preview {
    ShuttleCenterCompAnimation()
}
