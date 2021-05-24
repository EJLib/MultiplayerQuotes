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
var scores: [Int] = []
var lvc = LobbyViewController()

class LobbyViewController: UIViewController/*, MCSessionDelegate*/ {
    
    @IBOutlet var hostLabel: UILabel!
    @IBOutlet var player1: UILabel!
    @IBOutlet var player2: UILabel!
    @IBOutlet var player3: UILabel!
    @IBOutlet var player4: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lvc = self

        hostLabel.text = ""
        player1.text = ""
        player2.text = ""
        player3.text = ""
        player4.text = ""
        
        if who == 0 {
            startButton.isHidden = false
            startButton.isEnabled = false //change to true for testing purposes
            cancelButton.isHidden = false
            cancelButton.isEnabled = true
        } else {
            startButton.isHidden = true
            startButton.isEnabled = false
        }
        
        hostLabel.text = "Host:  \(players[0])"
 
        // The names in the lobby update every 1 second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.updateNames()
        }
     
    }
 
    func updateNames() {
        if players.count > 1 {
            self.player1.text = players[1]
            if who == 0 {                       //can move to increase player minimum
                self.startButton.isEnabled = true
            }
        } else {
            self.player1.text = ""
            self.player2.text = ""
            self.player3.text = ""
            self.player4.text = ""
        }
        if players.count > 2 {
            self.player2.text = players[2]
        } else {
            self.player2.text = ""
            self.player3.text = ""
            self.player4.text = ""
        }
        if players.count > 3 {
            self.player3.text = players[3]
        } else {
            self.player3.text = ""
            self.player4.text = ""
        }
        if players.count > 4 {
            self.player4.text = players[4]
        } else {
            self.player4.text = ""
        }
    }

    @IBAction func cancelButtonPressed() {
        timer?.invalidate()
        mcAdvertiserAssistant?.stopAdvertisingPeer()
        sendData(m: ["disconnectover15characters"])
        players = []
        who = -1
        performSegue(withIdentifier: "LobbytoView", sender: nil)
    }
    
    @IBAction func startButtonPressed() {
        timer?.invalidate()
        mcAdvertiserAssistant?.stopAdvertisingPeer()
        for _ in 0...players.count {
            scores.append(0)
        }
        sendData(m: ["segueToWaitingRoom"])
    }
    
}
    
    
    
    
    
