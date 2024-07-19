//
//  UIImage+.swift
//  DiffablePractice
//
//  Created by 아라 on 7/19/24.
//

import UIKit

extension UIImage {
    func cropSquare() -> UIImage? {
        let imageSize = size
        let shortLength = imageSize.width < imageSize.height ? imageSize.width : imageSize.height
        let origin = CGPoint(x: imageSize.width / 2 - shortLength / 2, y: imageSize.height / 2 - shortLength / 2)
        let size = CGSize(width: shortLength, height: shortLength)
        let square = CGRect(origin: origin, size: size)
        
        guard let squareImage = cgImage?.cropping(to: square) else { return nil }
        return UIImage(cgImage: squareImage)
    }
}
