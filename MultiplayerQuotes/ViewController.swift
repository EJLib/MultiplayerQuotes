//
//  ViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/3/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

var who = 9
var ahandler = MPCHandler()

public var players: [String] = []
let group1 = DispatchGroup()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ahandler.initialize(host: self)
    }
    
    @IBAction func chooseHost() {
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

