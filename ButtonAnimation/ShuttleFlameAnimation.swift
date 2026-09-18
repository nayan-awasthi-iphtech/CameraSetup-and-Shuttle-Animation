//
//  ShuttleFlameAnimation.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 16/09/26.
//

import SwiftUI

struct FlameBody: View {
    
    var startAnimation: Bool = false
    
    @State private var startCylinderAndFlameAnimation = false
    
    var body: some View {
        HStack(spacing: 10){
            
            ZStack(){
                
                FlameView()
                    .offset(y:54)
                    .scaleEffect(startCylinderAndFlameAnimation ? 1.0 : 0.001, anchor: .center)
                
                FlameCyinder()
                    .scaleEffect(startCylinderAndFlameAnimation ? 1.0 : 0.001, anchor: .center)
                
                UnevenRoundedRectangle(
                    topLeadingRadius: 48,
                    bottomLeadingRadius: 4,
                    bottomTrailingRadius: 4,
                    topTrailingRadius: 13,
                    style: .continuous
                )
                .fill(Color(red: 0.74, green: 0.74, blue: 0.74))
                .frame(width: 45, height: 45)
                
            }
            
            ZStack(){
                
                FlameView()
                    .offset(y:54)
                    .scaleEffect(startCylinderAndFlameAnimation ? 1.0 : 0.001, anchor: .center)
                
                FlameCyinder()
                    .scaleEffect(startCylinderAndFlameAnimation ? 1.0 : 0.001, anchor: .center)
                
                UnevenRoundedRectangle(
                    topLeadingRadius: 13,
                    bottomLeadingRadius: 4,
                    bottomTrailingRadius: 4,
                    topTrailingRadius: 48,
                    style: .continuous
                )
                .fill(Color(red: 0.74, green: 0.74, blue: 0.74))
                .frame(width: 45, height: 45)
            }
        }
        .onChange(of: startAnimation){_, newValue in
            
            guard newValue else { return }
            
            withAnimation(
                .spring(
                    response: 0.9,
                    dampingFraction: 0.9
                )
            ) {
                startCylinderAndFlameAnimation = true
            }
        }
    }
}

struct FlameCyinder: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 28, height: 8)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            // Top of cylinder
            Ellipse()
                .fill(Color.black)
                .frame(width: 28, height: 30)
                .offset(y: -20)
            
            // Bottom of cylinder
            Ellipse()
                .fill(Color.black)
                .frame(width: 28, height: 4)
                .offset(y: -20)
        }
        .offset(x: 0, y: 25)
    }
}

#Preview {
    FlameBody()
}
