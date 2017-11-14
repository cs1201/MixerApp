//
//  FXEditViewController.swift
//  Mixer
//
//  Created by cs1201 on 26/10/2017.
//  Copyright © 2017 Nicholas Arner. All rights reserved.
//

import UIKit

class FXEditViewController: UIViewController {
    
    var audioMixer: AudioMixerSkeleton!
    
    @IBOutlet weak var delayTime: FXKnobView!
    @IBOutlet weak var delayFeedback: FXKnobView!
    @IBOutlet weak var delayCutoff: FXKnobView!
    
    @IBOutlet weak var reverb1Select: UISegmentedControl!
    @IBOutlet weak var reverb2Select: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        knobInit()
        
        //Access a pre-called singleton instance of the audio mixer
        audioMixer = AudioMixerSkeleton.sharedInstance
    }
    
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
    
    @IBAction func reverb1Select(_ sender: UISegmentedControl) {
        audioMixer.reverb1Select(sender.selectedSegmentIndex)
    }
    
    @IBAction func reverb2Select(_ sender: UISegmentedControl) {
        audioMixer.reverb2Select(sender.selectedSegmentIndex)
    }
    
    
    
    @IBAction func reverb1On(_ sender: UISwitch) {
        audioMixer.FXOn(0, sender.isOn)
    }
   
    @IBAction func reverb2On(_ sender: UISwitch) {
        audioMixer.FXOn(1, sender.isOn)
    }
    @IBAction func delayOn(_ sender: UISwitch) {
        audioMixer.FXOn(2, sender.isOn)
    }
    
    

}

//*****************************************************************
// MARK: - Knob Delegate
//*****************************************************************

extension FXEditViewController: FXKnobDelegate {
    
    func updateFXKnobValue(_ value: Double, tag: Int){
        audioMixer.FXKnobEdit(tag, value)
    }
}
