//
//  VoteViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 3/12/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

var vvc: UIViewController!
var tempResponses = responses
var choice: Int = -2

class VoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var choices: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vvc = self
        tableView.dataSource = self
        tempResponses = responses
        quoteLabel.text = quoteWithBlank.joined(separator: " ")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count+1
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
        print("test")
        print(choices)
        choice = choices[indexPath.row]
        print(choice)
    }
    

}
