//
//  ViewModel.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import Foundation
import Combine

class ViewModel {
    private var checkconnection = CheckConnection()
    private var cancellables = Set<AnyCancellable>()
    
    var dataPublisher = PassthroughSubject<String,Never>()
    var disconnectedPublisher = PassthroughSubject<String,Never>()
    
    func fetchData() {
        checkconnection.connectionStatusObservable.sink(receiveValue: { [weak self] connection in
            guard let self = self else { return }
            
            switch connection {
                
            case .unspecified: break
            case .connected:
                self.dataPublisher.send("Hello Mr/ Mohamed Ali!")
            case .disconnected:
                self.disconnectedPublisher.send("Disconncted")
            case .error:
                print("Error in notifing")
            }
        }).store(in: &cancellables)
    }
}
