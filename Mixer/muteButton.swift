//
//  muteButton.swift
//  Mixer
//
//  Created by Y1480077 on 12/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.

// Custom Toggle Mute button with two UI states
//  Adapted from tutorial code from Sean Allen: https://www.youtube.com/watch?v=14rwyDsFma8&t=486s

import UIKit

class muteButton: UIButton {
    //is selected toggle
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
        setTitleColor(UIColor.red, for: .normal)
        addTarget(self, action: #selector(muteButton.buttonPressed), for: .touchUpInside)
    }
    
    func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        //Change button and title colours based on selected state
        let color = bool ? UIColor.darkGray : UIColor.red
        let titleColor = bool ? UIColor.red : UIColor.black
        
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
    }


}
