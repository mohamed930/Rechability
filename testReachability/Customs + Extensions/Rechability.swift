//
//  Rechability.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import Foundation
import Reachability
import PlainPing
import Combine

class CheckConnection {
    //declare this property where it won't go out of scope relative to your listener
    private let reachability = try! Reachability()
    
    var successCounter = 0
    
    enum connectionStatus {
        case unspecified
        case connected
        case WifiNotValid
        case disconnected
        case error
    }
    
    private var connectionStatusPublisher = CurrentValueSubject<connectionStatus,Never>(.unspecified)
    var connectionStatusObservable: AnyPublisher<connectionStatus,Never> {
        return connectionStatusPublisher.eraseToAnyPublisher()
    }
    
    
    
    func startNotify() {
        reachability.whenReachable = { [weak self] reachability in
            guard let self = self else { return }
            
            self.successCounter = 0 // resete the counter..
            
            self.performTaskMultipleTimes { [weak self] response in
                guard let self = self else { return }
                
                if response == .connected {
                    self.connectionStatusPublisher.send(response)
                }
                else {
                    self.connectionStatusPublisher.send(.WifiNotValid)
                }
            }
            
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let self = self else { return }
            self.successCounter = 0 // resete the counter..
            self.connectionStatusPublisher.send(.disconnected)
        }

        do {
            try reachability.startNotifier()
        } catch {
            self.connectionStatusPublisher.send(.error)
        }
    }
    
    private func performTaskMultipleTimes(completion: @escaping (connectionStatus) -> Void) {
        var counter = 0

        let timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // Perform your task here
            self.pingNext { [weak self] result in
                guard let self = self else { return }
                
                self.successCounter = result ? (self.successCounter + 1) : self.successCounter
                
                if self.successCounter >= 2 {
                    timer.invalidate()
                    completion(.connected)
                }
                else {
                    if counter == 3 && self.successCounter < 2 {
                        completion(.disconnected)
                    }
                }
            }

            counter += 1
            if counter == 3 {
                timer.invalidate() // Stop the timer after 3 iterations
            }
        }

        // Ensure the timer fires even when the app is in background mode
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func pingNext(completion: @escaping (Bool) -> Void) {
        PlainPing.ping("www.google.com", withTimeout: 1.5, completionBlock: { (timeElapsed:Double?, error:Error?) in
            if let latency = timeElapsed {
                print("latency (ms): \(latency)")
                completion(true)
            }

            if let error = error {
                print("error: \(error.localizedDescription)")
                completion(false)
            }
        })
    }
}
