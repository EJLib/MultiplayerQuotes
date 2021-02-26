//
//  ChooseWordViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 1/12/21.
//  Copyright © 2021 student. All rights reserved.
//

import UIKit
import WebKit

var quote: [String] = []
var activeWord: String = ""

class ChooseWordViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "chooseword", withExtension: "html") {
            //let config = WKWebViewConfiguration()
            //config.userContentController.add(self, name: "selection")
            //let rect = CGRect(x: 20, y: 78, width: 628, height: 218)
            //webView = WKWebView(frame: rect, configuration: config)
            webView.configuration.userContentController.add(self, name: "selection")
            
            
            //webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
      
           // get quote from backlog - need to get json, convert quote section into a list of strings, and convert back to json
            
            quote = ["This", "is", "a", "test."]

            var html = "" /*
            for word in quote {
                html.append("<button onclick='window.webkit.messageHandlers.selection.postMessage({selectedWord: '\(word)'});'>\(word)</button>")
            }*/
            
            //webView.loadHTMLString(html, baseURL: url)
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            
            /*
            do {
                var p: Data? = nil
                p =  try JSONSerialization.data(withJSONObject: quote, options: .prettyPrinted)
                let s = String(data: p!, encoding:.utf8)
                let javascript = "document.getElementById('q').innerHTML = '\(s)';"
                webView.evaluateJavaScript(javascript, completionHandler: nil)
            
            } catch let error as NSError {
                print(error)
            }
            */
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("here")
        guard let dict = message.body as? [String : String],
                let aW = dict["selectedWord"]
        else {
            print("error in userContentController")
            return
        }
        //activeWord = aW
        print(aW)
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


