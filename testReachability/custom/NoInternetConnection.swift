//
//  NoInternetConnection.swift
//  testReachability
//
//  Created by Mohamed Ali on 28/12/2023.
//

import UIKit

class NoInternetConnection: UIViewController {
    
    @IBOutlet weak var tryAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        tryAgainButton.setGradientBackground(colorOne: UIColor().hexStringToUIColor(hex: "#ff669f"), ColorTwo: UIColor().hexStringToUIColor(hex: "#ff8961"))
        tryAgainButton.layer.cornerRadius = 16.0
        tryAgainButton.layer.masksToBounds = true
    }
    
    @IBAction func tryAgainButtonAction (_ sender: Any) {
        print("F\(#line): called!!")
        ShardCheckConnection.shared.checkNetwork()
    }
}
