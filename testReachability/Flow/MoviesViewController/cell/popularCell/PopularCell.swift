//
//  PopularCell.swift
//  testReachability
//
//  Created by Mohamed Ali on 30/12/2023.
//

import UIKit

class PopularCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var blurImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView.layer.cornerRadius = 16.0
        mainImageView.layer.masksToBounds = true
//        guard let image = self.blurImage(usingImage: UIImage(named: "Ellipse 2")!, blurAmount: 20.0) else { return }
//        blurImage.image = image
    }

    func blurImage(usingImage image: UIImage, blurAmount: CGFloat) -> UIImage?
    {
        guard let cilmage = CIImage(image: image) else { return nil }
        let blurFilter = CIFilter (name: "CIGaussianBlur")
        blurFilter?.setValue(cilmage, forKey: kCIInputImageKey)
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
        guard let outputImage = blurFilter?.outputImage else { return nil }
        
        return UIImage(ciImage: outputImage)
    }
}
