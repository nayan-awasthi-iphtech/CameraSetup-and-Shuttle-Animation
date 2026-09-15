//
//  CameraSetupAnimation.swift
//  ButtonAnimation
//
//  Created by iPHTech 30 on 15/09/26.
//

import SwiftUI

struct CameraSetupAnimation: View {
    @Binding var isSetupComplete: Bool

    @State private var showInnerRectangle = false
    @State private var showMainBody = false
    @State private var showLens = false
    @State private var showFlash = false
    @State private var showRedIndicator = false
    @State private var showTopLeftButton = false
    @State private var cameraSettled = false

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .opacity(0.9)
                    .opacity(showMainBody ? 1 : 0)
                    .offset(y: showMainBody ? 0 : 55)
     
                // Inner rectangle: zooms in first
                Rectangle()
                    .fill(Color(red: 0.12, green: 0.16, blue: 0.27))
                    .frame(height: 150)
                    .scaleEffect(showInnerRectangle ? 1 : 0.1)
                    .opacity(showInnerRectangle ? 1 : 0)
            }
            .frame(width: 380, height: 280)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // Top-left button
            Rectangle()
                .fill(Color(red: 0.12, green: 0.16, blue: 0.27))
                .frame(width: 60, height: 20)
                .offset(x: -140, y: -149)
                .offset(x: showTopLeftButton ? 0 : -45)
                .opacity(showTopLeftButton ? 1 : 0)

            // Top-right flash
            Rectangle()
                .fill(Color(red: 0.36, green: 0.73, blue: 0.82))
                .frame(width: 48, height: 20)
                .offset(x: 120, y: -100)
                .offset(x: showFlash ? 0 : 45)
                .opacity(showFlash ? 1 : 0)

            // Main camera lens
            ZStack {
                Circle()
                    .fill(Color(red: 0.12, green: 0.16, blue: 0.17))
                    .frame(width: 212, height: 212)

                Circle()
                    .fill(Color(red: 0.91, green: 0.92, blue: 0.93))
                    .frame(width: 216, height: 180)

                Circle()
                    .fill(Color(red: 0.55, green: 0.83, blue: 0.89))
                    .frame(width: 136, height: 136)

                Circle()
                    .fill(Color(red: 0.36, green: 0.73, blue: 0.82))
                    .frame(width: 48, height: 48)

                Circle()
                    .fill(Color.white)
                    .frame(width: 14, height: 14)
                    .offset(x: -20, y: -16)
            }
            .offset(x: showLens ? 0 : -45)
            .opacity(showLens ? 1 : 0)

            // Red indicator
            Circle()
                .fill(Color.red.opacity(0.4))
                .frame(width: 20, height: 20)
                .offset(x: -140, y: -47)
                .offset(y: showRedIndicator ? 0 : -30)
                .opacity(showRedIndicator ? 1 : 0)
        }
        .scaleEffect(cameraSettled ? 1 : 0.98)
        .onAppear {
            startEntranceAnimation()
        }
    }

    private func startEntranceAnimation() {
        // 1. Inner rectangle zooms in
        withAnimation(.spring(response: 0.45, dampingFraction: 0.78)) {
            showInnerRectangle = true
        }

        // 2. Main white body
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.82)) {
                showMainBody = true
            }
        }

        // 3. Lens
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.78)) {
                showLens = true
            }
        }

        // 4. Flash
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.82) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                showFlash = true
            }
        }

        // 5. Red indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.98) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                showRedIndicator = true
            }
        }

        // 6. Top-left button
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.14) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                showTopLeftButton = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.20)) {
                cameraSettled = true
            }

            // Tell CameraView the setup has finished after the bounce
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                isSetupComplete = true
            }
        }
    }
}

#Preview {
    CameraSetupAnimation(isSetupComplete: .constant(false))
}
