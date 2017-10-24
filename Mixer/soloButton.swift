//
//  soloButton.swift
//  Mixer
//
//  Created by cs1201 on 12/10/2017.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

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
        
        let color = bool ? UIColor.darkGray : UIColor.yellow
        let titleColor = bool ? UIColor.yellow : UIColor.black
        
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
    }
    
    
}
