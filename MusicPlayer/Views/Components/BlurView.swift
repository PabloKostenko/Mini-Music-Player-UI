import SwiftUI

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct GlassView: View {
    var corner: CGFloat = 16
    var body: some View {

        Color.clear
            .background(.ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: corner,
                                             style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: corner,
                                 style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
    }
}
