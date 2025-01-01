//
//  FieldsHM.swift
//  TicTacToe
//
//  Created by Alihan on 01.01.2025.
//

import SwiftUI

struct firstField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 0)
    }
}

struct secondField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 9)
    }
}

struct thirdField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 18)
    }
}

// Повторите для всех остальных полей...
struct fourthField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 27)
    }
}

struct fithField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 36)
    }
}

struct sixthField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 45)
    }
}

struct seventhField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 54)
    }
}

struct eightField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 63)
    }
}

struct ninethField: View {
    @ObservedObject var play: GameHM
    var body: some View {
        FieldView(play: play, offset: 72)
    }
}
