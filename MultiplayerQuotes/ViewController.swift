//
//  ViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/3/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
//import MultipeerConnectivity

var who = ""
var ahandler = MPCHandler()
var avc = ViewController()

public var players: [String] = []
let group1 = DispatchGroup()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ahandler.initialize()
    }

    
    @IBAction func chooseHost() {
        ahandler.startHost()
        players.append(peerID.displayName)
        who = "host"
        print(who)
    }
    
    @IBAction func chooseJoin() {
        ahandler.startJoin()
        group1.wait()
        present(mcBrowser!, animated: true)
        who = "joiner"
        print(who)
    }
    
    func dis() {
        group2.enter()
        mcBrowser!.dismiss(animated: true)
        group2.leave()
    }
    
    func segueToLobby() {
        self.performSegue(withIdentifier: "toLobby", sender: self)
        print("\(who) \(players)")
    }
    
}

