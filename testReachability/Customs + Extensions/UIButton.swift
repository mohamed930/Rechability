//
//  UIButton.swift
//  testReachability
//
//  Created by Mohamed Ali on 28/12/2023.
//

import UIKit

extension UIButton {
    
    func setGradientBackground(colorOne: UIColor,ColorTwo: UIColor) {
        let colorTop =  colorOne.cgColor
        let colorBottom = ColorTwo.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = 16.0
        gradientLayer.frame = self.bounds
        
//        gradientLayer.frame = self.bounds
            
        // Ensure that the gradient layer extends to the edges of the view
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        // Disable opaque and clip to bounds
        self.isOpaque = false
        self.clipsToBounds = true
        // Ensure the gradient clips to the view's bounds
        gradientLayer.masksToBounds = true
        
        // Remove existing gradient layers before inserting a new one
        if let existingGradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            existingGradientLayer.removeFromSuperlayer()
        }
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
