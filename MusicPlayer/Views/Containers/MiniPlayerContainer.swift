import SwiftUI

private enum ArtistTab: String, CaseIterable {
    case popular = "Popular"
    case albums  = "Albums"
    case singles = "Singles"
}

struct MiniPlayerContainer: View {
    @EnvironmentObject private var vm: PlayerViewModel
    @Namespace private var ns
    @State private var expand      = false
    @State private var selectedTab = ArtistTab.albums

    private let albums: [Album] = [
        .init(artwork: "1", title: "Soy Pablo",      year: "2018"),
        .init(artwork: "2",    title: "Wachito Rico",  year: "2020")
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Image("bg_main")
                .resizable()
                .ignoresSafeArea()

          VStack(spacing: 10) {
            VStack(spacing: 0) {
              topBar
              ArtistHeroSection()
            }

              listenersRow
              tabBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    albumCarousel
                    songSection
                }

            }
          }
          .padding(.horizontal, 24)
          .padding(.bottom, 160)

            VStack(spacing: 0) {
                MiniPlayer(animation: ns, expand: $expand)
                    .environmentObject(vm)
                    .zIndex(expand ? 2 : 3)

                if !expand {
                    CustomTabBar()
                        .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .animation(.easeOut(duration: 0.35), value: expand)
    }
}

private extension MiniPlayerContainer {

  @ViewBuilder
  func ArtistHeroSection() -> some View {
    ZStack(alignment: .topLeading) {
      VStack(alignment: .leading, spacing: -25) {
        Text("Boy")
        Text("Pablo")
      }
      .font(.custom("Inter-Bold", size: 58))
      .foregroundColor(.white)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .offset(x: 0)
  }

    var listenersRow: some View {
        HStack {
            Text("16,105,208 monthly listeners")
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(.white.opacity(0.9))

            Spacer()

            Button {

            } label: {
                Text("Follow")
                    .font(.custom("Inter-Bold", size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white, lineWidth: 1))
            }
            .offset(y: -25)
        }
    }

    var tabBar: some View {
        HStack(spacing: 32) {
            ForEach(ArtistTab.allCases, id: \.self) { tab in
                VStack(spacing: 4) {
                    Button {
                        withAnimation { selectedTab = tab }
                    } label: {
                        Text(tab.rawValue)
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundColor(.white)
                    }

                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 2)
                        .opacity(selectedTab == tab ? 1 : 0)
                        .matchedGeometryEffect(id: tab.rawValue, in: ns, isSource: selectedTab == tab)
                }
            }
        }
    }

    var albumCarousel: some View {
        Group {
            if selectedTab == .albums {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(albums) { album in
                            VStack {
                                Image(album.artwork)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 165, height: 165)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))

                                Text(album.title)
                                    .font(.custom("Inter-Bold", size: 14))
                                    .foregroundColor(.white)
                                    .padding(.top, 8)

                                Text(album.year)
                                    .font(.custom("Inter-Medium", size: 12))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                    }
                    .padding(.vertical, 12)
                }
                .padding(.leading, 4)
            }
        }
    }

    var songSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Song")
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(.white)
                Spacer()
                Button {

                } label: {
                    Text("See all")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.white.opacity(0.8))
                }
            }

            VStack(spacing: 8) {
              ForEach(vm.playlist) { song in
                  TrackRow(song: song)
              }
            }
        }
    }

    var topBar: some View {
        HStack {
            Button(action: { /* dismiss action */ }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            Spacer()
            Text("Artist")
                .font(.custom("Inter-Bold", size: 16))
                .foregroundColor(.white)
            Spacer()
            Button(action: { /* more action */ }) {
                Image(systemName: "ellipsis")
                    .font(.custom("Inter-Medium", size: 12))
                    .foregroundColor(.white)
                    .frame(width: 7, height: 7)
                    .padding(8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
            }
        }
        .offset(y: -7)
    }
}
