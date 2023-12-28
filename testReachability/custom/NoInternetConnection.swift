//
//  NoInternetConnection.swift
//  testReachability
//
//  Created by Mohamed Ali on 28/12/2023.
//

import UIKit
import Combine

class NoInternetConnection: UIViewController {
    
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var connection = CheckConnection()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        // subscribeToReachability()
    }
    
    func configureUI() {
        tryAgainButton.setGradientBackground(colorOne: UIColor().hexStringToUIColor(hex: "#ff669f"), ColorTwo: UIColor().hexStringToUIColor(hex: "#ff8961"))
        tryAgainButton.layer.cornerRadius = 16.0
        tryAgainButton.layer.masksToBounds = true
    }
    
    func subscribeToReachability() {
        reachability.connectionStatusObservable.sink(receiveValue: { [weak self] status in
            guard let self = self else { return }
            
            print(status)
            
            if status == .connected {
                self.navigationController?.topViewController?.dismiss(animated: true)
            }
            
        }).store(in: &cancellables)
    }
    
    @IBAction func tryAgainButtonAction (_ sender: Any) {
//        reachability = CheckConnection()
        reachability.startNotify()
    }
}
