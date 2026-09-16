////
////  ShuttleSideCompAnimation.swift
////  ButtonAnimation
////
////  Created by iPHTech 30 on 16/09/26.

import SwiftUI

struct ShuttleLeftSideCompAnimation: View {
    var body: some View {
        ZStack {
            // Main light-gray shape
            CameraSideShape()
                .fill(Color.white)
            
            Image(systemName: "star.circle.fill")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.white, Color.blue)
                .frame(width: 34, height: 34)
                .position(x: 120 * 0.33, y: 290 * 0.8)
            
            // Dark outline with smooth line joints
            CameraSideShape()
                .stroke(
                    Color(red: 0.15, green: 0.17, blue: 0.23),
                    style: StrokeStyle(
                        lineWidth: 11,
                        lineCap: .round
                    )
                )
        }
        .frame(width: 140, height: 280)
    }
}

struct CameraSideShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        var path = Path()
        
        // 1. Start near bottom-left corner
        path.move(to: CGPoint(x: w * 0.12, y: h * 0.94))
        
        // Bottom Edge -> Bottom-Right Corner Curve
        path.addLine(to: CGPoint(x: w * 0.74, y: h * 0.94))
        
        // 2. Straightened Right Edge (from bottom to top)
        path.addLine(to: CGPoint(x: w * 0.76, y: h * 0.06))
        
        // 3. Top Edge
        path.addLine(to: CGPoint(x: w * 0.75, y: h * 0.06))
        
        // Top-Left Inner Smooth Transition
        path.addCurve(
            to: CGPoint(x: w * 0.65, y: h * 0.3),
            control1: CGPoint(x: w * 0.62, y: h * 0.12),
            control2: CGPoint(x: w * 0.67, y: h * 0.22)
        )
        
        // Diagonal Inner Slope
        path.addCurve(
            to: CGPoint(x: w * 0.56, y: h * 0.51),
            control1: CGPoint(x: w * 0.64, y: h * 0.3),
            control2: CGPoint(x: w * 0.68, y: h * 0.3)
        )
        
        // Left Upper Smooth Curve
        path.addCurve(
            to: CGPoint(x: w * 0.48, y: h * 0.65),
            control1: CGPoint(x: w * 0.61, y: h * 0.44),
            control2: CGPoint(x: w * 0.51, y: h * 0.57)
        )
        
        // Left Lower Outer Arc
        path.addCurve(
            to: CGPoint(x: w * -0.05, y: h * 0.84),
            control1: CGPoint(x: w * 0.44, y: h * 0.68),
            control2: CGPoint(x: w * 0.12, y: h * 0.70)
        )
        
        // Left Bottom Edge -> Bottom-Left Corner Curve
        path.addCurve(
            to: CGPoint(x: w * -0.08, y: h * 0.94),
            control1: CGPoint(x: w * -0.08, y: h * 0.86),
            control2: CGPoint(x: w * -0.09, y: h * 0.94)
        )
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    ShuttleLeftSideCompAnimation()
}
