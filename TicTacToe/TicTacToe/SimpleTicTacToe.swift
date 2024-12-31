//
//  SimpleTicTacToe.swift
//  TicTacToe
//
//  Created by Alihan on 31.12.2024.
//

import SwiftUI

class Game: ObservableObject {
    @Published var states: [Bool?] = Array(repeating: nil, count: 9)
    @Published var isGameOver: Bool = false
    @Published var winningLine: [Int]? = nil
    @Published var playerMotion: Bool = true
    
}

struct SimpleTicTacToe: View {
    @StateObject var play = Game()
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    ForEach(0..<3, id: \.self) { row in
                        HStack {
                            ForEach(0..<3, id: \.self) { column in
                                let index = row * 3 + column
                                
                                Button(action: {
                                    makeMove(at: index)
                                }) {
                                    Rectangle()
                                        .frame(width: 80, height: 80)
                                        .border(Color.black)
                                        .foregroundColor(.clear)
                                        .overlay(
                                            Group {
                                                if let state = play.states[index] {
                                                    if state {
                                                        CrossMotion(lineWidth: 4)
                                                            .foregroundColor(.black)
                                                            .frame(width: 40, height: 40)
                                                    } else {
                                                        CircleMotion(lineWidth: 4)
                                                            .stroke(Color.black, lineWidth: 4)
                                                            .frame(width: 40, height: 40)
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
                .padding()
                if let winningLine = play.winningLine {
                    WinningLineView(winningLine: winningLine)
                        .stroke(Color.red, lineWidth: 5)
                        .frame(width: 240, height: 240)
                }
            }
            
            if play.isGameOver {
                Button("Restart Game") {
                    resetGame()
                }
                .padding()
                .font(.title2)
            }
        }
    }
    
    
    private func makeMove(at index: Int) {
        guard play.states[index] == nil else { return }
        play.states[index] = play.playerMotion
        checkWin()
        checkDraw()
        play.playerMotion.toggle()
    }
    
    private func checkWin() {
        let winningCombinations: [[Int]] = [
            [0, 1, 2], // first row
            [3, 4, 5], // second row
            [6, 7, 8], // third row
            [0, 3, 6], // 1 col
            [1, 4, 7], // 2 col
            [2, 5, 8], // 3 col
            [0, 4, 8], // main diag
            [2, 4, 6]  // 2 diag
        ]
        
        for combination in winningCombinations {
            if let first = play.states[combination[0]],
               combination.allSatisfy({ play.states[$0] == first }) {
                play.winningLine = combination
                play.isGameOver = true
                return
            }
        }
        
    }
    private func checkDraw() {
        if play.states.allSatisfy({ $0 != nil }) && !play.isGameOver {
            play.isGameOver = true
        }
    }
    
    private func resetGame() {
        play.states = Array(repeating: nil, count: 9)
        play.isGameOver = false
        play.winningLine = nil
    }
}

struct WinningLineView: Shape {
    let winningLine: [Int]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        

        let cellSize = rect.width / 3
        let points: [CGPoint]
        
        switch winningLine {
        case [0, 1, 2]:
            points = [
                CGPoint(x: rect.minX + cellSize / 10, y: rect.minY + cellSize / 2.5),
                CGPoint(x: rect.minX + cellSize * 2.9, y: rect.minY + cellSize / 2.5)
            ]
        case [3, 4, 5]:
            points = [
                CGPoint(x: rect.minX + cellSize / 10, y: rect.minY + cellSize * 1.5),
                CGPoint(x: rect.minX + cellSize * 2.9, y: rect.minY + cellSize * 1.5)
            ]
        case [6, 7, 8]:
            points = [
                CGPoint(x: rect.minX + cellSize / 10, y: rect.minY + cellSize * 2.6),
                CGPoint(x: rect.minX + cellSize * 2.9, y: rect.minY + cellSize * 2.6)
            ]
        case [0, 3, 6]:
            points = [
                CGPoint(x: rect.minX + cellSize / 2.6, y: rect.minY + cellSize / 10),
                CGPoint(x: rect.minX + cellSize / 2.6, y: rect.minY + cellSize * 3)
            ]
        case [1, 4, 7]:
            points = [
                CGPoint(x: rect.minX + cellSize * 1.5, y: rect.minY + cellSize / 10),
                CGPoint(x: rect.minX + cellSize * 1.5, y: rect.minY + cellSize * 3)
            ]
        case [2, 5, 8]:
            points = [
                CGPoint(x: rect.minX + cellSize * 2.6, y: rect.minY + cellSize / 10),
                CGPoint(x: rect.minX + cellSize * 2.6, y: rect.minY + cellSize * 3)
            ]
        case [0, 4, 8]:
            points = [
                CGPoint(x: rect.minX, y: rect.minY),
                CGPoint(x: rect.maxX, y: rect.maxY)
            ]
        case [2, 4, 6]:
            points = [
                CGPoint(x: rect.maxX, y: rect.minY),
                CGPoint(x: rect.minX, y: rect.maxY)
            ]
        default:
            return path
        }
        
        path.move(to: points[0])
        path.addLine(to: points[1])
        
        return path
    }
}

struct CrossMotion: Shape {
    var lineWidth: CGFloat = 5
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.addPath(
            Path { p in
                p.move(to: CGPoint(x: 0, y: 0))
                p.addLine(to: CGPoint(x: width, y: height))
            }
            .strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round))
        )
        path.addPath(
            Path { p in
                p.move(to: CGPoint(x: width, y: 0))
                p.addLine(to: CGPoint(x: 0, y: height))
            }
            .strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round))
        )
        
        return path
    }
}
struct CircleMotion: Shape {
    var lineWidth: CGFloat = 2
    
    func path(in rect: CGRect) -> Path {
        let insetRect = rect.insetBy(dx: lineWidth / 5, dy: lineWidth / 5)
        return Path { path in
            path.addEllipse(in: insetRect)
        }
    }
}

#Preview {
    SimpleTicTacToe()
}
