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

class ScoresViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var nextRoundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        svc = self
        
        responses.removeAll()
        if activePlayer < players.count-1 {
            activePlayer += 1
        } else {
            activePlayer = 0
        }
        
        print(scores)
        print(votes)
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
        }
        
    }
    
    @IBAction func startNextRound() {
        loadQuote()
        sendData(m: ["NewRound"])
        performSegue(withIdentifier: "ScorestoWaiting", sender: nil)
    }

}
