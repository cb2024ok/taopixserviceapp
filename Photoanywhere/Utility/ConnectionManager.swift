//
//  ConnectionManager.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/09/03.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import Reachability
import Combine

// MARK: Combine 개체를 이용하여 네트워크 상태정보를 받음
class ConnectionManager: ObservableObject {
    static let sharedInstance = ConnectionManager()
 
    let objectWillChange = ObservableObjectPublisher()
    let NetConnPublisher = PassthroughSubject<Bool,Never>()
    
    private var reachability: Reachability?
    var connected:Bool = false {
        didSet {
            NetConnPublisher.send(self.connected)
        }
    }
    
    init() {
    }
    
    func observeReachability() {
        self.reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability?.startNotifier()
        } catch(let error) {
            print("Reachabilty Startup Error!!: \(error) ")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            print("Cellular Network Connection")
            self.connected = true
            break
        case .wifi:
            print("WIFI Network Connection")
            self.connected = true
            break
        case .none:
            print("Network is not Available!!")
            self.connected = false
            break
        case .unavailable:
            self.connected = false
            print("Network를 사용할수 없습니다!!")
            break
        }
    }
}
