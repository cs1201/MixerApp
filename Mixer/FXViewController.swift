//
//  FXViewController.swift
//  Mixer
//
//  Created by Y1480077 on 25/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
//
//  Contains all knob controls for FX Section in specific container view. And handles label returns from AudioMixer.swift

import UIKit

class FXViewController: UIViewController {
    //Outlets to all knobs and labels
    @IBOutlet weak var reverb1_1 : FXKnobView!
    @IBOutlet weak var reverb1_2 : FXKnobView!
    @IBOutlet weak var reverb1_3 : FXKnobView!
    @IBOutlet weak var reverb1_4 : FXKnobView!
    @IBOutlet weak var reverb1_5 : FXKnobView!
    @IBOutlet weak var reverb2_1 : FXKnobView!
    @IBOutlet weak var reverb2_2 : FXKnobView!
    @IBOutlet weak var reverb2_3 : FXKnobView!
    @IBOutlet weak var reverb2_4 : FXKnobView!
    @IBOutlet weak var reverb2_5 : FXKnobView!
    @IBOutlet weak var delay1 : FXKnobView!
    @IBOutlet weak var delay2 : FXKnobView!
    @IBOutlet weak var delay3 : FXKnobView!
    @IBOutlet weak var delay4 : FXKnobView!
    @IBOutlet weak var delay5 : FXKnobView!
    @IBOutlet weak var chorus1 : FXKnobView!
    @IBOutlet weak var chorus2 : FXKnobView!
    @IBOutlet weak var chorus3 : FXKnobView!
    @IBOutlet weak var chorus4 : FXKnobView!
    @IBOutlet weak var chorus5 : FXKnobView!
    
    @IBOutlet weak var reverb1_1Label: UILabel!
    @IBOutlet weak var reverb2_1Label: UILabel!
    @IBOutlet weak var delay1Label: UILabel!
    @IBOutlet weak var chorus1Label: UILabel!
    @IBOutlet weak var reverb1_2Label: UILabel!
    @IBOutlet weak var reverb2_2Label: UILabel!
    @IBOutlet weak var delay2Label: UILabel!
    @IBOutlet weak var chorus2Label: UILabel!
    @IBOutlet weak var reverb1_3Label: UILabel!
    @IBOutlet weak var reverb2_3Label: UILabel!
    @IBOutlet weak var delay3Label: UILabel!
    @IBOutlet weak var chorus3Label: UILabel!
    @IBOutlet weak var reverb1_4Label: UILabel!
    @IBOutlet weak var reverb2_4Label: UILabel!
    @IBOutlet weak var delay4Label: UILabel!
    @IBOutlet weak var chorus4Label: UILabel!
    @IBOutlet weak var reverb1_5Label: UILabel!
    @IBOutlet weak var reverb2_5Label: UILabel!
    @IBOutlet weak var delay5Label: UILabel!
    @IBOutlet weak var chorus5Label: UILabel!
    
    var audioMixer: AudioMixerSkeleton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        //Initialise Knobs to 0
        knobInit()
        //Access shared instance of audioMixer class
        audioMixer = AudioMixerSkeleton.sharedInstance
    }
    
//*****************************************************************
// MARK: - Delegate declaration
//*****************************************************************
    func setDelegates(){
        
        reverb1_1.delegate = self
        reverb1_2.delegate = self
        reverb1_3.delegate = self
        reverb1_4.delegate = self
        reverb1_5.delegate = self
        
        reverb2_1.delegate = self
        reverb2_2.delegate = self
        reverb2_3.delegate = self
        reverb2_4.delegate = self
        reverb2_5.delegate = self
        
        delay1.delegate = self
        delay2.delegate = self
        delay3.delegate = self
        delay4.delegate = self
        delay5.delegate = self
        
        chorus1.delegate = self
        chorus2.delegate = self
        chorus3.delegate = self
        chorus4.delegate = self
        chorus5.delegate = self
    
    }
    //initialise  FX Sends knobsto 0
    func knobInit(){
        reverb1_1.value = 0.0
        reverb1_2.value = 0.0
        reverb1_3.value = 0.0
        reverb1_4.value = 0.0
        reverb1_5.value = 0.0
        reverb2_1.value = 0.0
        reverb2_2.value = 0.0
        reverb2_3.value = 0.0
        reverb2_4.value = 0.0
        reverb2_5.value = 0.0
        delay1.value = 0.0
        delay2.value = 0.0
        delay3.value = 0.0
        delay4.value = 0.0
        delay5.value = 0.0
        chorus1.value = 0.0
        chorus2.value = 0.0
        chorus3.value = 0.0
        chorus4.value = 0.0
        chorus5.value = 0.0
    }
}

//*****************************************************************
// MARK: - Knob Delegate
//*****************************************************************

extension FXViewController: FXKnobDelegate {
    
    func updateFXKnobValue(_ value: Double, tag: Int){
        //Send knob value to audioMixer
        audioMixer.FXSends(tag, value)
        //Update relevant label with percentage of FX send value
        let display = Int(value * 100)
        
        switch(tag){
        case 0:
            reverb1_1Label.text = "\(display)%"
        case 1:
            reverb2_1Label.text = "\(display)%"
        case 2:
            delay1Label.text = "\(display)%"
        case 3:
            chorus1Label.text = "\(display)%"
        case 10:
            reverb1_2Label.text = "\(display)%"
        case 11:
            reverb2_2Label.text = "\(display)%"
        case 12:
            delay2Label.text = "\(display)%"
        case 13:
            chorus2Label.text = "\(display)%"
        case 20:
            reverb1_3Label.text = "\(display)%"
        case 21:
            reverb2_3Label.text = "\(display)%"
        case 22:
            delay3Label.text = "\(display)%"
        case 23:
            chorus3Label.text = "\(display)%"
        case 30:
            reverb1_4Label.text = "\(display)%"
        case 31:
            reverb2_4Label.text = "\(display)%"
        case 32:
            delay4Label.text = "\(display)%"
        case 33:
            chorus4Label.text = "\(display)%"
        case 40:
            reverb1_5Label.text = "\(display)%"
        case 41:
            reverb2_5Label.text = "\(display)%"
        case 42:
            delay5Label.text = "\(display)%"
        case 43:
            chorus5Label.text = "\(display)%"
        default:
            break
        }
    }
}
