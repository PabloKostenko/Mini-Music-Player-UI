import SwiftUI

struct CustomTabBar: View {
    private let icons = ["discovery", "search", "profile"]

    var body: some View {
        HStack {
            ForEach(icons, id: \.self) { img in
                Button(action: {
                }) {
                    Image(img)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.black)
    }
}
