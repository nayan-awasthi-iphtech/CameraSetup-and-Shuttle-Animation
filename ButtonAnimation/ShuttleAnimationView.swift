//
//  ShuttleView.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 15/09/26.
//

import SwiftUI

struct ShuttleAnimationView: View {
    var body: some View {
        ZStack{
            Color.purple.opacity(0.8)
                .ignoresSafeArea()
            
            Text("Shuttle background")
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    ShuttleAnimationView()
}         
