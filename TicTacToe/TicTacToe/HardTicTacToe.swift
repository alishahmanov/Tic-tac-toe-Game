//
//  Test.swift
//  Example
//
//  Created by Alihan on 31.12.2024.
//
import SwiftUI

extension Array {
    subscript(safe range: Range<Int>) -> [Element] {
        guard range.lowerBound >= 0, range.upperBound <= count else { return [] }
        return Array(self[range])
    }
}

class GameHM: ObservableObject {
    @Published var states: [Bool?] = Array(repeating: nil, count: 81)
    @Published var isGameOver: Bool = false
    @Published var winningLine: [Int]? = nil
    @Published var playerMotion: Bool = true
    
    func makeMove(at index: Int) {
        guard states[index] == nil else { return }
        states[index] = playerMotion
        checkWin()
        checkDraw()
        playerMotion.toggle()
    }
    func checkDraw() {
        if states.allSatisfy({ $0 != nil }) && !isGameOver {
//            isGameOver = true
        }
    }
    
    func resetGame() {
        states = Array(repeating: nil, count: 81)
        isGameOver = false
        winningLine = nil
    }
    
    func checkWin() {
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
            if let first = states[combination[0]],
               combination.allSatisfy({ states[$0] == first }) {
                winningLine = combination
                isGameOver = true
                return
            }
        }
        
    }
}

struct HardTicTacToe: View {
    @StateObject var play = GameHM()
    var body: some View {
        ZStack {
            GridShape(rows: 3, columns: 3, cellSize: 136)
                .stroke(Color.black, lineWidth: 5)
                .frame(width: 408, height: 408)
                .offset(x:1, y:-2)
                
            VStack {
                HStack {
                    ForEach(0..<3, id: \.self) {_ in
                        GridShape(rows: 3, columns: 3, cellSize: 42)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 126, height: 126)
                            .offset(x: -0.1, y: -3)
                            
                    }
                }
                .frame(width: 380)
                HStack {
                    ForEach(0..<3, id: \.self) {_ in
                        GridShape(rows: 3, columns: 3, cellSize: 42)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 126, height: 126)
                            .offset(x: -0.1, y: 1)
                            
                    }
                }
                .frame(width: 380)
                HStack {
                    ForEach(0..<3, id: \.self) {_ in
                        GridShape(rows: 3, columns: 3, cellSize: 42)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 126, height: 126)
                            .offset(x: 1, y: 9)
                            .padding(-1)
                            .padding(.trailing, 2)
                    }
                }
                .frame(width: 380)
                .padding(.bottom,10)
            }
            VStack {
                HStack {
                    firstField(play: play)
                        .padding(.leading, 5)
                    secondField(play: play)
                        .padding(.horizontal, 5)
                    thirdField(play: play)
                        .padding(.trailing, 5)
                }
                .padding(3)
                .frame(width: 380)
                HStack {
                    fourthField(play: play)
                        .padding(3)
                    fithField(play: play)
                        .padding(3)
                    sixthField(play: play)
                        .padding(3)
                }
                .padding(3)
                .frame(width: 380)
                HStack {
                    seventhField(play: play)
                        .padding(3)
                    eightField(play: play)
                        .padding(3)
                    ninethField(play: play)
                        .padding(3)
                }
                .padding(3)
                .frame(width: 380)
                
            }
        }

    }
    
}
#Preview {
    HardTicTacToe()
}
