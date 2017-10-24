//
//  verticalMeter.swift
//  Mixer
//
//  Created by cs1201 on 13/10/2017.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import UIKit

@IBDesignable

class verticalMeter: UISlider {

    override open func draw(_ rect: CGRect) {
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
