//
//  ContentView.swift
//  task6
//
//  Created by mi11ion on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isInDiagonal = false
    let squares = 7
    
    var body: some View {
        GeometryReader { geo in
            let size = isInDiagonal ?
                geo.size.height / CGFloat(squares) :
                geo.size.width / CGFloat(squares)
            
            let step = CGPoint(
                x: (geo.size.width - size) / CGFloat(squares - 1),
                y: (geo.size.height - size) / CGFloat(squares - 1)
            )
            
            ZStack {
                ForEach(0..<squares, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.blue)
                        .frame(width: size, height: size)
                        .position(
                            x: isInDiagonal ?
                                step.x * CGFloat(i) + size/2 :
                                size * CGFloat(i) + size/2,
                            y: isInDiagonal ?
                                geo.size.height - (step.y * CGFloat(i) + size/2) :
                                geo.size.height/2
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                withAnimation(.spring) { isInDiagonal.toggle() }
            }
        }
    }
}

#Preview {
    ContentView()
}
