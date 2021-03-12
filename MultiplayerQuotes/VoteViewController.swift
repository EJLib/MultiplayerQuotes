//
//  VoteViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 3/12/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

let xCoordinates: [[CGFloat]] = [[35, 35, 35], [35, 35, 35, 35], [35, 35+612/3, 35+612*2/3, 50, 90]]
let dimensions: [[CGFloat]] = [[612, 223/3], [612, 223/4], [612/3, 223/2], [612/3, 223/2]]

var vvc: UIViewController!

class VoteViewController: UIViewController {
    
    @IBOutlet var quoteLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vvc = self
        
        var quoteWithBlank = quote
        quoteWithBlank.remove(at: activeWordIndex)
        quoteWithBlank.insert("_____", at: activeWordIndex)
        quoteLabel.text = quoteWithBlank.joined(separator: " ")
        
        for i in 0...players.count {
            makeButton(i: i)
        }
        
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

}

func makeButton(i: Int) {
    let button = UIButton()
    button.frame = CGRect(x: xCoordinates[players.count-2][i], y: 132+111.5*CGFloat(i), width: dimensions[players.count-2][0], height: dimensions[players.count-2][1])
    button.setTitle("Test", for: .normal)
    button.backgroundColor = UIColor.darkGray
    vvc.view.addSubview(button)
}
