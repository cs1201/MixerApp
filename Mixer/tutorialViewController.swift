//
//  tutorialViewController.swift
//  Mixer
//
//  Created by Y1480077 on 29/12/2017.
//  Copyright © 2017 NY1480077. All rights reserved.
//
// View for tutorial. Buttons used to step through tuorial revealing different mixer elements.

import UIKit

class tutorialViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tutorialText: UILabel!
    var stepCount = 1 //Tracks tutorial step
    @IBOutlet weak var toMixer: UIButton!
    
    @IBOutlet weak var pan: horizontalFader!
    @IBOutlet weak var meter: verticalMeter!
    @IBOutlet weak var muteButton: muteButton!
    @IBOutlet weak var soloButton: soloButton!
    
    @IBOutlet weak var hf: KnobView! //EQ Controls
    @IBOutlet weak var hg: KnobView!
    @IBOutlet weak var mq: KnobView!
    @IBOutlet weak var mf: KnobView!
    @IBOutlet weak var mg: KnobView!
    @IBOutlet weak var lf: KnobView!
    @IBOutlet weak var lg: KnobView!
    @IBOutlet weak var eqHide: UIImageView! //Hide panel for EQ section
    @IBOutlet weak var compThresh: CompKnobView! //Compressor Controls
    @IBOutlet weak var compAmount: CompKnobView!
    @IBOutlet weak var compAttack: CompKnobView!
    @IBOutlet weak var compRelease: CompKnobView!
    @IBOutlet weak var compMakeup: CompKnobView!
    @IBOutlet weak var compOnLabel: UILabel!
    @IBOutlet weak var compMeter: verticalMeter!
    @IBOutlet weak var compHide: UIImageView! //Hide panel for Compressor Section
    @IBOutlet weak var hfLabel: UILabel! // EQ Labels
    @IBOutlet weak var hgLabel: UILabel!
    @IBOutlet weak var mfLabel: UILabel!
    @IBOutlet weak var mgLabel: UILabel!
    @IBOutlet weak var lfLabel: UILabel!
    @IBOutlet weak var lgLabel: UILabel!
    
    @IBOutlet weak var reverbMix: verticalFader! //Reverb Controls
    @IBOutlet weak var fxHide: UIImageView! //Hide panel for reverb
    
    
    var audioMixer: tutorialAudioMixer!
    var timer = Timer() //Timer to update meters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lf.delegate = self //Knob delegates
        lg.delegate = self
        mq.delegate = self
        mf.delegate = self
        mg.delegate = self
        hf.delegate = self
        hg.delegate = self
        compThresh.delegate = self
        compAmount.delegate = self
        compAttack.delegate = self
        compRelease.delegate = self
        compMakeup.delegate = self

        //Access shared instance of tutorial audioMixer
        audioMixer = tutorialAudioMixer.sharedInstance
        //Time updates meters every 0.1s
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.meterUpdate)), userInfo: nil, repeats: true)
        //Intital tuotrial step instruction
        tutorialText.text = "Welcome to the mixing tutorial! Use the fader to adjust the volume of a track... The meter shows how much signal there is. Press next when you're done to learn something else"

        //Initialise hidden UI Elements for first tutorial step
        toMixer.isHidden = true
        pan.isHidden = true
        muteButton.isHidden = true
        soloButton.isHidden = true
        reverbMix.isHidden = true
    }
    //Button to step through Tutorial
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        //Update View based on step through tutorial
        switch(stepCount){
        case 1: //Pan
            tutorialText.text = "Now use the panning slider to adjust the track from left to right"
            nextButton.setTitle("OK, got it!", for: .normal)
            pan.isHidden = false
        case 2: //Mute&Solo
            tutorialText.text = "The mute button can be used to silence the track, whilst the solo button isolates it"
            nextButton.setTitle("Easy Pesy!, more please...", for: .normal)
            muteButton.isHidden = false
            soloButton.isHidden = false
        case 3: //EQ
            tutorialText.text = "The EQ section allows you to color the sound of an instrument to your liking. Try playing with the controls to change the sound..."
            nextButton.setTitle("Piece of cake... next!", for: .normal)
            eqHide.isHidden = true
        case 4: //Compression
            tutorialText.text = "Compression can be a bit trickier to understand, but essentialy lets you control the dynamics of the sound to make drums more punchy, or vocals more even... mess around and see what sounds you can come up with..."
            nextButton.setTitle("That's great, teach me more!", for: .normal)
            compHide.isHidden = true
        case 5: //FX
            reverbMix.isHidden = false
            nextButton.isHidden = true
            toMixer.isHidden = false
            tutorialText.text = "Effects can be a great way to alter sounds creatively, add some reverb with the fader to create an atmospheric texture... When you're ready, let's apply what we've learnt to the iMix Mixing Desk!"
            nextButton.setTitle("I'm ready for the real thing!", for: .normal)
            fxHide.isHidden = true
        default:
            break
        }
        stepCount = stepCount + 1 //Update step count
    }
    //Update Track Volume
    @IBAction func volume(_ sender: UISlider) {
        audioMixer.volume(Double(sender.value))
    }
    //Update Track Pan
    @IBAction func pan(_ sender: horizontalFader) {
        audioMixer.pan(Double(sender.value))
    }
    //Mute button
    @IBAction func mutePressed(_ sender: muteButton) {
        audioMixer.mute(sender.isSelected)
    }
    //Compressor On
    @IBAction func compOnOff(_ sender: UISwitch) {
        if sender.isOn{
            audioMixer.compOn(true)
            compOnLabel.text = "On"
        }
        else{
            audioMixer.compOn(false)
            compOnLabel.text = "Off"
        }
    }
    //Reverb Control
    @IBAction func reverbMix(_ sender: UISlider) {
        
        audioMixer.reverb(Double(sender.value))
    }
    //Update meter values
    func meterUpdate (){
        meter.value = Float(audioMixer.getVolume())
        compMeter.value = Float(audioMixer.compMeter())
    }
}
//EQ Knob Extentsion
extension tutorialViewController: KnobDelegate {
    func updateKnobValue(_ value: Double, tag: Int) {
        //Send value to audioMixer
        let returnValue = audioMixer.EQ(tag, value)
        //Update Lablels
        switch(tag){
        case 0:
            lgLabel.text = "\(Int(returnValue))dB"
        case 1:
            lfLabel.text = "\(Int(returnValue))Hz"
        case 2:
            mgLabel.text = "\(Int(returnValue))dB"
        case 3:
            mfLabel.text = "\(Int(returnValue))Hz"
        case 5:
            hgLabel.text = "\(Int(returnValue))dB"
        case 6:
            hfLabel.text = "\(Int(returnValue))Hz"
        default:
            break
        }
    }
}
//Compressor Knobs Extension
extension tutorialViewController: CompKnobDelegate {
    func updateCompKnobValue(_ value: Double, tag: Int) {
        //Send knob value to audioMixer
        audioMixer.compressor(tag, value)
    }
}
