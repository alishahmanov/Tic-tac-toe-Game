//
//  FieldView.swift
//  TicTacToe
//
//  Created by Alihan on 01.01.2025.
//


//
//  FieldView.swift
//  Example
//
//  Created by Alihan on 31.12.2024.
//
import SwiftUI

struct FieldView: View {
    @ObservedObject var play: GameHM
    let offset: Int 

    var body: some View {
        ZStack {
            VStack {
                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        ForEach(0..<3, id: \.self) { column in
                            let index = offset + row * 3 + column
                            Button(action: {
                                play.makeMove(at: index)
                            }) {
                                Rectangle()
                                    .frame(width: 35, height: 35)
                                    .border(Color.clear)
                                    .foregroundColor(.clear)
                                    .overlay(
                                        Group {
                                            if let state = play.states[index] {
                                                if state {
                                                    CrossMotion(lineWidth: 2)
                                                        .foregroundColor(.black)
                                                        .frame(width: 20, height: 20)
                                                } else {
                                                    CircleMotion(lineWidth: 2)
                                                        .stroke(Color.black, lineWidth: 2)
                                                        .frame(width: 20, height: 20)
                                                }
                                            }
                                        }
                                    )
                            }
                            .disabled(play.states[index] != nil || play.isGameOver)
                        }
                    }
                }
            }
        }
    }
}
struct GridShape: Shape {
    let rows: Int
    let columns: Int
    let cellSize: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Горизонтальные линии
        for row in 1..<rows {
            let y = CGFloat(row) * cellSize
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: rect.width, y: y))
        }

        // Вертикальные линии
        for column in 1..<columns {
            let x = CGFloat(column) * cellSize
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: rect.height))
        }

        return path
    }
}


#Preview {
    HardTicTacToe()
}
