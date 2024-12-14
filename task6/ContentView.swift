//
//  ContentView.swift
//  task6
//
//  Created by mi11ion on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isInDiagonal = false
    let numberOfSquares = 7

    var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let availableHeight = geometry.size.height

            let horizontalSquareSize = availableWidth / CGFloat(numberOfSquares)
            let diagonalSquareSize = availableHeight / CGFloat(numberOfSquares)
            let squareSize = isInDiagonal ? diagonalSquareSize : horizontalSquareSize

            let diagonalStepX = (availableWidth - squareSize) / CGFloat(numberOfSquares - 1)
            let diagonalStepY = (availableHeight - squareSize) / CGFloat(numberOfSquares - 1)

            ZStack(alignment: .leading) {
                ForEach(0 ..< numberOfSquares, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue)
                        .frame(width: squareSize, height: squareSize)
                        .position(
                            x: isInDiagonal
                                ? diagonalStepX * CGFloat(index) + squareSize / 2
                                : horizontalSquareSize * CGFloat(index) + squareSize / 2,
                            y: isInDiagonal
                                ? availableHeight - (diagonalStepY * CGFloat(index) + squareSize / 2)
                                : availableHeight / 2
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring) {
                    isInDiagonal.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
