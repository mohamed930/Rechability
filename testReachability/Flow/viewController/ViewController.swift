//
//  ViewController.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewmodel = ViewModel()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        subscribeToData()
//        subscribeToDisconnectPublisher()
//        fetchData()
    }

    func subscribeToData() {
        viewmodel.dataPublisher.sink(receiveValue: { [weak self] msg in
            self?.messageLabel.text = msg
            self?.messageLabel.textColor = .black
        }).store(in: &cancellable)
    }
    
    func subscribeToDisconnectPublisher() {
        viewmodel.disconnectedPublisher.sink(receiveValue: { [weak self] msg in
            guard let self = self else { return }
            
            self.messageLabel.text = msg
            self.messageLabel.textColor = .red
        }).store(in: &cancellable)
    }

    func fetchData() {
        viewmodel.fetchData()
    }
}

