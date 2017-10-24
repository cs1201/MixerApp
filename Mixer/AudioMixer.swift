//
//  AudioMixer.swift
//  Mixer
//
//  Created by Nicholas Arner on 5/2/16. Edited Andy Hunt 25/8/17
//  Copyright © 2017 University of York Department of Electronics
//

import Foundation
import AudioKit

// Declare a class that can be accessed 'publicly' (open) from the ViewController

open class AudioMixerSkeleton {
    
    static let sharedInstance = AudioMixerSkeleton()
    
    // Declare variables for 4 different audio players
    
    var drums: AKAudioPlayer
    private var drumsInit: Double
    private var bassInit: Double
    private var guitarInit: Double
    private var leadInit: Double
    private var drumMuteOn = false
    private var bassMuteOn = false
    private var guitarMuteOn = false
    private var leadMuteOn = false
    var bass: AKAudioPlayer
    var guitar: AKAudioPlayer
    var lead: AKAudioPlayer
    var volume: Double
    private var mixer: AKMixer
    private var reverb: AKReverb
    private var drumMuteToggle = true
    private var tracker: AKFrequencyTracker
    private var silence: AKBooster
    private var soloIdentifier = 0
    private var globalSolo = false
    
    private var lp1 : AKLowShelfFilter
    private var lp2 : AKLowShelfFilter
    private var lp3 : AKLowShelfFilter
    private var lp4 : AKLowShelfFilter
    private var lp5 : AKLowShelfFilter

    
    private var bp1 : AKPeakingParametricEqualizerFilter
    private var bp2 : AKPeakingParametricEqualizerFilter
    private var bp3 : AKPeakingParametricEqualizerFilter
    private var bp4 : AKPeakingParametricEqualizerFilter
    private var bp5 : AKPeakingParametricEqualizerFilter

    
    
    private var hp1: AKHighShelfFilter
    private var hp2: AKHighShelfFilter
    private var hp3: AKHighShelfFilter
    private var hp4: AKHighShelfFilter
    private var hp5: AKHighShelfFilter
    
    private var comp1: AKCompressor
    private var comp2: AKCompressor
    private var comp3: AKCompressor
    private var comp4: AKCompressor
    private var comp5: AKCompressor
    

    
    var meter: AKAmplitudeTracker

    
    private init() {
        
        // Load in the 4 audio samples stored in the Resource bank
        
        let drumFile = try! AKAudioFile(readFileName: "drumloop.wav", baseDir: .resources)
        let bassFile = try! AKAudioFile(readFileName: "bassloop.wav", baseDir: .resources)
        let guitarFile = try! AKAudioFile(readFileName: "guitarloop.wav", baseDir: .resources)
        let leadFile = try! AKAudioFile(readFileName: "leadloop.wav", baseDir: .resources)

        // Create audio players for each sound file
        drums = try! AKAudioPlayer(file: drumFile)
        bass = try! AKAudioPlayer(file: bassFile)
        guitar = try! AKAudioPlayer(file: guitarFile)
        lead = try! AKAudioPlayer(file: leadFile)

        // Set each track to loop
        drums.looping  = true // Uses the 'looping' property of AKAudioPlayer
        bass.looping   = true
        guitar.looping = true
        lead.looping   = true
        
        //Holding values to store last volume set by faders for return from mute or solo
        drumsInit = drums.volume
        bassInit = bass.volume
        guitarInit = guitar.volume
        leadInit = lead.volume
        

        //3-band filter sections
        //
        lp1 = AKLowShelfFilter(drums)
        lp2 = AKLowShelfFilter(bass)
        lp3 = AKLowShelfFilter(guitar)
        lp4 = AKLowShelfFilter(lead)
        lp5 = AKLowShelfFilter(lead)
        
        bp1 = AKPeakingParametricEqualizerFilter(lp1)
        bp2 = AKPeakingParametricEqualizerFilter(lp2)
        bp3 = AKPeakingParametricEqualizerFilter(lp3)
        bp4 = AKPeakingParametricEqualizerFilter(lp4)
        bp5 = AKPeakingParametricEqualizerFilter(lp5)

        
        hp1 = AKHighShelfFilter(bp1)
        hp2 = AKHighShelfFilter(bp2)
        hp3 = AKHighShelfFilter(bp3)
        hp4 = AKHighShelfFilter(bp4)
        hp5 = AKHighShelfFilter(bp5)
        
        comp1 = AKCompressor(hp1)
        comp2 = AKCompressor(hp2)
        comp3 = AKCompressor(hp3)
        comp4 = AKCompressor(hp4)
        comp5 = AKCompressor(hp5)
        
        
        
        
        mixer = AKMixer(comp1, comp2, comp3, comp4)
        reverb = AKReverb(mixer)
        meter = AKAmplitudeTracker(reverb)
        reverb.dryWetMix = 0.0
        volume = 0.5 //Initialise volume to 0
        mixer.volume = volume
        
        tracker = AKFrequencyTracker(reverb, hopSize: 200, peakCount: 2000)
        silence = AKBooster(tracker, gain: 0)

        // Connect the mixer's output to be AudioKit's output
        
        lp1.start()
        lp2.start()
        lp3.start()
        lp4.start()
        lp5.start()

        bp1.start()
        bp2.start()
        bp3.start()
        bp4.start()
        bp5.start()
        hp1.start()
        hp2.start()
        hp3.start()
        hp4.start()
        hp5.start()
        reverb.start()
        
        comp1.stop()
        comp2.stop()
        comp3.stop()
        comp4.stop()
        comp5.stop()
        
        AudioKit.output = meter
        AudioKit.start()   // start the AudioKit engine
    
    
        //Start playing each of the individual audio tracks
        drums.play()
        bass.play()
        guitar.play()
        lead.play()
    }
  
