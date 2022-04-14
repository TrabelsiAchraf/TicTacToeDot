//
//  PlayerSymbol.swift
//  TicTacToeDot
//
//  Created by Achraf Trabelsi on 14/04/2022.
//

enum PlayerSymbol: String {
    case xPlayer = "X"
    case oPlayer = "0"
    case empty = ""
    
    var winDescription: String {
        switch self {
        case .xPlayer:
            return "Player X Won !"
        case .oPlayer:
            return "Player 0 Won !"
        case .empty:
            return ""
        }
    }
}
