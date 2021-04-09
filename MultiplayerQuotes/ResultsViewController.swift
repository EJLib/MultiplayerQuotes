//
//  ResultsViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 3/23/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

var rvc: UIViewController!
let nc = NotificationCenter.default

class ResultsViewController: UIViewController {
    @IBOutlet var waitingLabel: UILabel!
    @IBOutlet var tallyLabel: UILabel!
    @IBOutlet var quoteWithResponse: UILabel!
    var i = 1
    var qWR = quote
    var t: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rvc = self
        
        waitingLabel.isHidden = false
        tallyLabel.isHidden = true
        quoteWithResponse.isHidden = true
        
        nc.addObserver(self, selector: #selector(showResults), name: Notification.Name("showResults"), object: nil)
        
        if lastVoter {
            showResults()
            lastVoter = false
        }
    }

    @objc func fireTimer() {
        if i == players.count {
            quoteWithResponse.text = quote.joined(separator: " ")
            tallyLabel.text = "Trump got \(votes[players.count]) vote(s)!"
            i+=1
        } else if i == players.count+1 {
            t!.invalidate()
            performSegue(withIdentifier: "VotetoScores", sender: nil)
        } else {
            qWR.remove(at: activeWordIndex)
            qWR.insert(responses[i]!, at: activeWordIndex)
            quoteWithResponse.text = qWR.joined(separator: " ")
            tallyLabel.text = "\(players[i]) got \(votes[i]) vote(s)!"
            i += 1
        }
    }
    
    @objc func showResults() {
        
        waitingLabel.isHidden = true
        tallyLabel.isHidden = false
        quoteWithResponse.isHidden = false
        
        qWR.remove(at: activeWordIndex)
        qWR.insert(responses[0]!, at: activeWordIndex)
        self.quoteWithResponse.text = qWR.joined(separator: " ")
        self.tallyLabel.text = "\(players[0]) got \(votes[0]) vote(s)!"
        
        t = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            
    }
    
    

}

/*
 Show quote and score for 3 seconds each
 I have votes which is [who]
 */
