//
//  VoteViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 3/12/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

var vvc: UIViewController!
var tempResponses: [Int : String] = [:]
var choice: Int = -2
var votes: [Int] = []
var lastVoter = false

class VoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var choices: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vvc = self
        tableView.dataSource = self
        tableView.delegate = self
        tempResponses = responses
        quoteLabel.text = quoteWithBlank.joined(separator: " ")
        
        lastVoter = false
        
        for _ in 0...players.count {
            votes.append(0)
        }
        
        tempResponses.removeValue(forKey: who)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let temp = tempResponses.randomElement()?.key
        cell.textLabel?.text = tempResponses[temp!]
        tempResponses.removeValue(forKey: temp!)
        choices.append(temp!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choice = choices[indexPath.row]   //choice should be 'who' value of response chosen
        votes[choice] += 1
        sendData(m: ["votedover15characters", String(choice)])
        numberPlayersDone += 1
        if numberPlayersDone == players.count {
            numberPlayersDone = 0
            //nc.post(name: Notification.Name("showResults"), object: nil)
            lastVoter = true
        }
        vvc.performSegue(withIdentifier: "VotetoResults", sender: nil)
    }
    

}
