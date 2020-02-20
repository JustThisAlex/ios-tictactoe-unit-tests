//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Alexander Supe on 20.02.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    let rows = [[(0,0),(0,1),(0,2)], [(1,0),(1,1),(1,2)], [(2,0),(2,1),(2,2)]]
    
    func testPlace() {
        var game = Game()
            for row in rows {
                for coord in row {
                    try! game.makeMark(at: coord)
                }
            }
        XCTAssertTrue(game.board.isFull)
    }

    func testRestart() {
        var game = Game()
            for row in rows {
                for coord in row {
                    try! game.makeMark(at: coord)
                }
            }
        XCTAssertTrue(game.board.isFull)
        game.restart()
        XCTAssertFalse(game.board.isFull)
    }
    
    

}
