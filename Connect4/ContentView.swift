//
//  ContentView.swift
//  Connect4
//
//  Created by CSUFTitan on 5/11/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var pos: [[Int]] =
        [[-1, -1, -1, -1],[-1, -1, -1, -1],[-1, -1, -1, -1],[-1, -1, -1, -1]]

    @State var turn = 0
    
    var body: some View {
        VStack {
            ForEach(0 ..< 4) { row in
                HStack {
                    ForEach(0 ..< 4) { col in
                        Chip(x: col, y: row, turn: self.$turn, pos: self.$pos, color: Color.white)
                    }
                }
            }
        }
    }
}

func checkWin(pos: [[Int]], turn: Int) -> Void {
    let t = turn % 2
    for row in 0 ..< 4 {
        var win = true
        for col in 0 ..< 4 {
            if pos[row][col] != t {
                win = false
            }
        }
        if win {
            if t == 0 {
                print("Player RED has won")
            } else {
                print("Player YELLOW has won")
            }
            return
        }
    }

    for row in 0 ..< 4 {
        var win = true
        for col in 0 ..< 4 {
            if pos[col][row] != t {
                win = false
            }
        }
        if win {
            if t == 0 {
                print("Player RED has won")
            } else {
                print("Player YELLOW has won")
            }
            return
        }
    }
    
    var win = true
    for i in 0 ..< 4 {
        if pos[i][i] != t {
            win = false
        }
    }
    if win {
        if t == 0 {
            print("Player RED has won")
        } else {
            print("Player YELLOW has won")
        }
        return
    }
    
    win = true
    for i in 0 ..< 4 {
        if pos[i][3 - i] != t {
            win = false
        }
    }
    if win {
        if t == 0 {
            print("Player RED has won")
        } else {
            print("Player YELLOW has won")
        }
        return
    }
}

struct Chip: View {
    var x: Int
    var y: Int
    @State var taken = false
    @Binding var turn: Int
    @Binding var pos: [[Int]]
    @State var color: Color
    
    var body: some View {
        Circle()
            .frame(width: 50, height: 50)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 4)
            )
            .foregroundColor(color)
            .onTapGesture {
                if !self.taken {
                    if self.turn % 2 == 0 {
                        self.color = Color.red
                    } else {
                        self.color = Color.yellow
                    }
                    self.pos[self.y][self.x] = self.turn % 2
                    checkWin(pos: self.pos, turn: self.turn)
                    self.turn += 1
                    self.taken = true
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
