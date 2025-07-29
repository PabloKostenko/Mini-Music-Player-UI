import SwiftUI
import Combine


/// PlayerViewModel that manages audio playback state, including progress,
/// repeat modes, shuffle logic and active song selection.
final class PlayerViewModel: ObservableObject {

    @Published var playlist: [Song] = [
        Song(title: "Feeling Lonely", artist: "Boy Pablo", artwork: "1", duration: 197),
        Song(title: "Honey",      artist: "Boy Pablo", artwork: "3", duration: 185),
        Song(title: "Dance, Baby!",   artist: "Boy Pablo", artwork: "2", duration: 213),
        Song(title: "Everytime",      artist: "Boy Pablo", artwork: "3", duration: 178),
        Song(title: "Sick Feeling",      artist: "Boy Pablo", artwork: "1", duration: 220)
    ]
  
    @Published var index = 0        { didSet { progress = 0 } }
    @Published var isPlaying = false { didSet { isPlaying ? startTimer() : stopTimer() } }
    @Published var progress : Double = 0
    @Published var isShuffle = false { didSet { resetQueues() } }
    @Published var repeatMode: RepeatMode = .none
    
    enum RepeatMode: CaseIterable { case none, all, one }
    var current: Song { playlist[index] }

    private var upcoming: [Int] = []
    private var history : [Int] = []

  // MARK: - Public Playback Controls

    func toggle()        { isPlaying.toggle() }
    func toggleShuffle() { isShuffle.toggle() }
    func cycleRepeatMode(){ repeatMode = RepeatMode.allCases[(repeatMode.index + 1) % RepeatMode.allCases.count] }
    
    func next() {
        if isShuffle { playNextShuffle() }
        else         { stepLinear(forward: true) }
    }
    
    func prev() {
        if isShuffle { playPrevShuffle() }
        else         { stepLinear(forward: false) }
    }

  // MARK: - Shuffle Logic

    private func resetQueues() {
        upcoming.removeAll(); history.removeAll()
    }
    
    private func refillUpcoming() {
        upcoming = Array(playlist.indices).filter { $0 != index }.shuffled()
    }
    
    private func playNextShuffle() {
        if upcoming.isEmpty { refillUpcoming() }
        guard let nextIdx = upcoming.first else { return }
        history.append(index)
        upcoming.removeFirst()
        index = nextIdx
    }
    
    private func playPrevShuffle() {
        guard let prevIdx = history.popLast() else { return }
        upcoming.insert(index, at: 0)   // повертаємо поточний у чергу
        index = prevIdx
    }
    
    private func stepLinear(forward: Bool) {
        let n = playlist.count
        index = (index + (forward ? 1 : n - 1)) % n
    }

  // MARK: - Timer for Progress Tracking
    private var timer: AnyCancellable?
    private let tick: TimeInterval = 0.5
    
    private func startTimer() {
        timer = Timer.publish(every: tick, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                progress += tick
                if progress >= current.duration {
                    switch repeatMode {
                    case .one:  progress = 0
                    default:    next()
                    }
                }
            }
    }
    private func stopTimer() { timer?.cancel(); timer = nil }
}

// MARK: - RepeatMode Display Helpers
extension PlayerViewModel.RepeatMode {
    var symbol: String {
        switch self {
        case .none: return "repeat"
        case .all:  return "repeat.circle.fill"
        case .one:  return "repeat.1"
        }
    }
    var index: Int { [.none, .all, .one].firstIndex(of: self)! }
}
