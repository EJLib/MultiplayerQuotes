//
//  ViewController.swift
//  MultiplayerQuotes
//
//  Created by student on 12/3/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit
import MultipeerConnectivity

var who = ""

public var peerID = MCPeerID(displayName: UIDevice.current.name)
public var mcSession: MCSession?
public var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
public var players: [String] = []

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }

    
    @IBAction func chooseHost() {
        guard mcSession != nil else { return }
        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "EL-multiquote")
        mcAdvertiserAssistant?.delegate = self
        mcAdvertiserAssistant?.startAdvertisingPeer()
        players.append(peerID.displayName)
        who = "host"
        print(who)
    }
    
    @IBAction func chooseJoin() {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "EL-multiquote", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
        who = "joiner"
        print(who)
    }

    //Multipeer functions
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        let decoder = JSONDecoder()
        do {
            let p = try decoder.decode([String].self, from: data)
            players = p
        } catch let error as NSError {
            print(error)
        }
        
        /*have stuff later
        DispatchQueue.mainmasync { [weak self] in
            //
        }   */
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
            if who == "host" {
                players.append(peerID.displayName)
                print(players)
                //send to connected peers
                do {
                    var p: Data? = nil
                    p =  try JSONSerialization.data(withJSONObject:players, options: .prettyPrinted)
                    try mcSession?.send(p!, toPeers: mcSession!.connectedPeers, with: .reliable)
                    print(2)
                } catch let error as NSError {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        present(ac, animated: true)
                }
            }
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
        @unknown default:
            print("Unknown state recived: \(peerID.displayName)")
        }
    }
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)

        performSegue(withIdentifier: "toLobby", sender: nil)
        print("\(who) \(players)")
        
    }
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
        
    }
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcSession)
    }
}

