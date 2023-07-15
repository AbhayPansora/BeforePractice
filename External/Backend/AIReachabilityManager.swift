//
//  AIReachabilityManager.swift
//  Swift3CodeStucture
//
//  Created by Abhay Pansora on 11/24/16.
//  Copyright © 2016 agilepc-100. All rights reserved.
//


import UIKit
import Reachability
import Alamofire

class AIReachabilityManager: NSObject {
    
    var reachability:Reachability!
    

    static let sharedManager : AIReachabilityManager = {
        let instance = AIReachabilityManager()
        return instance
    }()
    
    func isInternetAvailableForAllNetworks() -> Bool
    {
        if(self.reachability == nil){
            self.doSetupReachability()
            return self.reachability!.connection == .unavailable || reachability!.connection == .wifi || self.reachability!.connection == .cellular
        }else{
            return reachability!.connection == .unavailable || reachability!.connection == .wifi || reachability!.connection == .cellular
        }
    }
    
    func doSetupReachability() {
        do{
            let reachability = try Reachability()
            self.reachability = reachability
        }catch {
            
        }
        reachability.whenReachable = { reachability in
        }
        reachability.whenUnreachable = { reachability in
        }
        do {
            try reachability.startNotifier()
        }
        catch {
        }
    }
    deinit{
        reachability.stopNotifier()
        reachability = nil
    }
    func manageInternetIaavailabelOrNot(){
        let rechability = NetworkReachabilityManager()
        rechability?.startListening(onUpdatePerforming: { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                self.onInternetDisconnection()
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                self.onInternetDisconnection() // not sure what to do for this case
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                
            case .reachable(.cellular):
                self.onInternetConnection(type: "WithloginData")
            }
        })
    }
    func onInternetDisconnection(){
        print("network gone")
    }
    func onInternetConnection(type : String){
        print("network back")
        
    }

}

