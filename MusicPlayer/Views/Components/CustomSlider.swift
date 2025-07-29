import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let trackHeight: CGFloat
    let thumbDiameter: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let progress = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
            let xPosition = progress * width

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: trackHeight)
                Capsule()
                    .fill(Color.white)
                    .frame(width: xPosition, height: trackHeight)
                Circle()
                    .frame(width: thumbDiameter, height: thumbDiameter)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
                    .offset(x: xPosition - thumbDiameter / 2)
                    .gesture(
                        DragGesture().onChanged { gesture in
                            let newX = min(max(0, gesture.location.x), width)
                            value = Double(newX / width) * (range.upperBound - range.lowerBound) + range.lowerBound
                        }
                    )
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture().onChanged { gesture in
                    let newX = min(max(0, gesture.location.x), width)
                    value = Double(newX / width) * (range.upperBound - range.lowerBound) + range.lowerBound
                }
            )
        }
        .frame(height: max(trackHeight, thumbDiameter))
    }
}
