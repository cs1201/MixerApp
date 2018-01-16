//
//  TrackViewController.swift
//  Mixer
//
//  Created by Y1480077 on 27/12/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// View contains buttons to allow for song selection

import Foundation
import UIKit

class TrackViewController: UIViewController {
    
    var audioMixer: AudioMixerSkeleton!

    
    @IBOutlet weak var trackSelect: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //Access shared instance of audoMixer
        audioMixer = AudioMixerSkeleton.sharedInstance
    }
    
    @IBAction func typeSelected(_ sender: UIButton) {
        //Send song selection tag to audoMixer
       audioMixer.typeSelect(sender.tag)
    }
}
