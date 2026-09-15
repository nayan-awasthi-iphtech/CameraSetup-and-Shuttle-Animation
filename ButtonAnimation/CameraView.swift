import SwiftUI

struct CameraView: View {
    @State private var circleScale: CGFloat = 0.001
    @State private var isAnimating = false
    @State private var isIndicatorBright = false
    @State private var showShuttleScreen = false
    @State private var hasStarted = false
    @State private var isButtonPressed = false
    @State private var isSetupComplete = false
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.84, blue: 0.20)
                .ignoresSafeArea()
            
            
            if !isSetupComplete {
                CameraSetupAnimation(isSetupComplete: $isSetupComplete)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .zIndex(2)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .opacity(0.9)
                    
                    Rectangle()
                        .fill(Color(red: 0.12, green: 0.16, blue: 0.27))
                        .frame(height: 150)
                }
                .frame(width: 380, height: 280)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // Top-left button
                Button {
                    startCamerAnimation()
                } label: {
                    Rectangle()
                        .fill(Color(red: 0.12, green: 0.16, blue: 0.27))
                        .frame(width: 60, height: 20)
                        .scaleEffect(isButtonPressed ? 0.92 : 1.0)
                        .offset(y: isButtonPressed ? 3 : 0)
                }
                .buttonStyle(.plain)
                .offset(x: -140, y: -149)
                
                // Top-right flash
                Rectangle()
                    .fill(Color(red: 0.36, green: 0.73, blue: 0.82))
                    .frame(width: 48, height: 20)
                    .offset(x: 120, y: -100)
                
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
                
                // Red indicator
                Circle()
                    .fill(
                        isIndicatorBright
                        ? Color.red
                        : Color.red.opacity(0.4)
                    )
                    .frame(width: 20, height: 20)
                    .offset(x: -140, y: -47)
                    .shadow(
                        color: .red.opacity(isIndicatorBright ? 0.8 : 0.1),
                        radius: isIndicatorBright ? 8 : 1
                    )
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 500, height: 500)
                    .scaleEffect(circleScale)
                    .allowsHitTesting(false)
                
                if showShuttleScreen {
                    ShuttleAnimationView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.ignoresSafeArea())
                        .ignoresSafeArea()
                        .transition(.identity)
                        .zIndex(1)
                }
            }
        }
        .onChange(of: isSetupComplete) { _, isComplete in
            guard isComplete else { return }
            
            isButtonPressed = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                startCamerAnimation()
            }
        }
    }
    
    private func startCamerAnimation() {
        guard !isAnimating else { return }
        isAnimating = true
        
        withAnimation(.easeInOut(duration: 0.15)) {
            isButtonPressed = true
        }
        
        let blinkInterval = 0.2
        let totalBlinks = 5
        
        for blink in 0..<totalBlinks {
            let blinkStart = Double(blink) * blinkInterval
            
            DispatchQueue.main.asyncAfter(deadline: .now() + blinkStart) {
                withAnimation(.easeInOut(duration: 0.05)) {
                    isIndicatorBright = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 0.05)) {
                        isIndicatorBright = false
                    }
                    
                    if blink == totalBlinks - 1 {
                        withAnimation(.linear(duration: 0.12)) {
                            circleScale = 3.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                            var transaction = Transaction()
                            transaction.disablesAnimations = true
                            
                            withTransaction(transaction) {
                                showShuttleScreen = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
