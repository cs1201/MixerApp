//
//  masterViewController.swift
//  Mixer
//
//  Created by Y1480077 on 28/12/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// This View is a graphic equaliser to control 9 EQ bands over master output

import UIKit

class masterViewController: UIViewController {
    
    var audioMixer: AudioMixerSkeleton!
    //GEQ Faders
    @IBOutlet weak var geq1: verticalFader!
    @IBOutlet weak var geq2: verticalFader!
    @IBOutlet weak var geq3: verticalFader!
    @IBOutlet weak var geq4: verticalFader!
    @IBOutlet weak var geq5: verticalFader!
    @IBOutlet weak var geq6: verticalFader!
    @IBOutlet weak var geq7: verticalFader!
    @IBOutlet weak var geq8: verticalFader!
    @IBOutlet weak var geq9: verticalFader!
    @IBOutlet weak var geq10: verticalFader!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //Access shared instance of audioMixer
        audioMixer = AudioMixerSkeleton.sharedInstance
        
    }
    //RESET GEQ
    @IBAction func geqReset(_ sender: UIButton) {
        geq1.value = 0.5
        geq2.value = 0.5
        geq3.value = 0.5
        geq4.value = 0.5
        geq5.value = 0.5
        geq6.value = 0.5
        geq7.value = 0.5
        geq8.value = 0.5
        geq9.value = 0.5
        geq10.value = 0.5
        
        //Step through and all fader tags and call audioMixer function to reset filters
        var i = 0
        while i <= 9 {
            audioMixer.graphicEQ(i, 0.5)
            i = i + 1
        }
    }
    //ADJUST GEQ
    @IBAction func geqSliderChanged(_ sender: UISlider) {
        //Send fader value to audioMixer
        audioMixer.graphicEQ(sender.tag, Double(sender.value))
    }
}
