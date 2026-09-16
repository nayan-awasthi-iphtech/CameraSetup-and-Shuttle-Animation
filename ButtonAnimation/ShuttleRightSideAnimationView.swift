//
//  ShuttleRightSideAnimationView.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 16/09/26.

import SwiftUI

struct ShuttleRightSideCompAnimation: View {
    var body: some View {
        ZStack {
            
            CameraSideShape()
                .fill(Color.white)
                .scaleEffect(x: -1, y: 1)
            
            Image(systemName: "star.circle.fill")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.white, Color.blue)
                .frame(width: 34, height: 34)
                .position(x: 140 - (120 * 0.33), y: 290 * 0.8)
            
            CameraSideShape()
                .stroke(
                    Color(red: 0.15, green: 0.17, blue: 0.23),
                    style: StrokeStyle(
                        lineWidth: 11,
                        lineCap: .round
                    )
                )
                .scaleEffect(x: -1, y: 1)
        }
        .frame(width: 140, height: 280)
    }
}

#Preview {
    ShuttleRightSideCompAnimation()
}
