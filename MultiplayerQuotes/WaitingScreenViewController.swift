//
//  WaitingScreenViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 2/22/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

var wsvc: UIViewController?

class WaitingScreenViewController: UIViewController {
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        wsvc = self
        
        label.text = "Waiting for \(players[activePlayer])"
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
