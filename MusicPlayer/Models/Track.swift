import SwiftUI

struct Track: Identifiable {
    let id = UUID()
    let artwork: String 
    let title: String
    let subtitle: String
    let isPlaying: Bool
}
