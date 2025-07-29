import SwiftUI

struct TrackRow: View {
    @EnvironmentObject var vm: PlayerViewModel
    let song: Song

    private var isCurrent: Bool {
        vm.current.id == song.id
    }

    var body: some View {
        HStack(spacing: 16) {
            Image(song.artwork)
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 2) {
                Text(song.title)
                    .font(.custom("Inter-Bold", size: 15))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(song.artist)
                    .font(.custom("Inter-Medium", size: 13))
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(1)
            }

            Spacer()

            Button(action: {
                if isCurrent {
                    vm.toggle()           // pause/resume
                } else {

                    if let idx = vm.playlist.firstIndex(where: { $0.id == song.id }) {
                        vm.index = idx
                        vm.isPlaying = true
                    }
                }
            }) {
                Image(systemName: isCurrent && vm.isPlaying
                      ? "pause"
                      : "play")
                .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
            }
        }
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isCurrent
                    ? Color.white.opacity(0.08)
                    : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
