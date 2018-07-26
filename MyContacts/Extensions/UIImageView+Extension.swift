//
//  UIImageView+Extension.swift
//  MyContacts
//
//  Created by jithin on 25/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(string: String?, color: UIColor, circular: Bool = true, fontSize: CGFloat = 20) {
        
        let attributes: [NSAttributedStringKey: Any]? = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize, weight: .medium)]
        let image = imageSnap(text: string != nil ? string?.initials : Constants.emptyText, color: color, circular: circular, textAttributes: attributes)
        
        if let newImage = image {
            self.image = newImage
        }
        
    }
    
    private func imageSnap(text: String?, color: UIColor, circular: Bool, textAttributes: [NSAttributedStringKey: Any]?) -> UIImage? {
        
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        if contentMode == .scaleToFill || contentMode == .scaleAspectFill || contentMode == .scaleAspectFit || contentMode == .redraw {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        let context = UIGraphicsGetCurrentContext()
        if circular {
            let path = CGPath(ellipseIn: bounds, transform: nil)
            context?.addPath(path)
            context?.clip()
        }
        
        // Fill
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Text
        if let text = text {
            let attributes = textAttributes ?? [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)]
            
            let textSize = text.size(withAttributes: attributes)
            let bounds = self.bounds
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            text.draw(in: rect, withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
