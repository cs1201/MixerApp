//
//  ViewController.swift
//  Mixer
//
//  Adapted from code originally created
//  by Nicholas Arner on 5/2/16. Edited by Andy Hunt 25/8/17.
//  Copyright © 2017 Y1480077
//


import UIKit
import AudioKit

 class ViewController: UIViewController {
    
    //PAN CONTROLS
    @IBOutlet var track1_Pan: UISlider!
    @IBOutlet var track2_Pan: UISlider!
    @IBOutlet var track3_Pan: UISlider!
    @IBOutlet var track4_Pan: UISlider!
    @IBOutlet var track5_Pan: UISlider!

    //MASTER BUS
    @IBOutlet var masterVolumeSlider: UISlider!

    //FX BUS LEVELS
    @IBOutlet weak var reverb1Slider: verticalFader!
    @IBOutlet weak var reverb2Slider: verticalFader!
    @IBOutlet weak var delaySlider: verticalFader!
    @IBOutlet weak var chorusSlider: verticalFader!
    
    //TRANSPORT CONTROLS
    @IBOutlet weak var playhead: horizontalFader!
    @IBOutlet weak var playheadLabel: UILabel!
    @IBOutlet weak var playPause: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    
    //INITIAL VALUES
    var percentVolume = 0
    var reverbAMT = 0
    var track1_MuteToggle = false
    var track2_MuteToggle = false
    var track3_MuteToggle = false
    var track4_MuteToggle = false
    var track5_MuteToggle = false
    var track1_SoloToggle = false
    var track2_SoloToggle = false
    var track3_SoloToggle = false
    var track4_SoloToggle = false
    var track5_SoloToggle = false
    var masterMuteToggle = false
    var playToggle = false
    var loopToggle = false
    var meterTimer = Timer()
    var plotGain: Float!

    //METERS
    @IBOutlet weak var meterMaster: verticalMeter!
    @IBOutlet weak var track1_Meter: verticalMeter!
    @IBOutlet weak var track2_Meter: verticalMeter!
    @IBOutlet weak var track3_Meter: verticalMeter!
    @IBOutlet weak var track4_Meter: verticalMeter!
    @IBOutlet weak var track5_Meter: verticalMeter!
    
    //EDIT VIEWS
    @IBOutlet weak var EQView: UIView!
    @IBOutlet weak var CompView: UIView!
    @IBOutlet weak var FXSendsView: UIView!
    
    //UTILITY VIEWS
    @IBOutlet weak var FXEditView: UIView!
    @IBOutlet weak var SongSelectView: UIView!
    @IBOutlet weak var MasterView: UIView!
    
    @IBOutlet weak var outputPlot: EZAudioPlot!

    

    
    
    // Create a global variable to link to the Audio Mixer class
    
    var audioMixer: AudioMixerSkeleton!
    
    override func viewDidLoad() {  // This is run just once at the start
        super.viewDidLoad()
        

        
        meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.meterUpdate)), userInfo: nil, repeats: true)
        
        //plotGain = 3.0
        
        FXEditView.frame.size.width = 400
        SongSelectView.frame.size.width = 400
        MasterView.frame.size.width = 400
        
        // Here, we create an instance of our AudioMixer class
        audioMixer = AudioMixerSkeleton.sharedInstance
        
        setupPlot(false)
        //setupPlotZoom()
    }
    
    
    func setupPlot(_ zoom: Bool) {
        
        let plot = AKNodeOutputPlot(audioMixer, frame: outputPlot.bounds)
        plot.plotType = .rolling
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.shouldCenterYAxis = true
        plot.backgroundColor = UIColor.clear
        plot.color = UIColor.darkGray
        plot.gain = 3
        plot.layer.masksToBounds = true
        outputPlot.addSubview(plot)
    }
    

//*****************************************************************
// MARK: - TRACK VOLUMES
//*****************************************************************
    
    @IBAction func track1_Volume(_ sender: UISlider) {
        audioMixer.settrack1_Volume(sender.value)
    }
    @IBAction func track2_Volume(_ sender: UISlider) {
        audioMixer.settrack2_Volume(sender.value)
    }
    @IBAction func track3_Volume(_ sender: UISlider) {
        audioMixer.settrack3_Volume(sender.value)
    }
    @IBAction func track4_Volume(_ sender: UISlider) {
        audioMixer.settrack4_Volume(sender.value)
    }
    @IBAction func track5_Volume(_ sender: UISlider) {
        audioMixer.settrack5_Volume(sender.value)
    }

