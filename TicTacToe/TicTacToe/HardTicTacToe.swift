//
//  HardTicTacToe.swift
//  TicTacToe
//
//  Created by Alihan on 31.12.2024.
//

import SwiftUI

class Field: ObservableObject {
    @Published var states: [Bool?] = Array(repeating: nil, count: 81)

}
class GlobalGame: ObservableObject {
    @Published var fields: [Field] = (0..<9).map { _ in Field() }
    @Published var playerMotion: Bool = true
    @Published var currentIndex: Int = 0

}

struct HardTicTacToe: View {
    @StateObject var game = GlobalGame()
    
    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { column in
                        let index = row * 3 + column
                        FieldView(field: game.fields[index], game: game)
                            .frame(width: 120, height: 120)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
    }
}

struct FieldView: View {
    @ObservedObject var field: Field
    @ObservedObject var game: GlobalGame
    
    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { column in
                        let index = row * 3 + column
                        Button(action: {
                            makeMove(at: index)
                            game.currentIndex = index
                            print(game.currentIndex)
                        }) {
                            Rectangle()
                                .frame(width: 30, height: 30)
                                .border(Color.black)
                                .foregroundColor(.clear)
                                .overlay(
                                    Group {
                                        if let state = field.states[index] {
                                            if state {
                                                CrossMotion(lineWidth: 1)
                                                    .stroke(Color.black, lineWidth: 1)
                                                    .frame(width: 10, height: 10)
                                            } else {
                                                CircleMotion(lineWidth: 2)
                                                    .stroke(Color.black, lineWidth: 2)
                                                    .fontWeight(.bold)
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                    }
                                )
                        }
                        .disabled(field.states[index] != nil)
                    }
                }
            }
        }
    }
    
    private func makeMove(at index: Int) {
        guard field.states[index] == nil else { return }
        field.states[index] = game.playerMotion
        game.playerMotion.toggle()
    }
}

#Preview {
    HardTicTacToe()
}
