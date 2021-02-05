//
//  LobbyViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/7/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import MultipeerConnectivity

var timer: Timer? = nil

class LobbyViewController: UIViewController/*, MCSessionDelegate*/ {
    
    @IBOutlet var hostLabel: UILabel!
    @IBOutlet var player1: UILabel!
    @IBOutlet var player2: UILabel!
    @IBOutlet var player3: UILabel!
    @IBOutlet var player4: UILabel!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hostLabel.text = ""
        player1.text = ""
        player2.text = ""
        player3.text = ""
        player4.text = ""
        
        if who == "host" {
            startButton.isHidden = false
            startButton.isEnabled = false
        } else {
            startButton.isHidden = true
            startButton.isEnabled = false
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.updateNames()
        }
    }
 
    func updateNames() {
        if players.count > 0 {
            self.hostLabel.text = "Host:  \(players[0])"
            self.startButton.isEnabled = false
        }
        if players.count > 1 {
            self.player1.text = players[1]
            if who == "host" {
                self.startButton.isEnabled = true
            }
        }
        if players.count > 2 {
            self.player2.text = players[2]
        }
        if players.count > 3 {
            self.player3.text = players[3]
        }
        if players.count > 4 {
            self.player4.text = players[4]
        }
        //If someone leaves the button will respond accordinly but the name will still be there- make players array of ""?
        //Though right now people aren't removed from players if they disconnect
    }
    
    
    @IBAction func startButtonPressed() {
        timer?.invalidate()
        performSegue(withIdentifier: "toChooseWord", sender: nil)
        //send message to start (somehow)
    }
    
}
    
    
    
    
    
