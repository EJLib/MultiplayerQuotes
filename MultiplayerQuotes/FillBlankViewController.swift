//
//  FillBlankViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 3/8/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit

var playerResponse: String = ""
var numberPlayersDone = 0
var fbvc: UIViewController!
var quoteWithBlank: [String] = []
var responses: [Int : String] = [:]

class FillBlankViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var quoteLabel: UILabel!
    @IBOutlet var waitingLabel: UILabel!
    @IBOutlet var textBox: UITextField!
    @IBOutlet var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbvc = self
        textBox.delegate = self
        
        quoteWithBlank = quote
        quoteWithBlank.remove(at: activeWordIndex)
        quoteWithBlank.insert("_____", at: activeWordIndex)
        quoteLabel.text = quoteWithBlank.joined(separator: " ")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func playerResponseDone() {
        if textBox.text == "" {
            print("need to type something bud")
        /*}else if textBox.text!.contains(" ") {
            print("has to be one word")
            textBox.text = ""*/
        } else {
            playerResponse = textBox.text! //can it be nil?
            doneButton.isEnabled = false
            textBox.isEnabled = false
            waitingLabel.isHidden = false
            responses[players.count] = quote[activeWordIndex]
            responses[who] = playerResponse
            sendData(m: ["done", String(who), playerResponse])
            numberPlayersDone += 1
            if numberPlayersDone == players.count {
                numberPlayersDone = 0
                DispatchQueue.main.async {
                    fbvc!.performSegue(withIdentifier: "FillBlanktoVote", sender: nil)
                }
            }
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
