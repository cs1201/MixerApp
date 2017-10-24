//
//  ViewController.swift
//  Mixer
//
//  Created by Nicholas Arner on 5/2/16. Edited by Andy Hunt 25/8/17.
//  Copyright © 2017 University of York Department of Electronics
//

// N.B. To understand this code properly you might find it easier
// to look at the AudioMixer.swift file first (see LH pane)

import UIKit

class ViewController: UIViewController {
    
    // Create Outlets for the sliders and labels
    // The objects are all in Main.storyboard
    // Note the ! after UISlider which means
    // "I trust that the resource (slider) is actually there"
    

    @IBOutlet var drumsVolumeSlider: UISlider!
    @IBOutlet var bassVolumeSlider: UISlider!
    @IBOutlet var guitarVolumeSlider: UISlider!
    @IBOutlet var leadVolumeSlider: UISlider!
    @IBOutlet weak var drumPanLabel: UILabel!
    @IBOutlet weak var bassPanLabel: UILabel!
    @IBOutlet weak var guitarPanLabel: UILabel!
    @IBOutlet weak var leadPanLabel: UILabel!
    
    @IBOutlet var drumPan: UISlider!
    @IBOutlet var bassPan: UISlider!
    @IBOutlet var guitarPan: UISlider!
    @IBOutlet var leadPan: UISlider!


    @IBOutlet var masterVolumeSlider: UISlider!
    @IBOutlet weak var reverbSlider: UISlider!
    @IBOutlet weak var reverbLabel: UILabel!
    @IBOutlet weak var reverbType: UISegmentedControl!
    
    @IBOutlet weak var drumMute: muteButton!
    @IBOutlet weak var bassMute: muteButton!
    @IBOutlet weak var guitarMute: muteButton!
    @IBOutlet weak var leadMute: muteButton!
    
    @IBOutlet weak var drumSolo: soloButton!
    @IBOutlet weak var bassSolo: soloButton!
    @IBOutlet weak var guitarSolo: soloButton!
    @IBOutlet weak var leadSolo: soloButton!

    @IBOutlet weak var playhead: horizontalFader!
    
    @IBOutlet weak var playPause: UIButton!
    
    var percentVolume = 0
    var reverbAMT = 0
    var drumMuteToggle = false
    var bassMuteToggle = false
    var guitarMuteToggle = false
    var leadMuteToggle = false
    var drumSoloToggle = false
    var bassSoloToggle = false
    var guitarSoloToggle = false
    var leadSoloToggle = false
    var playToggle = false
    var meterTimer = Timer()

    
    @IBOutlet weak var meterMaster: verticalMeter!
    @IBOutlet var drumsVolumeLabel: UILabel!
    @IBOutlet var bassVolumeLabel: UILabel!
    @IBOutlet var guitarVolumeLabel: UILabel!
    @IBOutlet var leadLineVolumeLabel: UILabel!
    @IBOutlet var masterVolumeLabel: UILabel!
    
    @IBOutlet weak var EQView: UIView!
    @IBOutlet weak var CompView: UIView!
    
    
    
    // Create a global variable to link to the Audio Mixer class
    
    var audioMixer: AudioMixerSkeleton!
    
    override func viewDidLoad() {  // This is run just once at the start
        super.viewDidLoad()
        

        
        meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.meterUpdate)), userInfo: nil, repeats: true)
        
        
        
        // Here, we create an instance of our AudioMixer class
        audioMixer = AudioMixerSkeleton.sharedInstance
    }
    

//*****************************************************************
// MARK: - TRACK VOLUMES
//*****************************************************************
    
    @IBAction func setDrumsVolume(_ sender: UISlider) {
        audioMixer.setDrumsVolume(drumsVolumeSlider.value)
        drumsVolumeLabel.text = String(format: "%0.2f", audioMixer.drums.volume)
    }
    
    @IBAction func setBassVolume(_ sender: UISlider) {
        audioMixer.setBassVolume(bassVolumeSlider.value)
        bassVolumeLabel.text = String(format: "%0.2f", audioMixer.bass.volume)
    }
    
    @IBAction func setGuitarVolume(_ sender: UISlider) {
        audioMixer.setGuitarVolume(guitarVolumeSlider.value)
        guitarVolumeLabel.text = String(format: "%0.2f", audioMixer.guitar.volume)
    }
    
    @IBAction func setLeadVolume(_ sender: UISlider) {
        audioMixer.setLeadVolume(leadVolumeSlider.value)
        leadLineVolumeLabel.text = String(format: "%0.2f", audioMixer.lead.volume)
    }
    

    

//*****************************************************************
// MARK: - MASTER VOLUME
//*****************************************************************
    
    @IBAction func masterVolumeSlider(_ sender: UISlider) {
        audioMixer.setMasterVolume(masterVolumeSlider.value)
        percentVolume = Int(masterVolumeSlider.value * 100)
        masterVolumeLabel.text = "Volume: \(percentVolume)%"
        
        print(sender.value)
    }
    
    
//*****************************************************************
// MARK: - REVERB CONTROLS
//*****************************************************************
    @IBAction func reverbSlider(_ sender: UISlider) {
        audioMixer.setReverbLevel(reverbSlider.value)
        reverbAMT = Int(reverbSlider.value * 100)
        reverbLabel.text = "Reverb: \(reverbAMT)%"
    }
    
    
    @IBAction func reverbType(_ sender: UISegmentedControl) {
        audioMixer.setReverbType(reverbType.selectedSegmentIndex)
    }
    
