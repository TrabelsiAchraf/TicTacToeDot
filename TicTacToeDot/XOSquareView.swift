//
//  XOSquareView.swift
//  TicTacToeDot
//
//  Created by Achraf Trabelsi on 14/04/2022.
//

import SwiftUI

struct XOSquareView: View {
    @Binding var letter: PlayerSymbol
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text(letter.rawValue)
                .font(.system(size: 60))
                .bold()
        }
    }
}

struct XOSquareView_Previews: PreviewProvider {
    static var previews: some View {
        XOSquareView(letter: .constant(.xPlayer))
    }
}
