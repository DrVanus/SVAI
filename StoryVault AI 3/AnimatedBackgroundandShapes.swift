
import SwiftUI

// MARK: - Animated Gradient Background

struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        let gradient1 = [Color.black, Color.indigo.opacity(0.8)]
        let gradient2 = [Color.purple, Color.blue.opacity(0.8)]
        
        LinearGradient(
            gradient: Gradient(colors: animateGradient ? gradient1 : gradient2),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// MARK: - Wave Shapes

struct TopWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        // Gentle wave across the top
        path.addCurve(
            to: CGPoint(x: rect.width, y: 0),
            control1: CGPoint(x: rect.width * 0.3, y: rect.height * 0.3),
            control2: CGPoint(x: rect.width * 0.7, y: -rect.height * 0.3)
        )
        // Fill down
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct BottomWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        // Gentle wave across the bottom
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height),
            control1: CGPoint(x: rect.width * 0.3, y: rect.height * 0.8),
            control2: CGPoint(x: rect.width * 0.7, y: rect.height * 1.2)
        )
        // Fill up
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}
