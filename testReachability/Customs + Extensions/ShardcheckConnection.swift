//
//  ShardcheckConnection.swift
//  testReachability
//
//  Created by Mohamed Ali on 28/12/2023.
//

import Combine
import UIKit

class ShardCheckConnection {
    static let shared = ShardCheckConnection()
    
    private var connection = CheckConnection()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        connection.startNotify()
    }
    
    func checkNetwork() {
        connection = CheckConnection()
        connection.startNotify()
        noInternetConnection(navigationController: navigation)
    }
    
    func noInternetConnection(navigationController: UINavigationController) {
        
        connection.connectionStatusObservable.sink(receiveValue: { status in
            let vc = NoInternetConnection()
            vc.modalPresentationStyle = .fullScreen
            
            print(status)
            
            switch status {
                case .unspecified: break
                case .connected:
                    navigationController.topViewController?.dismiss(animated: true)
                case .WifiNotValid:
                    navigationController.topViewController?.present(vc, animated: true)
                case .disconnected:
                    navigationController.topViewController?.present(vc, animated: true)
                case .error: break
            }
            
        }).store(in: &cancellable)
    }
}
