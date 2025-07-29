# 🎧 Now Playing – Mini Music Player UI

Test task: build a SwiftUI-based mini music player with two states minimized and full-screen focusing on modern UI, gestures and animations. All data is mocked, no actual audio playback.

## 📱 What’s implemented

- ✅ Mini Player pinned to bottom: shows song title, artist, thumbnail, and play/pause button
- ✅ Full Player: expands with smooth animation — includes album art, controls, slider, etc.
- ✅ Track progress simulation with Combine timer
- ✅ Shuffle / Repeat / Next / Previous logic with shuffle queue + history
- ✅ Gesture to swipe down and collapse
- ✅ Clean, modular SwiftUI views
- ✅ Custom slider built fully with SwiftUI
- ✅ Matched geometry for smooth transitions
- ✅ Dummy playlist data (no backend / no playback)

## 🧠 Architecture

Simple **MVVM**:
- `PlayerViewModel.swift`: manages player state & logic
- SwiftUI views are separated into small components (`MiniPlayer`, `FullPlayer`, `TrackRow`, etc.)

## 🛠️ What I didn’t add (but would in production)

- ⏳ Real audio playback (e.g. using `AVAudioPlayer`)
- 📦 Data loading from API or JSON
- ✅ Unit/UI tests
- 🎨 Dynamic theming or dark/light modes
- 🔊 Volume controls / system integration
- 📲 Accessibility support

## 🧪 Things I’d improve with more time

- Improve animation smoothness when swiping down
- Polish the full-screen layout for dynamic content
- Add loading indicators / skeletons for real data
- Extract player logic into a dedicated service layer

## ▶️ Demo

<div align="center">

  [▶️ Click to watch video](https://github.com/user-attachments/assets/5b3c3044-e648-458b-8f2f-794242b75e93)

</div>

## 🏃 How to run

1. Open in **Xcode 15+**
2. Run on iOS simulator (e.g. iPhone 16)
3. Tap the mini player to expand. Swipe down to collapse. Use the controls and scrubber to test logic.

---
