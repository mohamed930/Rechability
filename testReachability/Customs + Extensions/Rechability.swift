//
//  Rechability.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import Foundation
import Reachability
import SystemConfiguration
import Combine

class CheckConnection {
    //declare this property where it won't go out of scope relative to your listener
    private let reachability = try! Reachability()
    
    enum connectionStatus {
        case unspecified
        case connected
        case disconnected
        case error
    }
    
    private var connectionStatusPublisher = CurrentValueSubject<connectionStatus,Never>(.unspecified)
    var connectionStatusObservable: AnyPublisher<connectionStatus,Never> {
        return connectionStatusPublisher.eraseToAnyPublisher()
    }
    
    init() {
        reachability.whenReachable = { [weak self] reachability in
            guard let self = self else { return }
            
            if self.isConnectedToNetwork() {
                print("connected")
            }
            else {
                print("not connected")
            }
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let self = self else { return }
            self.connectionStatusPublisher.send(.disconnected)
        }

        do {
            try reachability.startNotifier()
        } catch {
            self.connectionStatusPublisher.send(.error)
        }
    }
    
    func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired

        return isReachable && !needsConnection
        */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret
    }
}
