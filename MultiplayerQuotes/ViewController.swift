//
//  ViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/3/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

var who = -1
var activePlayer = 0
var ahandler = MPCHandler()

var players: [String] = []
let group1 = DispatchGroup()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ahandler.initialize(host: self)
    }
    
    @IBAction func chooseHost() {
        loadQuote()
        ahandler.startHost()
        players.append(peerID.displayName)
        who = 0
    }
    
    @IBAction func chooseJoin() {
        ahandler.startJoin()
        group1.wait()
        present(mcBrowser!, animated: true)
        performSegue(withIdentifier: "toLobby", sender: nil)
    }
    
}

