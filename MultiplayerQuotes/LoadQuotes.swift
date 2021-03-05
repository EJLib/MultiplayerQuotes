//
//  LoadQuotes.swift
//  MultiplayerQuotes
//
//  Created by student on 3/1/21.
//  Copyright © 2021 student. All rights reserved.
//

import Foundation

var quote: [String] = []

struct stringQuote: Codable {
    let value: String
}

func loadQuote() {
    let url = URL(string: "https://tronalddump.io/random/quote")!
    URLSession.shared.dataTask(with: url) { (data, reponse, error) in
        guard let data = data else {
            return
        }
        do{
            let text = try JSONDecoder().decode(stringQuote.self, from: data)
            quote = text.value.components(separatedBy: " ")
            print(quote)
                
        } catch let error {
            print("\(error)")
        }
    } .resume()
    //sendData(m: ["yo"])
}