    // Here we declare functions that can be called from outside
    // this class, and which set the volume for each track.
    // The underscore (_) just means that when this function is
    // called, we can just use the variable; we don't need to
    // give it a named variable label
    
    @objc open func printAmplitude() -> Float{
        
        //print(meter.amplitude)
        
        return Float(meter.amplitude)
        
    }
    
    open func setDrumsVolume(_ drumsVolume: Float){
        
        if drumMuteOn || (globalSolo && soloIdentifier != 1){
            drums.volume = 0.0
        }
        else{
            drums.volume = Double(drumsVolume)
        }
        drumsInit = Double(drumsVolume)
    }
    
    open func setBassVolume(_ bassVolume: Float){
      
        if bassMuteOn || (globalSolo && soloIdentifier != 2){
            bass.volume = 0.0
        }
        else{
            bass.volume = Double(bassVolume)
        }
        bassInit = Double(bassVolume)
    }
    
    open func setGuitarVolume(_ guitarVolume: Float){
        
        if guitarMuteOn || (globalSolo && soloIdentifier != 3){
            guitar.volume = 0.0
        }
        else{
            guitar.volume = Double(guitarVolume)
        }
        guitarInit = Double(guitarVolume)
    }
    
    open func setLeadVolume(_ leadVolume: Float){
        
        if leadMuteOn || (globalSolo && soloIdentifier != 4){
            lead.volume = 0.0
        }
        else{
            lead.volume = Double(leadVolume)
        }
        leadInit = Double(leadVolume)
        
    }
    
    open func setReverbLevel(_ reverbLevel: Float){
        reverb.dryWetMix = Double(reverbLevel)
    }
    
    open func setReverbType(_ reverbSelected: Int){
        if reverbSelected == 0 {
          reverb.loadFactoryPreset(.smallRoom)
        }
        else if reverbSelected == 1 {
            reverb.loadFactoryPreset(.largeHall)
        }
        else if reverbSelected == 2 {
            reverb.loadFactoryPreset(.cathedral)
        }
    }
    
    open func setMasterVolume(_ masterVolume: Float){
       //if mixer.isStarted{
        mixer.volume = Double(masterVolume)
        
        
    }
    
    open func setDrumsPan(_ drumsPan: Float){
        drums.pan = Double(drumsPan)
    }
    
    open func setBassPan(_ bassPan: Float){
        bass.pan = Double(bassPan)
    }
    
    open func setGuitarPan(_ guitarPan: Float){
        guitar.pan = Double(guitarPan)
    }
    
    open func setLeadPan(_ leadPan: Float){
        lead.pan = Double(leadPan)
    }
    
    open func setDrumMute(_ drumMute: Bool){
        
        //Set mute identifier
        drumMuteOn = !drumMute
        //Input from button either keeps volume as previous or sets to 0 whilst button selected
        if drumMute {
            drums.volume = drumsInit
        }else{
            drums.volume = 0
        }
    }
    
    open func setBassMute(_ bassMute: Bool){
        
        bassMuteOn = !bassMute
        
        if bassMute {
            bass.volume = bassInit
        }else{
            bass.volume = 0
        }
    }
    
    open func setGuitarMute(_ guitarMute: Bool){
        
        guitarMuteOn = !guitarMute
        
        if guitarMute {
            guitar.volume = guitarInit
        }else{
            guitar.volume = 0
        }
    }
    
    open func setLeadMute(_ leadMute: Bool){
        
        leadMuteOn = !leadMute
        
        if leadMute {
            lead.volume = leadInit
        }else{
            lead.volume = 0
        }
    }
    
    open func setDrumSolo(_ drumSolo: Bool){
        
        
        if drumSolo{
            bass.volume = 0.0
            guitar.volume = 0.0
            lead.volume = 0.0
            
            globalSolo = true
            soloIdentifier = 1
        }else{
            bass.volume = bassInit
            guitar.volume = guitarInit
            lead.volume = leadInit
            
            globalSolo = false
            soloIdentifier = 0
            
        }
    }
    
