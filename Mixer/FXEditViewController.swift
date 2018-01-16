//
//  FXEditViewController.swift
//  Mixer
//
//  Created by Y1480077 on 26/10/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// VC to edit FX Units

import UIKit

class FXEditViewController: UIViewController {
    
    var audioMixer: AudioMixerSkeleton!
    
    //Outlets for all FX Controls
    @IBOutlet weak var delayTime: FXKnobView!
    @IBOutlet weak var delayFeedback: FXKnobView!
    @IBOutlet weak var delayCutoff: FXKnobView!
    @IBOutlet weak var reverb1Select: UISegmentedControl!
    @IBOutlet weak var reverb2Select: UISegmentedControl!
    @IBOutlet weak var pitchStepper: UIStepper!
    @IBOutlet weak var pitchLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setDelegates()
        
        knobInit()
        
        //Access a shared singleton instance of the audio mixer
        audioMixer = AudioMixerSkeleton.sharedInstance
    }
    //Initialise delay knobs to 0
    private func knobInit(){
        delayTime.value = 0.0
        delayFeedback.value = 0.0
        delayCutoff.value = 0.0
    }
    private func setDelegates(){
        delayTime.delegate = self
        delayFeedback.delegate = self
        delayCutoff.delegate = self
    }
    //Controls for Reverbs and pitch shift
    @IBAction func reverb1Select(_ sender: UISegmentedControl) {
        audioMixer.reverb1Select(sender.selectedSegmentIndex)
    }
    @IBAction func reverb2Select(_ sender: UISegmentedControl) {
        audioMixer.reverb2Select(sender.selectedSegmentIndex)
    }
    @IBAction func pitchStepper(_ sender: UIStepper) {
        audioMixer.pitchChange(sender.value)
        pitchLabel.text = String(sender.value)
    }
   //Toggles to turn FX On/Off
    @IBAction func reverb1On(_ sender: UISwitch) {
        audioMixer.FXOn(0, sender.isOn)
    }
    @IBAction func reverb2On(_ sender: UISwitch) {
        audioMixer.FXOn(1, sender.isOn)
    }
    @IBAction func delayOn(_ sender: UISwitch) {
        audioMixer.FXOn(2, sender.isOn)
    }
    @IBAction func pitchShiftOn(_ sender: UISwitch) {
        audioMixer.FXOn(3, sender.isOn)
    }
}

//*****************************************************************
// MARK: - Knob Delegate
//*****************************************************************
extension FXEditViewController: FXKnobDelegate {
    //Send delay knob values to audioMixer
    func updateFXKnobValue(_ value: Double, tag: Int){
        audioMixer.FXKnobEdit(tag, value)
    }
}
