import SwiftUI

struct MiniPlayer: View {
    @EnvironmentObject var vm: PlayerViewModel
    var animation: Namespace.ID
    @Binding var expand: Bool

    @State private var offset: CGFloat = 0
    private let height = UIScreen.main.bounds.height / 3

    var body: some View {
        ZStack(alignment: .bottom) {
            if expand {
                FullPlayerView(expanded: $expand, namespace: animation)
                    .environmentObject(vm)
                    .transition(.move(edge: .bottom))
            } else {

                VStack(spacing: 6) {
                    HStack(spacing: 15) {
                        Image(vm.current.artwork)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .matchedGeometryEffect(id: "art", in: animation)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(vm.current.title)
                                .font(.custom("Inter-Medium", size: 13))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .matchedGeometryEffect(id: "title", in: animation)
                            Text(vm.current.artist)
                                .font(.custom("Inter-Regular", size: 11))
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }

                        Spacer()

                        Button(action: vm.toggle) {
                            Image(systemName: vm.isPlaying ? "pause" : "play")
                            .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white)
                                .frame(width: 25, height: 25)
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        }
                    }

                    CustomSlider(value: $vm.progress,
                                 range: 0...vm.current.duration,
                                 trackHeight: 3,
                                 thumbDiameter: 10)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    GlassView(corner: 16)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 1)) {
                                expand = true
                            }
                        }
                )
            }
        }

        .cornerRadius(expand ? 20 : 16)
        .offset(y: expand ? 0 : -25)
        .offset(y: offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > 0 && expand {
                        offset = value.translation.height
                    }
                }
                .onEnded { value in
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95)) {
                        if value.translation.height > UIScreen.main.bounds.height / 3 {
                            expand = false
                        }
                        offset = 0
                    }
                }
        )
        .ignoresSafeArea()
    }
}
