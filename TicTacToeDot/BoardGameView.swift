//
//  ContentView.swift
//  TicTacToeDot
//
//  Created by Achraf Trabelsi on 14/04/2022.
//

import SwiftUI

struct BoardGameView: View {
    @State private var moves: [PlayerSymbol] = Array(repeating: .empty, count: 9)
    @State private var isXPlaying = true
    @State private var gameOver = false
    @State private var message = ""
    @State private var score: (xPlayer: Int, oPlayer: Int) = (0, 0)
    @State private var timer: String = "03:00"
    
    private var ranges = [(0..<3), (3..<6), (6..<9)]
    private var isTimerRunning = false
    private var seconds = 180
    @ObservedObject private var gameTimer = GameTimer()
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("TicTacToe")
                .font(.title)
                .bold()
            
            VStack() {
                ForEach(ranges, id: \.self) { range in
                    HStack {
                        ForEach(range, id: \.self) { index in
                            XOSquareView(letter: $moves[index])
                                .onTapGesture {
                                    if moves[index] == .empty {
                                        moves[index] = isXPlaying ? .xPlayer : .oPlayer
                                        isXPlaying.toggle()
                                    }
                                }
                        }
                    }
                }
                
            }
            
            ScroreView(timer: gameTimer.timerStr, isXPlaying: $isXPlaying, score: $score)
                .padding(.top, 20)
            
            HStack {
                Button("Play") {
                    play()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                
                Button("Reset Game") {
                    resetGame()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
            }
        }
        .onChange(of: moves) { newValue in
            checkWinner()
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Result !"),
                  message: Text(message),
                  dismissButton: .destructive(Text("Play Again"), action: { resetRound() })
            )
        }
    }
}

// MARK: - Game Engine

extension BoardGameView {
    private func checkWinner() {
        if checkMoves(player: .xPlayer) {
            message = PlayerSymbol.xPlayer.winDescription
            score.xPlayer += 1
            gameOver.toggle()
        }
        else if checkMoves(player: .oPlayer) {
            message = PlayerSymbol.oPlayer.winDescription
            score.oPlayer += 1
            gameOver.toggle()
        }
        else {
            // When no moves
            let status = moves.contains { value in
                return value == .empty
            }
            
            if !status {
                message = "No winner for this round"
                gameOver.toggle()
            }
        }
    }
    
    private func checkMoves(player: PlayerSymbol) -> Bool {
        // Check Horizontal moves
        for index in stride(from: 0, to: 9, by: 3) {
            if moves[index] == player && moves[index+1] == player && moves[index+2] == player {
                return true
            }
        }
        
        // Check Vertical moves
        for index in 0...2 {
            if moves[index] == player && moves[index+3] == player && moves[index+6] == player {
                return true
            }
        }
        
        // Check Diagonal moves
        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }
        
        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }
        
        return false
    }
    
    private func play() {
        gameTimer.start()
    }
    
    private func resetRound() {
        moves.removeAll()
        moves = Array(repeating: .empty, count: 9)
        isXPlaying = true
    }
    
    private func resetScore() {
        score = (0, 0)
    }
    
    private func resetCounter() {
        gameTimer.reset()
    }
    
    private func resetGame() {
        resetRound()
        resetScore()
        resetCounter()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BoardGameView()
    }
}
