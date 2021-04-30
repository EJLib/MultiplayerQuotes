//
//  NameViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 4/27/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit
import MultipeerConnectivity

let defaults = UserDefaults.standard

class NameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textBox.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func set() {
        if textBox.text == "" {
            print("need to type something bud")
        } else if textBox.text!.count > 15 {
            let alert = UIAlertController(title: "Your name is too long", message: "Please keep your name within 15 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            defaults.set(textBox.text!, forKey: "Name")
            peerID = MCPeerID(displayName: defaults.string(forKey: "Name")!)
            textBox.isEnabled = false
        }
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
