//
//  soloButton.swift
//  Mixer
//
//  Created by Y1480077 on 12/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// Custom Toggle SOlo button with two UI states
//  Adapted from tutorial code from Sean Allen: https://www.youtube.com/watch?v=14rwyDsFma8&t=486s

import UIKit

class soloButton: UIButton {

    
    var isOn = true
    
    //Required overrides for editing UIbutton
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        backgroundColor =  UIColor.darkGray
        setTitleColor(UIColor.yellow, for: .normal)
        addTarget(self, action: #selector(muteButton.buttonPressed), for: .touchUpInside)
    }
    
    func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        //Change button and title colours based on selected state
        let color = bool ? UIColor.darkGray : UIColor.yellow
        let titleColor = bool ? UIColor.yellow : UIColor.black
        
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
    }
    
    
}
