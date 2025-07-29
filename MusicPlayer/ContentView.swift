import SwiftUI

struct ContentView: View {
    @StateObject private var vm = PlayerViewModel()

    var body: some View {
        MiniPlayerContainer()
            .environmentObject(vm)
    }
}

#Preview {
    ContentView()
        .environmentObject(PlayerViewModel())
}
