//
//  Knob+Touches.swift

//  Adapted by Y1480077 from: https://github.com/AudioKit/AudioKit/tree/master/Examples/iOS/AnalogSynthX/AnalogSynthX
//  Copyright © 2017 Y1480077. All rights reserved.

// Custom rotary knob

import UIKit

extension CompKnobView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint = touch.location(in: self)
            lastX = touchPoint.x
            lastY = touchPoint.y
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint = touch.location(in: self)
            setPercentagesWithTouchPoint(touchPoint)
        }
    }

}
