import SwiftUI

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let artwork: String 
    let duration: Double
}