    open func setBassSolo(_ bassSolo: Bool){
        
        
        if bassSolo{
            drums.volume = 0.0
            guitar.volume = 0.0
            lead.volume = 0.0
            
            globalSolo = true
            soloIdentifier = 2
            
        }else{
            drums.volume = drumsInit
            guitar.volume = guitarInit
            lead.volume = leadInit
            
            globalSolo = false
            soloIdentifier = 0

        }
    }
    
    open func setGuitarSolo(_ guitarSolo: Bool){
        
        
        if guitarSolo{
            drums.volume = 0.0
            bass.volume = 0.0
            lead.volume = 0.0
            
            globalSolo = true
            soloIdentifier = 3
            
        }else{
            drums.volume = drumsInit
            bass.volume = bassInit
            lead.volume = leadInit
            
            globalSolo = false
            soloIdentifier = 0
            
        }
    }
    
    open func setLeadSolo(_ leadSolo: Bool){
        
        
        if leadSolo{
            drums.volume = 0.0
            bass.volume = 0.0
            guitar.volume = 0.0
            
            globalSolo = true
            soloIdentifier = 4
            
        }else{
            drums.volume = drumsInit
            bass.volume = bassInit
            guitar.volume = guitarInit
            
            globalSolo = false
            soloIdentifier = 0
        }
        
        print(soloIdentifier)
        print(globalSolo)
    }
    
    open func playPause(_ playSelect: Bool){
        if playSelect{
            drums.pause()
            bass.pause()
            guitar.pause()
            lead.pause()
        }
        else{
            drums.resume()
            bass.resume()
            guitar.resume()
            lead.resume()
        }
    }
    
    open func drumEQ(_ controlSelect: Int, _ value: Double) -> Double{
        
        
        switch(controlSelect){
            
            //CHANNEL 1 EQ
        case 0:
            let gain = (24*value) - 12
            lp1.gain = gain
            return gain
        case 1:
            let freq = (160 * value) + 40
            lp1.cutoffFrequency = freq
            return freq
        case 2:
            let gain = (24*value) - 12
            bp1.gain = gain
            return gain
        case 3:
            let freq = (4800*value) + 200
            bp1.centerFrequency = freq
            return freq
        case 4:
            let q = (20.9*value) + 0.1
            bp1.q = q
            return q
        case 5:
            let gain = (24*value) - 12
            hp1.gain = gain
            return gain
        case 6:
            let freq = (8000*value) + 10000
            hp1.cutoffFrequency = freq
            return freq
            
            //CHANNEL 2 EQ
        case 10:
            let gain = (24*value) - 12
            lp2.gain = gain
            return gain
        case 11:
            let freq = (160 * value) + 40
            lp2.cutoffFrequency = freq
            return freq
        case 12:
            let gain = (24*value) - 12
            bp2.gain = gain
            return gain
        case 13:
            let freq = (4800*value) + 200
            bp2.centerFrequency = freq
            return freq
        case 14:
            let q = (20.9*value) + 0.1
            bp2.q = q
            return q
        case 15:
            let gain = (24*value) - 12
            hp2.gain = gain
            return gain
        case 16:
            let freq = (8000*value) + 10000
            hp2.cutoffFrequency = freq
            return freq
            
            
            //CHANNEL 3 EQ
        case 20:
            let gain = (24*value) - 12
            lp3.gain = gain
            return gain
        case 21:
            let freq = (160 * value) + 40
            lp3.cutoffFrequency = freq
            return freq
        case 22:
            let gain = (24*value) - 12
            bp3.gain = gain
            return gain
        case 23:
            let freq = (4800*value) + 200
            bp3.centerFrequency = freq
            return freq
        case 24:
            let q = (20.9*value) + 0.1
            bp3.q = q
            return q
        case 25:
            let gain = (24*value) - 12
            hp3.gain = gain
            return gain
        case 26:
            let freq = (8000*value) + 10000
            hp3.cutoffFrequency = freq
            return freq
            
            
            //CHANNEL 4 EQ
        case 30:
            let gain = (24*value) - 12
            lp4.gain = gain
            return gain
        case 31:
            let freq = (160 * value) + 40
            lp4.cutoffFrequency = freq
            return freq
        case 32:
            let gain = (24*value) - 12
            bp4.gain = gain
            return gain
        case 33:
            let freq = (4800*value) + 200
            bp4.centerFrequency = freq
            return freq
        case 34:
            let q = (20.9*value) + 0.1
            bp4.q = q
            return q
        case 35:
            let gain = (24*value) - 12
            hp4.gain = gain
            return gain
        case 36:
            let freq = (8000*value) + 10000
            hp4.cutoffFrequency = freq
            return freq
            
            
            //CHANNEL 5 EQ
        case 40:
            let gain = (24*value) - 12
            lp5.gain = gain
            return gain
        case 41:
            let freq = (160 * value) + 40
            lp5.cutoffFrequency = freq
            return freq
        case 42:
            let gain = (24*value) - 12
            bp5.gain = gain
            return gain
        case 43:
            let freq = (4800*value) + 200
            bp5.centerFrequency = freq
            return freq
        case 44:
            let q = (20.9*value) + 0.1
            bp5.q = q
            return q
        case 45:
            let gain = (24*value) - 12
            hp5.gain = gain
            return gain
        case 46:
            let freq = (8000*value) + 10000
            hp5.cutoffFrequency = freq
            return freq
        default: break
            
        }
        return 0.0
    }
    
