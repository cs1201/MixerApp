//
//  verticalFader.swift
//  Mixer
//
//  Created by Y1480077 on 12/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// Custom vertical fader UI element extending UISlider

import UIKit

@IBDesignable

class verticalFader: UISlider {
    
    override open func draw(_ rect: CGRect) {
        //Rotate UISlider 90 degrees to make horizontal
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    }
    
    //Override and edit thickness of track
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and size, changes thickness
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 8.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    //Set to fader button image
    @IBInspectable var faderImage: UIImage? {
        didSet{
            setThumbImage(faderImage, for: .normal)
        }
    }


}
