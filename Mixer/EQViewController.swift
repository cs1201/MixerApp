//
//  EQViewController.swift
//  Mixer
//
//  Created by cs1201 on 17/10/2017.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import UIKit

class EQViewController: UIViewController {
    
    @IBOutlet weak var lf1Gain: KnobView!
    @IBOutlet weak var lf1Freq: KnobView!
    @IBOutlet weak var mf1Gain: KnobView!
    @IBOutlet weak var mf1Freq: KnobView!
    @IBOutlet weak var mf1Q:    KnobView!
    @IBOutlet weak var hf1Gain: KnobView!
    @IBOutlet weak var hf1Freq: KnobView!
    
    @IBOutlet weak var lf2Gain: KnobView!
    @IBOutlet weak var lf2Freq: KnobView!
    @IBOutlet weak var mf2Gain: KnobView!
    @IBOutlet weak var mf2Freq: KnobView!
    @IBOutlet weak var mf2Q:    KnobView!
    @IBOutlet weak var hf2Gain: KnobView!
    @IBOutlet weak var hf2Freq: KnobView!
    
    @IBOutlet weak var lf3Gain: KnobView!
    @IBOutlet weak var lf3Freq: KnobView!
    @IBOutlet weak var mf3Gain: KnobView!
    @IBOutlet weak var mf3Freq: KnobView!
    @IBOutlet weak var mf3Q:    KnobView!
    @IBOutlet weak var hf3Gain: KnobView!
    @IBOutlet weak var hf3Freq: KnobView!
    
    @IBOutlet weak var lf4Gain: KnobView!
    @IBOutlet weak var lf4Freq: KnobView!
    @IBOutlet weak var mf4Gain: KnobView!
    @IBOutlet weak var mf4Freq: KnobView!
    @IBOutlet weak var mf4Q:    KnobView!
    @IBOutlet weak var hf4Gain: KnobView!
    @IBOutlet weak var hf4Freq: KnobView!
    
    @IBOutlet weak var lf5Gain: KnobView!
    @IBOutlet weak var lf5Freq: KnobView!
    @IBOutlet weak var mf5Gain: KnobView!
    @IBOutlet weak var mf5Freq: KnobView!
    @IBOutlet weak var mf5Q:    KnobView!
    @IBOutlet weak var hf5Gain: KnobView!
    @IBOutlet weak var hf5Freq: KnobView!
    
    @IBOutlet weak var lf1GainLabel: UILabel!
    @IBOutlet weak var lf1FreqLabel: UILabel!
    @IBOutlet weak var mf1GainLabel: UILabel!
    @IBOutlet weak var mf1FreqLabel: UILabel!
    @IBOutlet weak var hf1GainLabel: UILabel!
    @IBOutlet weak var hf1FreqLabel: UILabel!
    
    @IBOutlet weak var lf2GainLabel: UILabel!
    @IBOutlet weak var lf2FreqLabel: UILabel!
    @IBOutlet weak var mf2GainLabel: UILabel!
    @IBOutlet weak var mf2FreqLabel: UILabel!
    @IBOutlet weak var hf2GainLabel: UILabel!
    @IBOutlet weak var hf2FreqLabel: UILabel!
    
    @IBOutlet weak var lf3GainLabel: UILabel!
    @IBOutlet weak var lf3FreqLabel: UILabel!
    @IBOutlet weak var mf3GainLabel: UILabel!
    @IBOutlet weak var mf3FreqLabel: UILabel!
    @IBOutlet weak var hf3GainLabel: UILabel!
    @IBOutlet weak var hf3FreqLabel: UILabel!

    @IBOutlet weak var lf4GainLabel: UILabel!
    @IBOutlet weak var lf4FreqLabel: UILabel!
    @IBOutlet weak var mf4GainLabel: UILabel!
    @IBOutlet weak var mf4FreqLabel: UILabel!
    @IBOutlet weak var hf4GainLabel: UILabel!
    @IBOutlet weak var hf4FreqLabel: UILabel!
    
    @IBOutlet weak var lf5GainLabel: UILabel!
    @IBOutlet weak var lf5FreqLabel: UILabel!
    @IBOutlet weak var mf5GainLabel: UILabel!
    @IBOutlet weak var mf5FreqLabel: UILabel!
    @IBOutlet weak var hf5GainLabel: UILabel!
    @IBOutlet weak var hf5FreqLabel: UILabel!