    open func playhead() -> Double {

        let duration = drums.duration
        let playhead = drums.playhead
        
        return playhead/duration
        
    }
    
    
    
    open func compressor(_ controlSelect: Int, _ value: Double){

        
        switch(controlSelect){
         //CHANNEL 1
        case 0:
            let thresh = (60*value) - 40
            comp1.threshold = thresh
        case 1:
            let amount = (39.9*value) + 0.1
            comp1.headRoom = amount
        case 2:
            let attack = (0.1999*value) + 0.0001
            comp1.attackTime = attack
        case 3:
            let release = (2.99*value) + 0.01
            comp1.releaseTime = release
        case 4:
            let masterGain = (80*value) - 40
            comp1.masterGain = masterGain
            
            //CHANNEL 2
        case 10:
            let thresh = (60*value) - 40
            comp2.threshold = thresh
        case 11:
            let amount = (39.9*value) + 0.1
            comp2.headRoom = amount
        case 12:
            let attack = (0.1999*value) + 0.0001
            comp2.attackTime = attack
        case 13:
            let release = (2.99*value) + 0.01
            comp2.releaseTime = release
        case 14:
            let masterGain = (80*value) - 40
            comp2.masterGain = masterGain
            
            //CHANNEL 3
        case 20:
            let thresh = (60*value) - 40
            comp3.threshold = thresh
        case 21:
            let amount = (39.9*value) + 0.1
            comp3.headRoom = amount
        case 22:
            let attack = (0.1999*value) + 0.0001
            comp3.attackTime = attack
        case 23:
            let release = (2.99*value) + 0.01
            comp3.releaseTime = release
        case 24:
            let masterGain = (80*value) - 40
            comp3.masterGain = masterGain
            
            //CHANNEL 4
        case 30:
            let thresh = (60*value) - 40
            comp4.threshold = thresh
        case 31:
            let amount = (39.9*value) + 0.1
            comp4.headRoom = amount
        case 32:
            let attack = (0.1999*value) + 0.0001
            comp4.attackTime = attack
        case 33:
            let release = (2.99*value) + 0.01
            comp4.releaseTime = release
        case 34:
            let masterGain = (80*value) - 40
            comp4.masterGain = masterGain
            
           //CHANNEL 5
        case 40:
            let thresh = (60*value) - 40
            comp5.threshold = thresh
        case 41:
            let amount = (39.9*value) + 0.1
            comp5.headRoom = amount
        case 42:
            let attack = (0.1999*value) + 0.0001
            comp5.attackTime = attack
        case 43:
            let release = (2.99*value) + 0.01
            comp5.releaseTime = release
        case 44:
            let masterGain = (80*value) - 40
            comp5.masterGain = masterGain
        default:
            break
        }

        
    }
    
    open func comp1On(_ on: Bool){
        if on {
            comp1.start()
        }
        else {
            comp1.stop()
        }
    }
    
    open func comp2On(_ on: Bool){
        if on {
            comp2.start()
        }
        else {
            comp2.stop()
        }
    }
    
    open func comp3On(_ on: Bool){
        if on {
            comp3.start()
        }
        else {
            comp3.stop()
        }
    }
    
    open func comp4On(_ on: Bool){
        if on {
            comp4.start()
        }
        else {
            comp4.stop()
        }
    }
    
    open func comp5On(_ on: Bool){
        if on {
            comp5.start()
        }
        else {
            comp5.stop()
        }
    }
    
    open func comp1Meter() -> Float{
        return Float(comp1.compressionAmount)
    }
    open func comp2Meter() -> Float{
        return Float(comp2.compressionAmount)
    }
    open func comp3Meter() -> Float{
        return Float(comp3.compressionAmount)
    }
    open func comp4Meter() -> Float{
        return Float(comp4.compressionAmount)
    }
    open func comp5Meter() -> Float{
        return Float(comp5.compressionAmount)
    }
    
    
}//Closes audioMixer Class
