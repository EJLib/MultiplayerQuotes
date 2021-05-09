//
//  GameEndViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 5/6/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

class GameEndViewController: UIViewController {

    @IBOutlet var winnerNamesLabel: UILabel!
    @IBOutlet var winningScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        winners.remove(at: 0)
        winnerNamesLabel.text = winners.joined(separator: "   ")
        winningScoreLabel.text = "won with a score of \(winningScore)"
        
    }
    
    @IBAction func reset() {
        who = -1
        activePlayer = 0
        players = []
        scores = []
        winners = ["segueScoresToGameEnd"]
    }


}
