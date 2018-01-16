//
//  CompViewController.swift
//  Mixer
//
//  Created by Y1480077 on 24/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
//
//  Contains all knob controls for Compressor Section in specific container view. And handles label returns from AudioMixer.swift

import UIKit

class CompViewController: UIViewController {
    //ALL knobs, labels and on switches
    //COMP1
    @IBOutlet weak var comp1Thresh: CompKnobView!
    @IBOutlet weak var comp1Amount: CompKnobView!
    @IBOutlet weak var comp1Attack: CompKnobView!
    @IBOutlet weak var comp1Release: CompKnobView!
    @IBOutlet weak var comp1Gain: CompKnobView!
    
    @IBOutlet weak var comp1Meter: verticalMeter!
    @IBOutlet weak var comp1OnLabel: UILabel!
    //COMP2
    @IBOutlet weak var comp2Thresh: CompKnobView!
    @IBOutlet weak var comp2Amount: CompKnobView!
    @IBOutlet weak var comp2Attack: CompKnobView!
    @IBOutlet weak var comp2Release: CompKnobView!
    @IBOutlet weak var comp2Gain: CompKnobView!
    @IBOutlet weak var comp2Meter: verticalMeter!
    @IBOutlet weak var comp2OnLabel: UILabel!
    //COMP3
    @IBOutlet weak var comp3Thresh: CompKnobView!
    @IBOutlet weak var comp3Amount: CompKnobView!
    @IBOutlet weak var comp3Attack: CompKnobView!
    @IBOutlet weak var comp3Release: CompKnobView!
    @IBOutlet weak var comp3Gain: CompKnobView!
    @IBOutlet weak var comp3Meter: verticalMeter!
    @IBOutlet weak var comp3OnLabel: UILabel!
    //COMP4
    @IBOutlet weak var comp4Thresh: CompKnobView!
    @IBOutlet weak var comp4Amount: CompKnobView!
    @IBOutlet weak var comp4Attack: CompKnobView!
    @IBOutlet weak var comp4Release: CompKnobView!
    @IBOutlet weak var comp4Gain: CompKnobView!
    @IBOutlet weak var comp4Meter: verticalMeter!
    @IBOutlet weak var comp4OnLabel: UILabel!
    //COMP5
    @IBOutlet weak var comp5Thresh: CompKnobView!
    @IBOutlet weak var comp5Amount: CompKnobView!
    @IBOutlet weak var comp5Attack: CompKnobView!
    @IBOutlet weak var comp5Release: CompKnobView!
    @IBOutlet weak var comp5Gain: CompKnobView!
    @IBOutlet weak var comp5Meter: verticalMeter!
    @IBOutlet weak var comp5OnLabel: UILabel!

    var meterTimer = Timer() //Timer for compressor meters
    var audioMixer: AudioMixerSkeleton!

    override func viewDidLoad() {
        super.viewDidLoad()
         //Timer calls meter values every 0.1 seconds
         meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.meterUpdate)), userInfo: nil, repeats: true)
        //Instantiate all knob delegates
        setDelegates()
        
        //Access a pre-called singleton instance of the audio mixer
        audioMixer = AudioMixerSkeleton.sharedInstance

    }
    
    //*****************************************************************
    // MARK: - Delegate declaration
    //*****************************************************************
    
    func setDelegates(){
        comp1Thresh.delegate = self
        comp1Amount.delegate = self
        comp1Attack.delegate = self
        comp1Release.delegate = self
        comp1Gain.delegate = self
        
        comp2Thresh.delegate = self
        comp2Amount.delegate = self
        comp2Attack.delegate = self
        comp2Release.delegate = self
        comp2Gain.delegate = self
        
        comp3Thresh.delegate = self
        comp3Amount.delegate = self
        comp3Attack.delegate = self
        comp3Release.delegate = self
        comp3Gain.delegate = self
        
        comp4Thresh.delegate = self
        comp4Amount.delegate = self
        comp4Attack.delegate = self
        comp4Release.delegate = self
        comp4Gain.delegate = self
        
        comp5Thresh.delegate = self
        comp5Amount.delegate = self
        comp5Attack.delegate = self
        comp5Release.delegate = self
        comp5Gain.delegate = self
    }
    
    //*****************************************************************
    // MARK: - METERS - Called by timer every 0.1s to update all comp meters with current compression amount
    //*****************************************************************

    func meterUpdate(){
        //Update all meter values
        comp1Meter.value = audioMixer.comp1Meter()
        comp2Meter.value = audioMixer.comp2Meter()
        comp3Meter.value = audioMixer.comp3Meter()
        comp4Meter.value = audioMixer.comp4Meter()
        comp5Meter.value = audioMixer.comp5Meter()
    }
    
    //*****************************************************************
    // MARK: - On/Off Controls
    //*****************************************************************
    
    @IBAction func comp1OnOff(_ sender: UISwitch) {
        if sender.isOn{
            audioMixer.comp1On(true)
            comp1OnLabel.text = "On"
        }
        else{
            audioMixer.comp1On(false)
            comp1OnLabel.text = "Off"
        }
    }
    
    @IBAction func comp2OnOff(_ sender: UISwitch) {
        if sender.isOn{
            audioMixer.comp2On(true)
            comp2OnLabel.text = "On"
        }
        else{
            audioMixer.comp2On(false)
            comp2OnLabel.text = "Off"
        }
    }
    
    @IBAction func comp3OnOff(_ sender: UISwitch) {
        if sender.isOn{
            audioMixer.comp3On(true)
            comp3OnLabel.text = "On"
        }
        else{
            audioMixer.comp3On(false)
            comp3OnLabel.text = "Off"
        }
    }
    
    @IBAction func comp4OnOff(_ sender: UISwitch) {
        if sender.isOn{
            audioMixer.comp4On(true)
            comp4OnLabel.text = "On"
        }
        else{
            audioMixer.comp4On(false)
            comp4OnLabel.text = "Off"
        }
    }
    
    @IBAction func comp5OnOff(_ sender: UISwitch) {
        if sender.isOn{
            audioMixer.comp5On(true)
            comp5OnLabel.text = "On"
        }
        else{
            audioMixer.comp5On(false)
            comp5OnLabel.text = "Off"
        }
    }
}

//*****************************************************************
// MARK: - Knob Delegate
//*****************************************************************
extension CompViewController: CompKnobDelegate {
    //Send knob value to audioMixer
    func updateCompKnobValue(_ value: Double, tag: Int){
        audioMixer.compressor(tag, value)
    }
}
