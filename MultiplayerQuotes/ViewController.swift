//
//  ViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/3/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import MultipeerConnectivity

var who = -1                //is set when a game is started or joined, index of players
var activePlayer = 0        //indicates who chooses the word to be replaced, cycles
var ahandler = MPCHandler()

var players: [String] = []  //list of players, same order for everyone
let group1 = DispatchGroup()    //used in chooseJoin

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mcSession != nil {           //closes a hosted game if cancelled or ended
            mcSession?.disconnect()
        }
        
        if defaults.string(forKey: "Name") == nil {     //makes creating players simpler
            defaults.setValue(UIDevice.current.name, forKey: "Name")
        }
        //sets stored name value as the device name if none has been set by the player
        
        
    }
    
    @IBAction func chooseHost() {
        ahandler.initialize(host: self)
        loadQuote()
        ahandler.startHost()
        players.append(defaults.string(forKey: "Name")!)
        who = 0
    }
    
    @IBAction func chooseJoin() {
        ahandler.initialize(host: self)
        ahandler.startJoin()
        group1.wait()
        present(mcBrowser!, animated: true)
        performSegue(withIdentifier: "toLobby", sender: nil)
    }
    
}

