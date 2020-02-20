//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, BoardViewControllerDelegate {
    
    var currentGame = Game() { didSet { updateViews() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private enum GameState {
        case cat
        case won(GameBoard.Mark) // Winning player
    }
    
    @IBAction func restartGame(_ sender: Any) {
        currentGame.restart()
        updateViews()
    }
    
    // MARK: - BoardViewControllerDelegate
    
    func boardViewController(_ boardViewController: BoardViewController, markWasMadeAt coordinate: Coordinate) {
        if currentGame.gameIsOver {
            NSLog("Game is over")
            return
        }
        
        do {
            try currentGame.makeMark(at: coordinate)
        } catch {
            NSLog("Illegal move")
        }
    }
    
    // MARK: - Private
    
    private func updateViews() {
        guard isViewLoaded else { return }
        statusLabel.text = "Player \(currentGame.activePlayer ?? .x)'s turn"
        if let winner = currentGame.winningPlayer {
            statusLabel.text = "Player \(winner) won!"
        } else if currentGame.tied {
            statusLabel.text = "Cat's game!"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedBoard" {
            boardViewController = segue.destination as! BoardViewController
        }
    }
    
    private var boardViewController: BoardViewController! {
        willSet {
            boardViewController?.delegate = nil
        }
        didSet {
            boardViewController?.board = currentGame.board
            boardViewController?.delegate = self
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    
}
