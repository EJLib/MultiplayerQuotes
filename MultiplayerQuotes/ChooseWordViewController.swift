//
//  ChooseWordViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 1/12/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit
import WebKit

var activeWordIndex: Int = -1

class ChooseWordViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "chooseword", withExtension: "html") {
            
            webView.configuration.userContentController.add(self, name: "selection")
            
            var html = ""
            for i in 0...quote.count-1 {
                //let modWord = removeInternalQuotes(word: word)
                html.append("<button onclick=\"window.webkit.messageHandlers.selection.postMessage({selectedWord: \(i)});\">\(quote[i])</button>")
            }
            
            webView.loadHTMLString(html, baseURL: url)

        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String : Int],
                let aW = dict["selectedWord"]
        else {
            print("error in userContentController")
            return
        }
        activeWordIndex = aW
        print(quote[activeWordIndex])
        //send quote, index, and segue all to next screen
        var sendQuote = quote
        sendQuote.insert("quote", at: 0)
        sendQuote.insert(String(activeWordIndex), at: 1)
        sendData(m: sendQuote)
        //segue this device
    }
    /*
    func removeInternalQuotes(word: String) -> String {
        var arrayWord = word.map(String.init)
        
        for i in 0...word.count-1 {
            if arrayWord[i] == "\"" || arrayWord[i] == "'" {
                arrayWord[i] = "\\\'"
            }
        }
        return arrayWord.joined()
    }*/
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


