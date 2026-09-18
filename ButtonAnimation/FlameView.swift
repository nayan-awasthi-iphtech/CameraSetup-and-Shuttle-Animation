import SwiftUI

struct FlameView: View {

    @State private var flameMove = false

    var body: some View {
        FlameShape()
            .fill(
                LinearGradient(
                    colors: [
                        Color.yellow,
                        Color.orange,
                        Color.red
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 40, height: 50)
            .offset(x: flameMove ? 3 : -3)
            .rotationEffect(.degrees(flameMove ? 2 : -2))
            .animation(
                .easeInOut(duration: 0.18)
                .repeatForever(autoreverses: true),
                value: flameMove
            )
            .onAppear {
                flameMove = true
            }
    }
}

struct FlameShape: Shape {

    func path(in rect: CGRect) -> Path {

        let w = rect.width
        let h = rect.height

        var path = Path()

        // Top-left
        path.move(
            to: CGPoint(
                x: w * 0.25,
                y: 0
            )
        )

        // Top-right
        path.addLine(
            to: CGPoint(
                x: w * 0.75,
                y: 0
            )
        )

        // Right flame curve
        path.addCurve(
            to: CGPoint(
                x: w * 0.80,
                y: h
            ),
            control1: CGPoint(
                x: w * 0.95,
                y: h * 0.35
            ),
            control2: CGPoint(
                x: w * 0.85,
                y: h * 0.75
            )
        )

        // Left flame curve
        path.addCurve(
            to: CGPoint(
                x: w * 0.25,
                y: 0
            ),
            control1: CGPoint(
                x: w * 0.20,
                y: h * 0.70
            ),
            control2: CGPoint(
                x: w * 0.05,
                y: h * 0.60
            )
        )

        path.closeSubpath()

        return path
    }
}

#Preview {
    FlameView()
}
