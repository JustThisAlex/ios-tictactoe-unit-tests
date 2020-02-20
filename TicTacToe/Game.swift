//
//  Game.swift
//  TicTacToe
//
//  Created by Alexander Supe on 20.02.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Game {
    
    private(set) var board: GameBoard = GameBoard()

    internal var activePlayer: GameBoard.Mark? = .x
    internal var gameIsOver: Bool { board.isFull }
    var winningPlayer: GameBoard.Mark?
    var tied: Bool = false

    mutating internal func restart() {
        board = GameBoard()
        activePlayer = .x
        winningPlayer = nil
        tied = false
    }
    mutating internal func makeMark(at coordinate: Coordinate) throws {
        guard let activePlayer = activePlayer else { return }
        try board.place(mark: activePlayer, on: coordinate)
        if game(board: board, isWonBy: activePlayer) {
            winningPlayer = activePlayer
            return
        } else if board.isFull {
            tied = true
            return
        }
        self.activePlayer = activePlayer == .x ? .o : .x
    }

}
