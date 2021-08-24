//
//  UIView+Setup.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 24/08/21.
//

import UIKit


extension UIView {
    
    /// Load the given xib file as a superview content
    /// - Parameters:
    ///   - contentView: superview container content view
    ///   - xib: xib name
    func loadXib(targetView contentView: inout UIView?, xibName xib: String) {
        // load xib into content view
        contentView = Bundle.main.loadNibNamed(xib, owner: self, options: nil)![0] as? UIView
        self.addSubview(contentView!)
        contentView!.frame = self.bounds
        contentView!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    /// Round this view corners
    /// - Parameters:
    ///   - corners: which corners shall be rounded
    ///   - radius: target corner radius
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path: UIBezierPath = UIBezierPath(roundedRect: bounds,
                                                  byRoundingCorners: corners,
                                                  cornerRadii: CGSize(width: radius, height: radius))
            let mask: CAShapeLayer = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
