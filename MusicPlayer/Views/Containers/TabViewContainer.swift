import SwiftUI

struct TabViewContainer: View {
    @State private var current = 2
    var body: some View {
        TabView(selection: $current) {
            Text("Library")
                .tabItem { Label("Library", systemImage: "rectangle.stack.fill") }
                .tag(0)
            Text("Radio")
                .tabItem { Label("Radio", systemImage: "dot.radiowaves.left.and.right") }
                .tag(1)
            Text("Search")
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(2)
        }
    }
}
