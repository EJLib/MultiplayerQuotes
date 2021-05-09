//
//  ScoresViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 4/6/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit
import WebKit

var svc: UIViewController!
var winners: [String] = ["segueScoresToGameEnd"]
var winningScore = 0

class ScoresViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var nextRoundButton: UIButton!
    @IBOutlet var endGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        svc = self
        
        responses.removeAll()
        if activePlayer < players.count-1 {
            activePlayer += 1
        } else {
            activePlayer = 0
        }
        
        if who == activePlayer {
            loadQuote()
        }
        
        for i in 0...players.count {
            scores[i] += votes[i]
        }
        votes = []
        
        if let url = Bundle.main.url(forResource: "blank", withExtension: "html") {
            
            //webView.configuration.userContentController.add(self, name: "selection")
            
            var html = ""
            
            for i in 0...players.count-1 {
                html.append("<p>\(players[i]):     \(scores[i])</p>")
            }
            html.append("<p>Trump:     \(scores[players.count])</p>")
            
            webView.loadHTMLString(html, baseURL: url)

        }
        
        if who == 0 {
            nextRoundButton.isHidden = false
            nextRoundButton.isEnabled = true
            endGameButton.isHidden = false
            endGameButton.isEnabled = true
        }
        
    }
    
    @IBAction func startNextRound() {
        sendData(m: ["NewRoundover15characters"])
        if who == activePlayer {
            performSegue(withIdentifier: "ScorestoChooseWord", sender: nil)
        } else {
            performSegue(withIdentifier: "ScorestoWaiting", sender: nil)
        }
    }

    @IBAction func endGame() {
        winningScore = scores.max()!
        for i in 0...scores.count-2 {
            if scores[i] == winningScore {
                winners.append(players[i])
            }
        }
        if scores[scores.count-1] == winningScore {
            winners.append("Trump")
        }
        sendData(m: winners)
        performSegue(withIdentifier: "ScorestoGameEnd", sender: nil)
    }
    
}
