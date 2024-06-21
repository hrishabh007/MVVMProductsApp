//
//  UiImageView + Extension.swift
//  MVVMProductsApp
//
//  Created by Rishabh Balani on 06/06/24.
//

import UIKit
import Kingfisher


//extension UIImageView {
//    func setImage(with urlString: String?, placeholder: UIImage? = nil) {
//            guard let urlString = urlString, let url = URL(string: urlString) else {
//                print("Invalid URL string.")
//                self.image = placeholder
//                return
//            }
//            
//            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
//            
//            // Set the activity indicator type
//            kf.indicatorType = .activity
//            
//            // Set the image using Kingfisher
//            kf.setImage(
//                with: resource,
//                placeholder: placeholder,
//                options: [
//                    .transition(.fade(0.2)),
//                    .cacheOriginalImage
//                ])
//        }
//}