//*****************************************************************
// MARK: - MASTER VOLUME
//*****************************************************************
    
    @IBAction func masterVolumeSlider(_ sender: UISlider) {
        audioMixer.setMasterVolume(masterVolumeSlider.value)
        percentVolume = Int(masterVolumeSlider.value * 100)
        
        print(sender.value)
    }
    
//*****************************************************************
// MARK: - FX BUS Levels
//*****************************************************************
    
    @IBAction func reverb1Slider(_ sender: verticalFader) {
        audioMixer.FXBusLevel(0, sender.value)
    }
    @IBAction func reverb2Slider(_ sender: verticalFader) {
        audioMixer.FXBusLevel(1, sender.value)
    }
    @IBAction func delaySlider(_ sender: verticalFader) {
        audioMixer.FXBusLevel(2, sender.value)
    }
    @IBAction func chorusSlider(_ sender: verticalFader) {
        audioMixer.FXBusLevel(3, sender.value)
    }
    

    
//*****************************************************************
// MARK: - PAN CONTROLS
//*****************************************************************
    
    @IBAction func track1_Pan(_ sender: UISlider) {
        audioMixer.settrack1_Pan(sender.value)
    }
    @IBAction func track2_Pan(_ sender: UISlider) {
        audioMixer.settrack2_Pan(sender.value)
    }
    @IBAction func track3_Pan(_ sender: UISlider) {
        audioMixer.settrack3_Pan(sender.value)
    }
    @IBAction func track4_Pan(_ sender: UISlider) {
        audioMixer.settrack4_Pan(sender.value)
    }
    @IBAction func track5_Pan(_ sender: UISlider) {
        audioMixer.settrack5_Pan(sender.value)
    }
    
    
//*****************************************************************
// MARK: - MUTE BUTTONS
//*****************************************************************
    
    @IBAction func track1_Mute(_ sender: muteButton) {
        //Toggles button to check previous state
        if track1_MuteToggle == sender.isSelected {
            audioMixer.settrack1_Mute(false)
            track1_MuteToggle = true
        }
        else {
            audioMixer.settrack1_Mute(true)
            track1_MuteToggle = false
        }
    }
    
    @IBAction func track2_Mute(_ sender: muteButton) {
        //Toggles button to check previous state
        if track2_MuteToggle == sender.isSelected {
            audioMixer.settrack2_Mute(false)
            track2_MuteToggle = true
        }
        else {
            audioMixer.settrack2_Mute(true)
            track2_MuteToggle = false
        }
    }
    
    @IBAction func track3_Mute(_ sender: muteButton) {
        //Toggles button to check previous state
        if track3_MuteToggle == sender.isSelected {
            audioMixer.settrack3_Mute(false)
            track3_MuteToggle = true
        }
        else {
            audioMixer.settrack3_Mute(true)
            track3_MuteToggle = false
        }
    }
    
    @IBAction func track4_Mute(_ sender: muteButton) {
        //Toggles button to check previous state
        if track4_MuteToggle == sender.isSelected {
            audioMixer.settrack4_Mute(false)
            track4_MuteToggle = true
        }
        else {
            audioMixer.settrack4_Mute(true)
            track4_MuteToggle = false
        }
    }
    
    @IBAction func track5_Mute(_ sender: UIButton) {
        if track5_MuteToggle == sender.isSelected {
            audioMixer.settrack5_Mute(false)
            track5_MuteToggle = true
        }
        else {
            audioMixer.settrack5_Mute(true)
            track5_MuteToggle = false
        }
    }
    
    @IBAction func masterMute(_ sender: muteButton) {
        if masterMuteToggle == sender.isSelected {
            audioMixer.setMasterMute(false)
            masterMuteToggle = true
        }
        else {
            audioMixer.setMasterMute(true)
            masterMuteToggle = false
        }
    }
    
    
