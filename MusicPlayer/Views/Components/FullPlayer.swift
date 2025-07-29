import SwiftUI

struct FullPlayerView: View {
    @EnvironmentObject var vm: PlayerViewModel
    @Binding var expanded: Bool
    var namespace: Namespace.ID
    @State private var isLoved: Bool = false
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image("bg_player")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Button { withAnimation(.spring()) { expanded.toggle() } } label: {
                            Image(systemName: "chevron.down")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Text("Now playing")
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.custom("Inter-Medium", size: 12))
                                .foregroundColor(.white)
                                .frame(width: 7, height: 7)
                                .padding(8)
                                .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                        }
                    }
                    .padding(.horizontal, 32)

                    TabView(selection: $vm.index) {
                        ForEach(vm.playlist.indices, id: \.self) { i in
                            albumArt(for: vm.playlist[i])
                                .tag(i)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 340)
                    .animation(.easeInOut, value: vm.index)

                    VStack(spacing: 10) {
                        Text(vm.current.title)
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(.white)
                        Text(vm.current.artist)
                            .font(.custom("Inter-Medium", size: 16))
                            .foregroundColor(.white)

                    }
                    .padding(.vertical, 16)

                    VStack(spacing: 20) {
                        HStack {
                            Button(action: { isLoved.toggle() }) {
                                Image(systemName: isLoved ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(isLoved ? .red : .white)
                                    .offset(x: -5)
                            }
                            Spacer()
                            Button(action: {

                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 32)

                        CustomSlider(value: $vm.progress,
                                     range: 0...vm.current.duration,
                                     trackHeight: 3,
                                     thumbDiameter: 12)
                        .padding(.horizontal, 32)

                        HStack {
                            Text(formatTime(vm.progress))
                            Spacer()
                            Text(formatTime(vm.current.duration))
                        }
                        .font(.custom("Inter-Medium", size: 10))
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)

                        HStack(spacing: 35) {
                            Button(action: vm.toggleShuffle) {
                                Image(systemName: vm.isShuffle ? "shuffle.circle.fill" : "shuffle")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }

                            Button(action: vm.prev) {
                                Image(systemName: "backward.end.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }

                            Button(action: vm.toggle) {
                                Image(systemName: vm.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 70))
                                    .foregroundColor(.white)
                            }

                            Button(action: vm.next) {
                                Image(systemName: "forward.end.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }

                            Button(action: vm.cycleRepeatMode) {
                                Image(systemName: vm.repeatMode.symbol)
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            .offset(y: offset)
        }
    }

    private func formatTime(_ t: Double) -> String {
        let m = Int(t) / 60
        let s = Int(t) % 60
        return String(format: "%d:%02d", m, s)
    }

    private func albumArt(for song: Song) -> some View {
        Image(song.artwork)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 340)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.top, 24)
    }
}
