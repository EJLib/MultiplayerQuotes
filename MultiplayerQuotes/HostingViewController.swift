//
//  HostingViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/7/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class HostingViewController: UIViewController {
    @IBOutlet var player1: UILabel!
    @IBOutlet var player2: UILabel!
    @IBOutlet var player3: UILabel!
    @IBOutlet var player4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player1.text = ""
        player2.text = ""
        player3.text = ""
        player4.text = ""
    }
    
    //Something so that people's names come up when they join
    //Enable start button once someone joins (change to multiple people in final version)
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
