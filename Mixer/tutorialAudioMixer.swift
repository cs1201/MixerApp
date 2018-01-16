//
//  tutorialAudioMixer.swift
//  Mixer
//
//  Created by Y1480077 on 29/12/2017.
//  Copyright © 2017 Y1480077. All rights reserved.
//
// AudioMixer for tuorial view. Contains skimmed down version of main mixer.

import AudioKit

open class tutorialAudioMixer: AKNode {
    
    static let sharedInstance = tutorialAudioMixer()
    //Single track and audio File
    var demoTrack: AKAudioPlayer
    var demoFile: AKAudioFile
    
    private var demo_Init = 0.5
    private var mute_On = false
    private var comp: AKCompressor
    private var lp: AKLowShelfFilter
    private var bp: AKPeakingParametricEqualizerFilter
    private var hp: AKHighShelfFilter
    private var reverb: AKReverb
    private var meter: AKAmplitudeTracker
    
    private override init() {
        
        demoFile = try! AKAudioFile(readFileName: "jazz5.wav", baseDir: .resources)
        demoTrack = try! AKAudioPlayer(file: demoFile)
        
        demoTrack.volume = demo_Init
        demoTrack.looping = true
        
        //Signal Routing
        lp = AKLowShelfFilter(demoTrack)
        bp = AKPeakingParametricEqualizerFilter(lp)
        hp = AKHighShelfFilter(bp)
        comp = AKCompressor(hp)
        reverb = AKReverb(comp)
        reverb.dryWetMix = 0.0
        
        meter = AKAmplitudeTracker(reverb)
        //Set audio ouput
        AudioKit.output = meter
        //Start audio kit and filters
        AudioKit.start()
        lp.start()
        bp.start()
        hp.start()
        
        super.init()

        demoTrack.play()
    }
    //Adjust Volume
    open func volume(_ vol: Double){
        demoTrack.volume = vol
    }
    //Send volume to meter
    open func getVolume() -> Double{
        return meter.amplitude * 2
    }
    //Adjust pan
    open func pan(_ pan: Double){
        demoTrack.pan = pan
    }
    //Mute track
    open func mute(_ mute: Bool){
        
        if mute == mute_On{
            demoTrack.volume = 0
        }
        else{
            demoTrack.volume = demo_Init
        }
        mute_On = !mute_On
    }
    //EQ CONTROLS
    open func EQ(_ select: Int, _ value: Double) ->Double{
        switch(select){
        case 0:
            let gain = (24*value) - 12
            lp.gain = gain
            return gain
        case 1:
            let freq = (160 * value) + 40
            lp.cutoffFrequency = freq
            return freq
        case 2:
            let gain = (24*value) - 12
            bp.gain = gain
            return gain
        case 3:
            let freq = (4800*value) + 200
            bp.centerFrequency = freq
            return freq
        case 4:
            let q = (20.9*value) + 0.1
            bp.q = q
            return q
        case 5:
            let gain = (24*value) - 12
            hp.gain = gain
            return gain
        case 6:
            let freq = (8000*value) + 10000
            hp.cutoffFrequency = freq
            return freq
        default:
            break
        }        
        return 0
    }
    
    //COMPRESSOR CONTROLS
    open func compressor(_ controlSelect: Int, _ value: Double){
        
        switch(controlSelect){
        //CHANNEL 1
        case 0:
            let thresh = (60*value) - 40
            comp.threshold = thresh
        case 1:
            let amount = (39.9*value) + 0.1
            comp.headRoom = amount
        case 2:
            let attack = (0.1999*value) + 0.0001
            comp.attackTime = attack
        case 3:
            let release = (2.99*value) + 0.01
            comp.releaseTime = release
        case 4:
            let masterGain = (80*value) - 40
            comp.masterGain = masterGain
        default:
            break
        }
    }
    
    open func compOn(_ on: Bool){
        if on {
            comp.start()
        }
        else {
            comp.stop()
        }
    }
    
    open func compMeter() -> Float{
        return Float(comp.compressionAmount)
    }
    
    open func reverb(_ value: Double){
        reverb.dryWetMix = value
    }
    
    //Stop AudioKit when tutorial complete
    open func stop(){
        
        AudioKit.stop()
    }
    
}
