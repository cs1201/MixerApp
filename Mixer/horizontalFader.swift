//
//  verticalFader.swift
//  Mixer
//
//  Created by cs1201 on 12/10/2017.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import UIKit

@IBDesignable

class horizontalFader: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 7.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    
    @IBInspectable var faderImage: UIImage? {
        didSet{
            setThumbImage(faderImage, for: .normal)
        }
    }
    
    
}
