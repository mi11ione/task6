//
//  ContentView.swift
//  task6
//
//  Created by mi11ion on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isInDiagonal = false

    var body: some View {
        SquaresLayout(isInDiagonal: isInDiagonal) {
            ForEach(0 ..< 7) { _ in
                RoundedRectangle(cornerRadius: 10).fill(.blue)
            }
        }
        .onTapGesture { withAnimation(.spring) { isInDiagonal.toggle() } }
    }
}

struct SquaresLayout: Layout {
    let isInDiagonal: Bool
    let spacing = 10.0

    func sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubviews, cache _: inout ()) -> CGSize {
        isInDiagonal ? proposal.replacingUnspecifiedDimensions() : .init(width: proposal.width ?? 0, height: (proposal.width ?? 0) / CGFloat(subviews.count))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: LayoutSubviews, cache _: inout ()) {
        let count = CGFloat(subviews.count)
        let squareSize = isInDiagonal ? bounds.height / count : (bounds.width - spacing * (count - 1)) / count

        for (index, view) in subviews.enumerated() {
            let i = CGFloat(index)
            let x = isInDiagonal ? i * (bounds.width - squareSize) / (count - 1) : i * (squareSize + spacing)
            let y = isInDiagonal ? bounds.maxY - (i * (bounds.height - squareSize) / (count - 1) + squareSize) : bounds.midY - squareSize / 2

            view.place(at: .init(x: x, y: y), proposal: .init(width: squareSize, height: squareSize))
        }
    }
}

#Preview {
    ContentView()
}
