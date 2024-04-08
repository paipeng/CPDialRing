//
//  UIImage+rotate.swift
//  CPDialRing
//
//  Created by Pai Peng on 2024/4/8.
//

import UIKit


extension UIImage {
    public func imageRotated(radians: CGFloat) -> UIImage? {
        // calculate the size of the rotated view's containing box for our drawing space
        let originalSize = size
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(radians);
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        context.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        context.rotate(by: radians);
        
        // Now, draw the rotated/scaled image into the context
        //context.scaleBy(x: 1.0, y: -1.0)
        
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        
        // keep size
        let cropImage = cropImage1(image: newImage, rect: CGRectMake((newImage.size.width - originalSize.width)/2, (newImage.size.height - originalSize.height)/2, originalSize.width, originalSize.height))
        
        return cropImage
    }
    
    func cropImage1(image: UIImage, rect: CGRect) -> UIImage {
        let cgImage = image.cgImage! // better to write "guard" in realm app
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
    
    func cropImage2(image: UIImage, rect: CGRect, scale: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width / scale, height: rect.size.height / scale), true, 0.0)
        image.draw(at: CGPoint(x: -rect.origin.x / scale, y: -rect.origin.y / scale))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return croppedImage
    }
}