    var audioMixer : AudioMixerSkeleton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lf1Gain.delegate = self
        lf1Freq.delegate = self
        mf1Gain.delegate = self
        mf1Freq.delegate = self
        mf1Q.delegate = self
        hf1Gain.delegate = self
        hf1Freq.delegate = self
        
        lf2Gain.delegate = self
        lf2Freq.delegate = self
        mf2Gain.delegate = self
        mf2Freq.delegate = self
        mf2Q.delegate = self
        hf2Gain.delegate = self
        hf2Freq.delegate = self
        
        lf3Gain.delegate = self
        lf3Freq.delegate = self
        mf3Gain.delegate = self
        mf3Freq.delegate = self
        mf3Q.delegate = self
        hf3Gain.delegate = self
        hf3Freq.delegate = self
    
        lf4Gain.delegate = self
        lf4Freq.delegate = self
        mf4Gain.delegate = self
        mf4Freq.delegate = self
        mf4Q.delegate = self
        hf4Gain.delegate = self
        hf4Freq.delegate = self
        
        lf5Gain.delegate = self
        lf5Freq.delegate = self
        mf5Gain.delegate = self
        mf5Freq.delegate = self
        mf5Q.delegate = self
        hf5Gain.delegate = self
        hf5Freq.delegate = self
        
        
        audioMixer = AudioMixerSkeleton.sharedInstance
        
        // Do any additional setup after loading the view.
    }
}


//*****************************************************************
// MARK: - 🎛 Knob Delegate
//*****************************************************************

extension EQViewController: KnobDelegate {
    
    func updateKnobValue(_ value: Double, tag: Int) {
        
        let returnValue = audioMixer.drumEQ(tag, value)
        
        print(tag)
        print(value)
        
        switch(tag){
            
            //TRACK 1 CONTROLS
        case 0:
            lf1GainLabel.text = "\(Int(returnValue))dB"
        case 1:
            lf1FreqLabel.text = "\(Int(returnValue))Hz"
        case 2:
            mf1GainLabel.text = "\(Int(returnValue))dB"
        case 3:
            mf1FreqLabel.text = "\(Int(returnValue))Hz"
        case 5:
            hf1GainLabel.text = "\(Int(returnValue))dB"
        case 6:
            hf1FreqLabel.text = "\(Int(returnValue))Hz"
            
            //TRACK 2 CONTROLS
        case 10:
            lf2GainLabel.text = "\(Int(returnValue))dB"
        case 11:
            lf2FreqLabel.text = "\(Int(returnValue))Hz"
        case 12:
            mf2GainLabel.text = "\(Int(returnValue))dB"
        case 13:
            mf2FreqLabel.text = "\(Int(returnValue))Hz"
        case 15:
            hf2GainLabel.text = "\(Int(returnValue))dB"
        case 16:
            hf2FreqLabel.text = "\(Int(returnValue))Hz"
            
            //TRACK 3 CONTROLS
        case 20:
            lf3GainLabel.text = "\(Int(returnValue))dB"
        case 21:
            lf3FreqLabel.text = "\(Int(returnValue))Hz"
        case 22:
            mf3GainLabel.text = "\(Int(returnValue))dB"
        case 23:
            mf3FreqLabel.text = "\(Int(returnValue))Hz"
        case 25:
            hf3GainLabel.text = "\(Int(returnValue))dB"
        case 26:
            hf3FreqLabel.text = "\(Int(returnValue))Hz"
            
            //TRACK 4 CONTROLS
        case 30:
            lf4GainLabel.text = "\(Int(returnValue))dB"
        case 31:
            lf4FreqLabel.text = "\(Int(returnValue))Hz"
        case 32:
            mf4GainLabel.text = "\(Int(returnValue))dB"
        case 33:
            mf4FreqLabel.text = "\(Int(returnValue))Hz"
        case 35:
            hf4GainLabel.text = "\(Int(returnValue))dB"
        case 36:
            hf4FreqLabel.text = "\(Int(returnValue))Hz"
            
            //TRACK 5 CONTROLS
        case 40:
            lf5GainLabel.text = "\(Int(returnValue))dB"
        case 41:
            lf5FreqLabel.text = "\(Int(returnValue))Hz"
        case 42:
            mf5GainLabel.text = "\(Int(returnValue))dB"
        case 43:
            mf5FreqLabel.text = "\(Int(returnValue))Hz"
        case 45:
            hf5GainLabel.text = "\(Int(returnValue))dB"
        case 46:
            hf5FreqLabel.text = "\(Int(returnValue))Hz"
        default:
            break
            
        }
    }
}
