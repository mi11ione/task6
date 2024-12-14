//
//  ContentView.swift
//  task6
//
//  Created by mi11ion on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isDiagonal = false

    var body: some View {
        SquaresLayout(isDiagonal: isDiagonal) {
            ForEach(0 ..< 7) { _ in
                RoundedRectangle(cornerRadius: 10).fill(.blue)
            }
        }
        .onTapGesture { withAnimation(.spring) { isDiagonal.toggle() } }
    }
}

struct SquaresLayout: Layout {
    let isDiagonal: Bool
    let spacing = 10.0

    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache _: inout ()) -> CGSize {
        isDiagonal ? proposal.replacingUnspecifiedDimensions() : .init(width: proposal.width ?? 0, height: (proposal.width ?? 0) / CGFloat(subviews.count))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache _: inout ()) {
        let count = CGFloat(subviews.count)
        let size = isDiagonal ? bounds.height / count : (bounds.width - spacing * (count - 1)) / count

        for (index, view) in subviews.enumerated() {
            let i = CGFloat(index)
            let x = isDiagonal ? i * (bounds.width - size) / (count - 1) : i * (size + spacing)
            let y = isDiagonal ? bounds.maxY - (i * (bounds.height - size) / (count - 1) + size) : bounds.midY - size / 2

            view.place(at: .init(x: x, y: y), proposal: .init(width: size, height: size))
        }
    }
}

#Preview {
    ContentView()
}
