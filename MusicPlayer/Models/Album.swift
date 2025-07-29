import SwiftUI

struct Album: Identifiable {
    let id = UUID()
    let artwork: String
    let title: String
    let year: String
}
