//
//  muteButton.swift
//  Mixer
//
//  Created by cs1201 on 12/10/2017.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//  Sourced from Sean Allen Youtube

import UIKit

class muteButton: UIButton {

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
        
        let color = bool ? UIColor.darkGray : UIColor.red
        let titleColor = bool ? UIColor.red : UIColor.black
        
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
    }


}