//*****************************************************************
// MARK: - SOLO Buttons
//*****************************************************************
    
    //Action functions for SOLO BUTTONS
    @IBAction func track1_Solo(_ sender: soloButton) {
        if track1_SoloToggle == sender.isSelected{
            track1_SoloToggle = true
        }
        else{
            track1_SoloToggle = false
        }
        audioMixer.settrack1_Solo(track1_SoloToggle)
    }
    
    @IBAction func track2_Solo(_ sender: soloButton) {
        if track2_SoloToggle == sender.isSelected{
            track2_SoloToggle = true
        }
        else{
            track2_SoloToggle = false
        }
        audioMixer.settrack2_Solo(track2_SoloToggle)
    }
    
    @IBAction func track3_Solo(_ sender: soloButton) {
        if track3_SoloToggle == sender.isSelected{
            track3_SoloToggle = true
        }
        else{
            track3_SoloToggle = false
        }
        audioMixer.settrack3_Solo(track3_SoloToggle)
    }
    
    @IBAction func track4_Solo(_ sender: soloButton) {
        if track4_SoloToggle == sender.isSelected{
            track4_SoloToggle = true
        }
        else{
            track4_SoloToggle = false
        }
        audioMixer.settrack4_Solo(track4_SoloToggle)
    }
    
    @IBAction func track5_Solo(_ sender: soloButton) {
        if track5_SoloToggle == sender.isSelected{
            track5_SoloToggle = true
        }
        else{
            track5_SoloToggle = false
        }
        audioMixer.settrack5_Solo(track5_SoloToggle)
    }
    
    
    
//*****************************************************************
// MARK: - Update Level Meters
//*****************************************************************
    open func meterUpdate(){

        
        playheadLabel.text = printPlayheadLabel(Int(audioMixer.trackPosition()))+"/"+printPlayheadLabel(Int(audioMixer.trackLength()))
        
        if meterMaster != nil {
            
            playhead.value = Float(audioMixer.playhead())
            
            track1_Meter.value = Float(audioMixer.printAmplitude()[0])
            track2_Meter.value = Float(audioMixer.printAmplitude()[1])
            track3_Meter.value = Float(audioMixer.printAmplitude()[2])
            track4_Meter.value = Float(audioMixer.printAmplitude()[3])
            track5_Meter.value = Float(audioMixer.printAmplitude()[4])
            meterMaster.value = Float(audioMixer.printAmplitude()[5])
  
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
    
    @IBAction func rewindSong(_ sender: UIButton) {
        audioMixer.rewindSong()
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
            self.FXSendsView.alpha = 0.0
        case 1:
            self.EQView.alpha = 0.0
            self.CompView.alpha = 1.0
            self.FXSendsView.alpha = 0.0
        case 2:
            self.EQView.alpha = 0.0
            self.CompView.alpha = 0.0
            self.FXSendsView.alpha = 1.0
        default:
            break
        }
    }
    
    @IBAction func auxViewSelected(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex){
        case 0:
            self.FXEditView.alpha = 1.0
            self.SongSelectView.alpha = 0.0
            self.MasterView.alpha = 0.0
        case 1:
            self.FXEditView.alpha = 0.0
            self.SongSelectView.alpha  = 1.0
            self.MasterView.alpha = 0.0
        case 2:
            self.FXEditView.alpha = 0.0
            self.SongSelectView.alpha  = 0.0
            self.MasterView.alpha = 1.0
        default:
            break
        }
    }
    
    func printPlayheadLabel(_ totalSecs: Int) -> String{
        
        //let totalSec = Int(audioMixer.trackLength())
        //let totalPlayhead = Int(audioMixer.trackPosition())
        var outputString: String
        var stringMin: String
        var stringSec: String
        
        let secs = totalSecs % 60
        let totalMin = totalSecs  / 60
        let mins = totalMin % 60
        
        if secs < 10{
            stringSec = "0\(String(secs))"
        }else{
            stringSec = String(secs)
        }
        
        if mins < 10{
            stringMin = "0\(String(mins))"
        }else{
            stringMin = String(mins)
        }
        
        outputString = stringMin + ":" + stringSec
        
        return outputString
    }
}
