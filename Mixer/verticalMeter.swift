//
//  verticalMeter.swift
//  Mixer
//
//  Created by Y1480077 on 13/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// Custom vertical meter UI element extending UISlider

import UIKit

@IBDesignable

class verticalMeter: UISlider {

    override open func draw(_ rect: CGRect) {
        //Turn 90 degrees to make vertical
        self.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    }
    
    //Override and edit thickness of track
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and size, changes thickness
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 15.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    @IBInspectable var meterImage: UIImage? {
        didSet{
            setThumbImage(meterImage, for: .normal)
        }
    }


}
