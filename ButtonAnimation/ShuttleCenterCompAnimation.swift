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
            
        }
        .frame(width: 60, height: 320)
        
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                showMainBody = true
            }
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.65)) {
                    showInnerCapsule = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)){
                    showMainCap = true
                    showInnerCap = true
                }
            }
        }
    }
}

#Preview {
    ShuttleCenterCompAnimation()
}
