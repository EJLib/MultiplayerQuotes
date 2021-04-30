//
//  MPCHandler.swift
//  MultiplayerQuotes
//
//  Created by student on 1/19/21.
//  Copyright © 2021 student. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public var peerID = MCPeerID(displayName: defaults.string(forKey: "Name") ?? UIDevice.current.name)
public var mcSession: MCSession?
public var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
public var mcBrowser: MCBrowserViewController?

var hvc: ViewController?

class MPCHandler: NSObject, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate {
    
    func initialize(host: ViewController) {
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        hvc = host
        mcSession?.delegate = self
    }
    
    func startHost() {
        guard mcSession != nil else { return }
        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "EL-multiquote")
        mcAdvertiserAssistant?.delegate = self
        mcAdvertiserAssistant?.startAdvertisingPeer()
    }
    
    func startJoin() {
        group1.enter()
        guard let mcSession = mcSession else { return }
        mcBrowser = MCBrowserViewController(serviceType: "EL-multiquote", session: mcSession)
        mcBrowser?.delegate = self
        group1.leave()
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
            if who == 0 {                            //host updates players, then sends
                players.append(peerID.displayName)
                print(players)
                //send to connected peers
                sendData(m: players)
                if players.count == 5 {
                    mcAdvertiserAssistant?.stopAdvertisingPeer()
                }
            }
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
            if who == 0 && scores == [] {   //scores == [] indicates in lobby
                let d = players.firstIndex(of: peerID.displayName)!
                players.remove(at: d)
                print(players)
                sendData(m: players)
                if players.count == 4 {
                    mcAdvertiserAssistant?.startAdvertisingPeer()
                }
            }
        @unknown default:
            print("Unknown state recived: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let decoder = JSONDecoder()
        do {
            var p = try decoder.decode([String].self, from: data)
            if p[0] == "segueToWaitingRoom" {
                for _ in 0...players.count {
                    scores.append(0)
                }
                DispatchQueue.main.async {
                    lvc.performSegue(withIdentifier: "toWaitingScreen", sender: nil)
                }
            } else if p[0] == "quoteover15characters" {
                activeWordIndex = Int(p[1])!
                p.removeSubrange(0...1)
                quote = p
                DispatchQueue.main.async {
                    wsvc!.performSegue(withIdentifier: "WaitingScreentoFillBlank", sender: nil)
                }
            } else if p[0] == "doneover15characters" {
                responses[Int(p[1])!] = p[2]
                numberPlayersDone += 1
                if numberPlayersDone == players.count {
                    numberPlayersDone = 0
                    DispatchQueue.main.async {
                        fbvc!.performSegue(withIdentifier: "FillBlanktoVote", sender: nil)
                    }
                }
            } else if p[0] == "votedover15characters" {
                votes[Int(p[1])!] += 1
                numberPlayersDone += 1
                if numberPlayersDone == players.count {
                    numberPlayersDone = 0
                    DispatchQueue.main.async {  //not sure I need this
                        nc.post(name: Notification.Name("showResults"), object: nil)
                    }
                }
            } else if p[0] == "NewRoundover15characters" {
                if who == activePlayer {
                    DispatchQueue.main.async {
                        svc!.performSegue(withIdentifier: "ScorestoChooseWord", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        svc!.performSegue(withIdentifier: "ScorestoWaiting", sender: nil)
                    }
                }
            } else if p[0] == "disconnectover15characters" {
                print("disconnect")
                mcSession!.disconnect()
                players = []
                who = -1
                DispatchQueue.main.async {
                    lvc.performSegue(withIdentifier: "LobbytoView", sender: nil)
                }
            } else {
                players = p
                print("players: \(players)")
                if who == -1 {
                    who = players.count-1
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        mcBrowser!.dismiss(animated: true)
        hvc!.performSegue(withIdentifier: "toLobby", sender: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        mcBrowser!.dismiss(animated: true)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcSession)
            //at some point change to let people be declined
    }

}

func sendData(m: [String]) {
    do {
        print("sending \(m)")
        var p: Data? = nil
        p =  try JSONSerialization.data(withJSONObject: m, options: .prettyPrinted)
        try mcSession?.send(p!, toPeers: mcSession!.connectedPeers, with: .reliable)
    } catch let error as NSError {
        print(error)
    }
}