//*****************************************************************
// MARK: - PAN CONTROLS
//*****************************************************************
    
    @IBAction func drumPan(_ sender: UISlider) {
        audioMixer.setDrumsPan(drumPan.value)
    }
    @IBAction func bassPan(_ sender: UISlider) {
        audioMixer.setBassPan(bassPan.value)
    }
    @IBAction func guitarPan(_ sender: UISlider) {
        audioMixer.setGuitarPan(guitarPan.value)
    }
    @IBAction func leadPan(_ sender: UISlider) {
        audioMixer.setLeadPan(leadPan.value)
    }
    
//*****************************************************************
// MARK: - MUTE BUTTONS
//*****************************************************************
    
    @IBAction func drumMute(_ sender: muteButton) {
        //Toggles button to check previous state
        if drumMuteToggle == sender.isSelected {
            audioMixer.setDrumMute(false)
            drumMuteToggle = true
        }
        else {
            audioMixer.setDrumMute(true)
            drumMuteToggle = false
        }
    }
    
    @IBAction func bassMute(_ sender: muteButton) {
        if bassMuteToggle == sender.isSelected {
            audioMixer.setBassMute(false)
            bassMuteToggle = true
        }
        else {
            audioMixer.setBassMute(true)
            bassMuteToggle = false
        }
    }
    
    @IBAction func guitarMute(_ sender: muteButton) {
        if guitarMuteToggle == sender.isSelected {
            audioMixer.setGuitarMute(false)
            guitarMuteToggle = true
        }
        else {
            audioMixer.setGuitarMute(true)
            guitarMuteToggle = false
        }
    }
    
    @IBAction func leadMute(_ sender: muteButton) {
        if leadMuteToggle == sender.isSelected {
            audioMixer.setLeadMute(false)
            leadMuteToggle = true
        }
        else {
            audioMixer.setLeadMute(true)
            leadMuteToggle = false
        }
    }
    
//*****************************************************************
// MARK: - SOLO Buttons
//*****************************************************************
    
    //Action functions for SOLO BUTTONS
    @IBAction func drumSolo(_ sender: soloButton) {
        if drumSoloToggle == sender.isSelected{
            drumSoloToggle = true
        }
        else{
            drumSoloToggle = false
        }
        audioMixer.setDrumSolo(drumSoloToggle)
    }
    
    @IBAction func bassSolo(_ sender: soloButton) {
        if bassSoloToggle == sender.isSelected{
            bassSoloToggle = true
        }
        else{
            bassSoloToggle = false
        }
        audioMixer.setBassSolo(bassSoloToggle)
    }
    
    @IBAction func guitarSolo(_ sender: soloButton) {
        if guitarSoloToggle == sender.isSelected{
            guitarSoloToggle = true
        }
        else{
            guitarSoloToggle = false
        }
        audioMixer.setGuitarSolo(guitarSoloToggle)
    }
    
    @IBAction func leadSolo(_ sender: soloButton) {
        if leadSoloToggle == sender.isSelected{
            leadSoloToggle = true
        }
        else{
            leadSoloToggle = false
        }
        audioMixer.setLeadSolo(leadSoloToggle)
    }
    
    
//*****************************************************************
// MARK: - Master Meter
//*****************************************************************
    open func meterUpdate(){
        if meterMaster != nil {
            
            meterMaster.value = audioMixer.printAmplitude()
            
            //comp1Meter.value = audioMixer.comp1Meter()
            //print(audioMixer.comp1Meter())
            
            playhead.value = Float(audioMixer.playhead())
            
            if meterMaster.value > 0.35 && meterMaster.value < 0.45{
                meterMaster.minimumTrackTintColor = UIColor.orange
            }
            else if meterMaster.value > 0.45{
                meterMaster.minimumTrackTintColor = UIColor.red
            }
            else{
                meterMaster.minimumTrackTintColor = UIColor.green
            }
      }
    }
    
    
//*****************************************************************
// MARK: - Pause/Play Button Action
//*****************************************************************
    @IBAction func playPause(_ sender: UIButton) {
        
        if playToggle == sender.isSelected{
            playToggle = true
            playPause.setImage(UIImage(named: "playIcon.png"), for: .normal)
        }
        else{
            playToggle = false
            playPause.setImage(UIImage(named: "pauseIcon.png"), for: .normal)
        }
        
        audioMixer.playPause(playToggle)
    }
    
    
    //*****************************************************************
    // MARK: - SWITCH SUB VIEWS. This 'cheat' method of changing alpha
    // rather than assiging and segue-ing child view controllers means
    // app doesn't have to keep track of and re-assign current values
    // when switching views. However this is more computationally
    // exhaustive as each view is always running - Just UI though    
    //*****************************************************************
    @IBAction func selectView(_ sender: UISegmentedControl) {
        
        let viewSelected = sender.selectedSegmentIndex
        
        switch(viewSelected){
        case 0:
            self.EQView.alpha = 1.0
            self.CompView.alpha = 0.0
        case 1:
            self.EQView.alpha = 0.0
            self.CompView.alpha = 1.0
        default:
            break
        }
    }
    

}


