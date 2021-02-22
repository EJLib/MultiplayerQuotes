//
//  MPCHandler.swift
//  MultiplayerQuotes
//
//  Created by student on 1/19/21.
//  Copyright © 2021 student. All rights reserved.
//

import Foundation
import MultipeerConnectivity

public var peerID = MCPeerID(displayName: UIDevice.current.name)
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
            if who == 0 {
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
        @unknown default:
            print("Unknown state recived: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let decoder = JSONDecoder()
        do {
            let p = try decoder.decode([String].self, from: data)
            if p[0] == "segueToWaitingRoom" {
                print("segueToWaitingRoom")
                DispatchQueue.main.async { [weak self] in
                    lvc!.performSegue(withIdentifier: "toWaitingScreen", sender: nil)
                }
            } else {
                players = p
                print("players: \(players)")
                who = players.count-1
                print(who)
            }
        } catch let error as NSError {
            print(error)
        }
        
        /*have stuff later
        DispatchQueue.main.async { [weak self] in
            //
        }   */
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
        var p: Data? = nil
        p =  try JSONSerialization.data(withJSONObject: m, options: .prettyPrinted)
        try mcSession?.send(p!, toPeers: mcSession!.connectedPeers, with: .reliable)
    } catch let error as NSError {
        print(error)
    }
}
