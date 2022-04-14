//
//  ScroreView.swift
//  TicTacToeDot
//
//  Created by Achraf Trabelsi on 14/04/2022.
//

import SwiftUI

struct ScroreView: View {
    var timer: String
    @Binding var isXPlaying: Bool
    private let imageName = "arrowtriangle.forward.fill"
    @Binding var score: (xPlayer: Int, oPlayer: Int)
    
    var body: some View {
        VStack {
            Text(timer)
                .font(.system(size: 50))
                .bold()
                .foregroundColor(.brown)
                .padding(.bottom, 5)
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                    .opacity(isXPlaying ? 1.0 : 0.0)
                Text("Player X :")
                    .font(.title)
                    .bold()
                Text("\(score.xPlayer)")
                    .font(.system(size: 40))
                    .bold()
            }
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                    .opacity(isXPlaying ? 0.0 : 1.0)
                Text("Player 0 :")
                    .font(.title)
                    .bold()
                Text("\(score.oPlayer)")
                    .font(.system(size: 40))
                    .bold()
            }
        }
    }
}

struct ScroreView_Previews: PreviewProvider {
    static var previews: some View {
        ScroreView(timer: "02:59",
                   isXPlaying: .constant(true),
                   score: .constant((xPlayer: 2, oPlayer: 5)))
    }
}
