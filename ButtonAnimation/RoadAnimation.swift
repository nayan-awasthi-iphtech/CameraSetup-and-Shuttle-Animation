import SwiftUI

struct RoadAnimationView: View {

    let isMoving: Bool

    @State private var roadOffset: CGFloat = 0

    var body: some View {

        ZStack {
            // LEFT ROADS
            Capsule()
                .fill(Color.white.opacity(0.08))
                .frame(width: 30, height: 300)
                .offset(
                    x: -150,
                    y: roadOffset + 120
                )

            Capsule()
                .fill(Color.white.opacity(0.08))
                .frame(width: 30, height: 300)
                .offset(
                    x: -150,
                    y: roadOffset - 210
                )

            // RIGHT ROADS
            
            Capsule()
                .fill(Color.white.opacity(0.08))
                .frame(width: 30, height: 300)
                .offset(
                    x: 150,
                    y: roadOffset + 120
                )

            Capsule()
                .fill(Color.white.opacity(0.08))
                .frame(width: 30, height: 300)
                .offset(
                    x: 150,
                    y: roadOffset - 210
                )
        }
        .onChange(of: isMoving) { _, newValue in

            if newValue {

                roadOffset = 100

                withAnimation(
                    .linear(duration: 0.6)
                    .repeatForever(autoreverses: false)
                ) {
                    roadOffset = 800
                }
            }
        }
    }
}

#Preview {
    ZStack {

        Color(red: 0.45, green: 0.40, blue: 0.90)
            .ignoresSafeArea()

        RoadAnimationView(isMoving: true)
    }
}
