//
//  AudioMixer.swift
//  Mixer
//
//  Created by Nicholas Arner on 5/2/16. Edited Andy Hunt 25/8/17
//  Copyright © 2017 University of York Department of Electronics
//
//  This class contains all audio processing for the i-Mix app. All UI controls adjust 
//  parameters within this class

import Foundation
import AudioKit

open class AudioMixerSkeleton: AKNode {
    //GLOBAL VARIABLE FOR CLASS ALLOWS SHARED INSTANCE
    static let sharedInstance = AudioMixerSkeleton()
    
    //AUDIO TRACKS
    var track1_: AKAudioPlayer
    var track2_: AKAudioPlayer
    var track3_: AKAudioPlayer
    var track4_: AKAudioPlayer
    var track5_: AKAudioPlayer
    //AUDIO FILES
    var rock1: AKAudioFile
    var rock2: AKAudioFile
    var rock3: AKAudioFile
    var rock4: AKAudioFile
    var rock5: AKAudioFile
    var jazz1: AKAudioFile
    var jazz2: AKAudioFile
    var jazz3: AKAudioFile
    var jazz4: AKAudioFile
    var jazz5: AKAudioFile
    var pop1: AKAudioFile
    var pop2: AKAudioFile
    var pop3: AKAudioFile
    var pop4: AKAudioFile
    var pop5: AKAudioFile
    var metal1: AKAudioFile
    var metal2: AKAudioFile
    var metal3: AKAudioFile
    var metal4: AKAudioFile
    var metal5: AKAudioFile
    var choral1: AKAudioFile
    var choral2: AKAudioFile
    var choral3: AKAudioFile
    var choral4: AKAudioFile
    var choral5: AKAudioFile
    var electro1: AKAudioFile
    var electro2: AKAudioFile
    var electro3: AKAudioFile
    var electro4: AKAudioFile
    var electro5: AKAudioFile
    //VOLUME & MUTE INITIALISERS
    private var track1_Init: Double
    private var track2_Init: Double
    private var track3_Init: Double
    private var track4_Init: Double
    private var track5_Init: Double
    private var masterInit: Double
    private var track1_MuteOn = false
    private var track2_MuteOn = false
    private var track3_MuteOn = false
    private var track4_MuteOn = false
    private var track5_MuteOn = false
    private var masterMuteOn = false
    //MASTER MIXER
    private var mixer: AKMixer
    //FX
    private var reverb1: AKReverb
    private var reverb2: AKReverb
    private var delay: AKDelay
    private var pitchShift: AKPitchShifter
    //SOLO INITIALISERS
    private var soloIdentifier = 0
    private var globalSolo = false
    //LOW FILTERS
    private var lp1 : AKLowShelfFilter
    private var lp2 : AKLowShelfFilter
    private var lp3 : AKLowShelfFilter
    private var lp4 : AKLowShelfFilter
    private var lp5 : AKLowShelfFilter
    //MID FILTERS
    private var bp1 : AKPeakingParametricEqualizerFilter
    private var bp2 : AKPeakingParametricEqualizerFilter
    private var bp3 : AKPeakingParametricEqualizerFilter
    private var bp4 : AKPeakingParametricEqualizerFilter
    private var bp5 : AKPeakingParametricEqualizerFilter
    //HIGH FILTERS
    private var hp1: AKHighShelfFilter
    private var hp2: AKHighShelfFilter
    private var hp3: AKHighShelfFilter
    private var hp4: AKHighShelfFilter
    private var hp5: AKHighShelfFilter
    //COMPRESSORS
    private var comp1: AKCompressor
    private var comp2: AKCompressor
    private var comp3: AKCompressor
    private var comp4: AKCompressor
    private var comp5: AKCompressor
    //FX BUS MIXERS
    private var reverb1_1: AKMixer!
    private var reverb2_1: AKMixer!
    private var delay1: AKMixer!
    private var pitchShift1: AKMixer!
    private var reverb1_2: AKMixer!
    private var reverb2_2: AKMixer!
    private var delay2: AKMixer!
    private var pitchShift2: AKMixer!
    private var reverb1_3: AKMixer!
    private var reverb2_3: AKMixer!
    private var delay3: AKMixer!
    private var pitchShift3: AKMixer!
    private var reverb1_4: AKMixer!
    private var reverb2_4: AKMixer!
    private var delay4: AKMixer!
    private var pitchShift4: AKMixer!
    private var reverb1_5: AKMixer!
    private var reverb2_5: AKMixer!
    private var delay5: AKMixer!
    private var pitchShift5: AKMixer!
    private var reverb1Mix: AKMixer!
    private var reverb2Mix: AKMixer!
    private var delayMix: AKMixer!
    private var pitchShiftMix: AKMixer!
    //Graphic EQ Filters
    private var geq1: AKPeakingParametricEqualizerFilter!
    private var geq2: AKPeakingParametricEqualizerFilter!
    private var geq3: AKPeakingParametricEqualizerFilter!
    private var geq4: AKPeakingParametricEqualizerFilter!
    private var geq5: AKPeakingParametricEqualizerFilter!
    private var geq6: AKPeakingParametricEqualizerFilter!
    private var geq7: AKPeakingParametricEqualizerFilter!
    private var geq8: AKPeakingParametricEqualizerFilter!
    private var geq9: AKPeakingParametricEqualizerFilter!
    private var geq10: AKPeakingParametricEqualizerFilter!
    //METER TRACKERS
    var track1_meter: AKAmplitudeTracker
    var track2_meter: AKAmplitudeTracker
    var track3_meter: AKAmplitudeTracker
    var track4_meter: AKAmplitudeTracker
    var track5_meter: AKAmplitudeTracker
    var meter: AKAmplitudeTracker //MasterMeter
  
    private override init() {
   
        //LOAD IN ALL AUDIO FILES INTO TRACKS
        rock1 = try! AKAudioFile(readFileName: "rock1.wav", baseDir: .resources) //Drums
        rock2 = try! AKAudioFile(readFileName: "rock2.wav", baseDir: .resources) //Bass
        rock3 = try! AKAudioFile(readFileName: "rock3.wav", baseDir: .resources) //Guitar
        rock4 = try! AKAudioFile(readFileName: "rock4.wav", baseDir: .resources) //Harmony Vocals
        rock5 = try! AKAudioFile(readFileName: "rock5.wav", baseDir: .resources) //Lead Vocals
        jazz1 = try! AKAudioFile(readFileName: "jazz1.wav", baseDir: .resources) //Kick
        jazz2 = try! AKAudioFile(readFileName: "jazz2.wav", baseDir: .resources) //Snare
        jazz3 = try! AKAudioFile(readFileName: "jazz3.wav", baseDir: .resources) //Overheads
        jazz4 = try! AKAudioFile(readFileName: "jazz4.wav", baseDir: .resources) //Bass
        jazz5 = try! AKAudioFile(readFileName: "jazz5.wav", baseDir: .resources) //Piano
        pop1 = try! AKAudioFile(readFileName: "pop1.wav", baseDir: .resources) //Drums
        pop2 = try! AKAudioFile(readFileName: "pop2.wav", baseDir: .resources) //Bass
        pop3 = try! AKAudioFile(readFileName: "pop3.wav", baseDir: .resources) //Synth
        pop4 = try! AKAudioFile(readFileName: "pop4.wav", baseDir: .resources) //Guitar
        pop5 = try! AKAudioFile(readFileName: "pop5.wav", baseDir: .resources) //Vocals
        metal1 = try! AKAudioFile(readFileName: "metal1.wav", baseDir: .resources) //Drums
        metal2 = try! AKAudioFile(readFileName: "metal2.wav", baseDir: .resources) //Bass
        metal3 = try! AKAudioFile(readFileName: "metal3.wav", baseDir: .resources) //Rhythm Guitar
        metal4 = try! AKAudioFile(readFileName: "metal4.wav", baseDir: .resources) //Solo Guitar
        metal5 = try! AKAudioFile(readFileName: "metal5.wav", baseDir: .resources) //Vocals
        choral1 = try! AKAudioFile(readFileName: "choral1.wav", baseDir: .resources) //Bariton
        choral2 = try! AKAudioFile(readFileName: "choral2.wav", baseDir: .resources) //Tenor
        choral3 = try! AKAudioFile(readFileName: "choral3.wav", baseDir: .resources) //Alto
        choral4 = try! AKAudioFile(readFileName: "choral4.wav", baseDir: .resources) //Soprano
        choral5 = try! AKAudioFile(readFileName: "choral5.wav", baseDir: .resources) //Solo
        electro1 = try! AKAudioFile(readFileName: "electro1.wav", baseDir: .resources) //Drums
        electro2 = try! AKAudioFile(readFileName: "electro2.wav", baseDir: .resources) //Bass
        electro3 = try! AKAudioFile(readFileName: "electro3.wav", baseDir: .resources) //Synths
        electro4 = try! AKAudioFile(readFileName: "electro4.wav", baseDir: .resources) //SFX
        electro5 = try! AKAudioFile(readFileName: "electro5.wav", baseDir: .resources) //Vocals

        //SETUP TRAKCS WITH INITIAL SONG GENRE
        track1_ = try! AKAudioPlayer(file: rock1)
        track2_ = try! AKAudioPlayer(file: rock2)
        track3_ = try! AKAudioPlayer(file: rock3)
        track4_ = try! AKAudioPlayer(file: rock4)
        track5_ = try! AKAudioPlayer(file: rock5)
        
        //SET TRACKS TO LOOP
        track1_.looping = true // Uses the 'looping' property of AKAudioPlayer
        track2_.looping = true
        track3_.looping = true
        track4_.looping = true
        track5_.looping = true
    
        //TRACK VOLUME HOLDERS
        track1_Init = track1_.volume
        track2_Init = track2_.volume
        track3_Init = track3_.volume
        track4_Init = track4_.volume
        track5_Init = track5_.volume
        
        //ROUTING FOR EQ SECTIONS
        lp1 = AKLowShelfFilter(track1_)
        lp2 = AKLowShelfFilter(track2_)
        lp3 = AKLowShelfFilter(track3_)
        lp4 = AKLowShelfFilter(track4_)
        lp5 = AKLowShelfFilter(track5_)
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
        
        //ROUTING FOR COMPRESSORS
        comp1 = AKCompressor(hp1)
        comp2 = AKCompressor(hp2)
        comp3 = AKCompressor(hp3)
        comp4 = AKCompressor(hp4)
        comp5 = AKCompressor(hp5)
        
        //ROUTING FOR TRACK METERS
        track1_meter = AKAmplitudeTracker(comp1)
        track2_meter = AKAmplitudeTracker(comp2)
        track3_meter = AKAmplitudeTracker(comp3)
        track4_meter = AKAmplitudeTracker(comp4)
        track5_meter = AKAmplitudeTracker(comp5)
        
        //Channel 1 FX Chain
        reverb1_1 = AKMixer(track1_meter)
        reverb2_1 = AKMixer(track1_meter)
        delay1 = AKMixer(track1_meter)
        pitchShift1 = AKMixer(track1_meter)
        //Initialise FX Sends to 0
        reverb1_1.volume = 0.0
        reverb2_1.volume = 0.0
        delay1.volume = 0.0
        pitchShift1.volume = 0.0
        
        //Channel 2 FX Chain
        reverb1_2 = AKMixer(track2_meter)
        reverb2_2 = AKMixer(track2_meter)
        delay2 = AKMixer(track2_meter)
        pitchShift2 = AKMixer(track2_meter)
        reverb1_2.volume = 0.0
        reverb2_2.volume = 0.0
        delay2.volume = 0.0
        pitchShift2.volume = 0.0
        
        //Channel 3 FX Chain
        reverb1_3 = AKMixer(track3_meter)
        reverb2_3 = AKMixer(track3_meter)
        delay3 = AKMixer(track3_meter)
        pitchShift3 = AKMixer(track3_meter)
        reverb1_3.volume = 0.0
        reverb2_3.volume = 0.0
        delay3.volume = 0.0
        pitchShift3.volume = 0.0
        
        //Channel 4 FX Chain
        reverb1_4 = AKMixer(track4_meter)
        reverb2_4 = AKMixer(track4_meter)
        delay4 = AKMixer(track4_meter)
        pitchShift4 = AKMixer(track4_meter)
        reverb1_4.volume = 0.0
        reverb2_4.volume = 0.0
        delay4.volume = 0.0
        pitchShift4.volume = 0.0
        
        //Channel 5 FX Chain
        reverb1_5 = AKMixer(track5_meter)
        reverb2_5 = AKMixer(track5_meter)
        delay5 = AKMixer(track5_meter)
        pitchShift5 = AKMixer(track5_meter)
        reverb1_5.volume = 0.0
        reverb2_5.volume = 0.0
        delay5.volume = 0.0
        pitchShift5.volume = 0.0
        
        //FX BUS MIXERS - Initialise to 0 volume
        reverb1Mix = AKMixer(reverb1_1, reverb1_2, reverb1_3, reverb1_4, reverb1_5)
        reverb1Mix.volume = 0.0
        reverb2Mix = AKMixer(reverb2_1, reverb2_2, reverb2_3, reverb2_4, reverb2_5)
        reverb2Mix.volume = 0.0
        delayMix = AKMixer(delay1, delay2, delay3, delay4, delay5)
        delayMix.volume = 0.0
        pitchShiftMix = AKMixer(pitchShift1, pitchShift2, pitchShift3, pitchShift4, pitchShift5)
        pitchShiftMix.volume = 0.0
        
        
        //ROUTING FOR FX UNITS INPUT
        reverb1 = AKReverb(reverb1Mix)
        reverb2 = AKReverb(reverb2Mix)
        delay = AKDelay(delayMix)
        pitchShift = AKPitchShifter(pitchShiftMix)
        reverb1.dryWetMix = 1.0
        reverb2.dryWetMix = 1.0
        delay.dryWetMix = 1.0

        //ROUTE ALL CHANNELS AND FX BUSES TO MASTER MIXER
        mixer = AKMixer(comp1, comp2, comp3, comp4, comp5, reverb1, reverb2, delay, pitchShift)
        
        //ROUTING FOR GRAPHIC EQUALISER
        geq1 = AKPeakingParametricEqualizerFilter(mixer)
        geq2 = AKPeakingParametricEqualizerFilter(geq1)
        geq3 = AKPeakingParametricEqualizerFilter(geq2)
        geq4 = AKPeakingParametricEqualizerFilter(geq3)
        geq5 = AKPeakingParametricEqualizerFilter(geq4)
        geq6 = AKPeakingParametricEqualizerFilter(geq5)
        geq7 = AKPeakingParametricEqualizerFilter(geq6)
        geq8 = AKPeakingParametricEqualizerFilter(geq7)
        geq9 = AKPeakingParametricEqualizerFilter(geq8)
        geq10 = AKPeakingParametricEqualizerFilter(geq9)
        
        //SET FREQUENCY BANDS FOR GRAPHIC EQUALISER
        geq1.centerFrequency = 31
        geq1.gain = 0.5
        geq2.centerFrequency = 63
        geq2.gain = 0.5
        geq3.centerFrequency = 125
        geq3.gain = 0.5
        geq4.centerFrequency = 250
        geq4.gain = 0.5
        geq5.centerFrequency = 500
        geq5.gain = 0.5
        geq6.centerFrequency = 1000
        geq6.gain = 0.5
        geq7.centerFrequency = 2000
        geq7.gain = 0.5
        geq8.centerFrequency = 4000
        geq8.gain = 0.5
        geq9.centerFrequency = 8000
        geq9.gain = 0.5
        geq10.centerFrequency = 16000
        geq10.gain = 0.5
      
        //SEND MASTER OUTPUT TO METER
        meter = AKAmplitudeTracker(geq10)
        
        //INITIALSE MASTER VOLUME
        masterInit = 0.5 //Initialise volume to 0
        mixer.volume = masterInit

        //START FILTER SECTIONS
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
        //INITIALISE COMPRESSORS TO OFF
        comp1.stop()
        comp2.stop()
        comp3.stop()
        comp4.stop()
        comp5.stop()
        
        //SEND MASTER OUTPUT TO AUDIOKIT OUTPUT
        AudioKit.output = meter
        
        super.init()
        
        //Setup audio node to access output in view controller for waveform plot
        self.avAudioNode = meter.avAudioNode
        
        AudioKit.start()   // Start Audio Kit
    
        //PLAY TRACKS ON MIXER START
        track1_.play()
        track2_.play()
        track3_.play()
        track4_.play()
        track5_.play()
    }
  
    //*****************************************************************
    // MARK: - GRAPHIC EQUALISER
    //*****************************************************************
    open func graphicEQ(_ band: Int, _ gain: Double){
        //Change gain for specific band based on input from VC Sliders
        switch(band){
        case 0:
            geq1.gain = gain
        case 1:
            geq2.gain = gain
        case 2:
            geq3.gain = gain
        case 3:
            geq4.gain = gain
        case 4:
            geq5.gain = gain
        case 5:
            geq6.gain = gain
        case 6:
            geq7.gain = gain
        case 7:
            geq8.gain = gain
        case 8:
            geq9.gain = gain
        case 9:
            geq10.gain = gain
        default:
            break
        }
    }
    
    //*****************************************************************
    // MARK: - SONG SELECT - Changes song based on user selection
    //*****************************************************************
    open func typeSelect(_ type: Int){
        
        track1_.stop() //Stop current playing tracks
        track2_.stop()
        track3_.stop()
        track4_.stop()
        track5_.stop()
        
        //Replace files based on user input
        switch(type){
        case 0:
            try! track1_.replace(file: rock1)
            try! track2_.replace(file: rock2)
            try! track3_.replace(file: rock3)
            try! track4_.replace(file: rock4)
            try! track5_.replace(file: rock5)
        case 1:
            try! track1_.replace(file: jazz1)
            try! track2_.replace(file: jazz2)
            try! track3_.replace(file: jazz3)
            try! track4_.replace(file: jazz4)
            try! track5_.replace(file: jazz5)
        case 2:
            try! track1_.replace(file: pop1)
            try! track2_.replace(file: pop2)
            try! track3_.replace(file: pop3)
            try! track4_.replace(file: pop4)
            try! track5_.replace(file: pop5)
        case 3:
            try! track1_.replace(file: metal1)
            try! track2_.replace(file: metal2)
            try! track3_.replace(file: metal3)
            try! track4_.replace(file: metal4)
            try! track5_.replace(file: metal5)
        case 4:
            try! track1_.replace(file: choral1)
            try! track2_.replace(file: choral2)
            try! track3_.replace(file: choral3)
            try! track4_.replace(file: choral4)
            try! track5_.replace(file: choral5)
        case 5:
            try! track1_.replace(file: electro1)
            try! track2_.replace(file: electro2)
            try! track3_.replace(file: electro3)
            try! track4_.replace(file: electro4)
            try! track5_.replace(file: electro5)
        default:
            break
        }
        //PLAY NEW SONG TRACKS
        track1_.play()
        track2_.play()
        track3_.play()
        track4_.play()
        track5_.play()
    }
    
    //*****************************************************************
    // MARK: - METERS - returns track and master amplitudes to VC
    //                  to display on meters
    //*****************************************************************
    
    @objc open func printAmplitude() -> Array<Double>{

        var amplitudes = [Double]()
        
        amplitudes.insert(track1_meter.amplitude, at: 0)
        amplitudes.insert(track2_meter.amplitude, at: 1)
        amplitudes.insert(track3_meter.amplitude, at: 2)
        amplitudes.insert(track4_meter.amplitude, at: 3)
        amplitudes.insert(track5_meter.amplitude, at: 4)
        amplitudes.insert(meter.amplitude, at: 5)
        
        return Array<Double>(amplitudes)
    }
    
    //*****************************************************************
    // MARK: - TRACK VOLUME - functions adjust individual track volumes
    //*****************************************************************
    
    open func settrack1_Volume(_ track1_Volume: Float){
        //Check if channel mute or solos are activated
        if track1_MuteOn || (globalSolo && soloIdentifier != 1){
            track1_.volume = 0.0
        }
        else{
            track1_.volume = Double(track1_Volume)
        }
        track1_Init = Double(track1_Volume)
    }
    
    open func settrack2_Volume(_ track2_Volume: Float){
      
        if track2_MuteOn || (globalSolo && soloIdentifier != 2){
            track2_.volume = 0.0
        }
        else{
            track2_.volume = Double(track2_Volume)
        }
        track2_Init = Double(track2_Volume)
    }
    
    open func settrack3_Volume(_ track3_Volume: Float){
        
        if track3_MuteOn || (globalSolo && soloIdentifier != 3){
            track3_.volume = 0.0
        }
        else{
            track3_.volume = Double(track3_Volume)
        }
        track3_Init = Double(track3_Volume)
    }
    
    open func settrack4_Volume(_ track4_Volume: Float){
        
        if track4_MuteOn || (globalSolo && soloIdentifier != 4){
            track4_.volume = 0.0
        }
        else{
            track4_.volume = Double(track4_Volume)
        }
        track4_Init = Double(track4_Volume)
        
    }
    
    open func settrack5_Volume(_ track5_Volume: Float){
        
        if track5_MuteOn || (globalSolo && soloIdentifier != 5){
            track5_.volume = 0.0
        }
        else{
            track5_.volume = Double(track5_Volume)
        }
        track5_Init = Double(track5_Volume)
        
    }

    open func setMasterVolume(_ masterVolume: Float){

        mixer.volume = Double(masterVolume)
    }
    //*****************************************************************
    // MARK: - PAN - Adjust pan L/R for each channel
    //*****************************************************************
    
    open func settrack1_Pan(_ track1_Pan: Float){
        track1_.pan = Double(track1_Pan)
    }
    
    open func settrack2_Pan(_ track2_Pan: Float){
        track2_.pan = Double(track2_Pan)
    }
    
    open func settrack3_Pan(_ track3_Pan: Float){
        track3_.pan = Double(track3_Pan)
    }
    
    open func settrack4_Pan(_ track4_Pan: Float){
        track4_.pan = Double(track4_Pan)
    }
    
    open func settrack5_Pan(_ track5_Pan: Float){
        track5_.pan = Double(track5_Pan)
    }
    
    //*****************************************************************
    // MARK: - MUTES - Functions to mute each channels base on buttons
    //*****************************************************************
    open func settrack1_Mute(_ track1_Mute: Bool){
        
        //Set mute identifier
        track1_MuteOn = !track1_Mute
        //Input from button either keeps volume as previous or sets to 0 whilst button selected
        if track1_Mute {
            track1_.volume = track1_Init
        }else{
            track1_.volume = 0
        }
    }
    
    open func settrack2_Mute(_ track2_Mute: Bool){
        
        track2_MuteOn = !track2_Mute
        
        if track2_Mute {
            track2_.volume = track2_Init
        }else{
            track2_.volume = 0
        }
    }
    
    open func settrack3_Mute(_ track3_Mute: Bool){
        
        track3_MuteOn = !track3_Mute
        
        if track3_Mute {
            track3_.volume = track3_Init
        }else{
            track3_.volume = 0
        }
    }
    
    open func settrack4_Mute(_ track4_Mute: Bool){
        
        track4_MuteOn = !track4_Mute
        
        if track4_Mute {
            track4_.volume = track4_Init
        }else{
            track4_.volume = 0
        }
    }
    
    open func settrack5_Mute(_ track5_Mute: Bool){
        
        track5_MuteOn = !track5_Mute
        
        if track5_Mute {
            track5_.volume = track5_Init
        }else{
            track5_.volume = 0
        }
    }
    
    open func setMasterMute(_ masterMute: Bool){
        masterMuteOn = !masterMute
        
        if masterMute {
            mixer.volume = masterInit
        }else{
            mixer.volume = 0
        }
    }
    
    //*****************************************************************
    // MARK: - Solos
    //*****************************************************************
    open func settrack1_Solo(_ track1_Solo: Bool){
        if track1_Solo{
            track2_.volume = 0.0
            track3_.volume = 0.0
            track4_.volume = 0.0
            track5_.volume = 0.0
            globalSolo = true
            soloIdentifier = 1
        }else{
            track2_.volume = track2_Init
            track3_.volume = track3_Init
            track4_.volume = track4_Init
            track5_.volume = track5_Init
            globalSolo = false
            soloIdentifier = 0
        }
    }
    
    open func settrack2_Solo(_ track2_Solo: Bool){
        if track2_Solo{
            track1_.volume = 0.0
            track3_.volume = 0.0
            track4_.volume = 0.0
            track5_.volume = 0.0
            globalSolo = true
            soloIdentifier = 2
        }else{
            track1_.volume = track1_Init
            track3_.volume = track3_Init
            track4_.volume = track4_Init
            track5_.volume = track5_Init
            globalSolo = false
            soloIdentifier = 0
        }
    }
    
    open func settrack3_Solo(_ track3_Solo: Bool){
        if track3_Solo{
            track1_.volume = 0.0
            track2_.volume = 0.0
            track4_.volume = 0.0
            track5_.volume = 0.0
            globalSolo = true
            soloIdentifier = 3
        }else{
            track1_.volume = track1_Init
            track2_.volume = track2_Init
            track4_.volume = track4_Init
            track5_.volume = track5_Init
            globalSolo = false
            soloIdentifier = 0
        }
    }
    
    open func settrack4_Solo(_ track4_Solo: Bool){
        if track4_Solo{
            track1_.volume = 0.0
            track2_.volume = 0.0
            track3_.volume = 0.0
            track5_.volume = 0.0
            globalSolo = true
            soloIdentifier = 4
        }else{
            track1_.volume = track1_Init
            track2_.volume = track2_Init
            track3_.volume = track3_Init
            track5_.volume = track5_Init
            globalSolo = false
            soloIdentifier = 0
        }
    }
    
    open func settrack5_Solo(_ track5_Solo: Bool){
        if track5_Solo{
            track1_.volume = 0.0
            track2_.volume = 0.0
            track3_.volume = 0.0
            track4_.volume = 0.0
            globalSolo = true
            soloIdentifier = 5
        }else{
            track1_.volume = track1_Init
            track2_.volume = track2_Init
            track3_.volume = track3_Init
            track4_.volume = track4_Init
            globalSolo = false
            soloIdentifier = 0
        }
    }
    
    //*****************************************************************
    // MARK: - PLAY/PAUSE/REWIND
    //*****************************************************************
    open func playPause(_ playSelect: Bool){
        if playSelect{
            track1_.pause()
            track2_.pause()
            track3_.pause()
            track4_.pause()
            track5_.pause()
        }
        else{
            track1_.resume()
            track2_.resume()
            track3_.resume()
            track4_.resume()
            track5_.resume()
        }
    }
    
    open func rewindSong(){
        
        track1_.stop() //Stop and rewind all tracks
        track2_.stop()
        track3_.stop()
        track4_.stop()
        track5_.stop()
        track1_.play() //Play from start
        track2_.play()
        track3_.play()
        track4_.play()
        track5_.play()
    }
    
    
    
    //*****************************************************************
    // MARK: - EQ CONTROLS - Knobs return 0->1 value so each case includes
    //                        factoring to achieve correct values
    //*****************************************************************
    
    open func adjustEQ(_ controlSelect: Int, _ value: Double) -> Double{
        
        //Master switch statement controls all EQ based on knob tags
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
    
    //*****************************************************************
    // MARK: - PLAYHEAD POISITION
    //*****************************************************************
    //Returns ratio of track position to full duration
    open func playhead() -> Double {

        let duration = track1_.duration
        let playhead = track1_.playhead
        
        return playhead/duration
    }
    //Returns position of track
    open func trackPosition() -> Double{
        return track1_.playhead
    }
    //Returns duration of track
    open func trackLength() -> Double {
        return track1_.duration
    }
    
    //*****************************************************************
    // MARK: - COMPRESSOR CONTROL
    //*****************************************************************
    open func compressor(_ controlSelect: Int, _ value: Double){
       //Master Switch statment for each compressor based on knob tags
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
    //On/Off Toggles for each Compressor
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
    //Meter returns for each compressor
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
    
    //*****************************************************************
    // MARK: - FX Send Values
    //*****************************************************************
    open func FXSends(_ select: Int, _ value: Double){
        
        switch(select){
        case 0:
            reverb1_1.volume = value
        case 1:
            reverb2_1.volume = value
        case 2:
            delay1.volume = value
        case 3:
            pitchShift1.volume = value
        case 10:
            reverb1_2.volume = value
        case 11:
            reverb2_2.volume = value
        case 12:
            delay2.volume = value
        case 13:
            pitchShift2.volume = value
        case 20:
            reverb1_3.volume = value
        case 21:
            reverb2_3.volume = value
        case 22:
            delay3.volume = value
        case 23:
            pitchShift3.volume = value
        case 30:
            reverb1_4.volume = value
        case 31:
            reverb2_4.volume = value
        case 32:
            delay4.volume = value
        case 33:
            pitchShift4.volume = value
        case 40:
            reverb1_5.volume = value
        case 41:
            reverb2_5.volume = value
        case 42:
            delay5.volume = value
        case 43:
            pitchShift5.volume = value
        default:
            break
        }
    }
    
    //*****************************************************************
    // MARK: - FX CONTROLS
    //*****************************************************************
    //TURN FX ON/FF
    open func FXOn(_ select: Int, _ state: Bool){
        
        switch(select){
        case 0:
            if state{
                reverb1.start()
            }
            else{
                reverb1.stop()
            }
        case 1:
            if state{
                reverb2.start()
            }
            else{
                reverb2.stop()
            }
        case 2:
            if state{
                delay.start()
            }
            else{
                delay.stop()
            }
        case 3:
            if state{
                pitchShift.start()
            }
            else{
                pitchShift.stop()
            }
        default:
            break
        }
    }
    //REVERB 1 CONTROLS
    open func reverb1Select(_ select: Int){
        //Load different reverb presets
        switch(select){
        case 0:
                reverb1.loadFactoryPreset(.smallRoom)
        case 1:
            reverb1.loadFactoryPreset(.largeRoom)
        case 2:
            reverb1.loadFactoryPreset(.mediumChamber)
        case 3:
            reverb1.loadFactoryPreset(.plate)
        default:
            break
        }
    }
    //REVERB 2 CONTROLS
    open func reverb2Select(_ select: Int){
        //Load different reverb presets
        switch(select){
        case 0:
            reverb2.loadFactoryPreset(.mediumHall)
        case 1:
            reverb2.loadFactoryPreset(.largeHall2)
        case 2:
            reverb2.loadFactoryPreset(.cathedral)
        default:
            break
        }
    }
    //DELAY CONTROLS
    open func FXKnobEdit(_ control: Int, _ value: Double){
        
        switch(control){
        case 0:
            delay.time = value * 2
        case 1:
            delay.feedback = value
        case 2:
            delay.lowPassCutoff = value * 15000
        default:
            break
        }
    }
    //PITCH SHIFT ADJUST
    open func pitchChange(_ shift: Double){
        pitchShift.shift = shift
    }
    //MASTER FX BUS LEVELS
    open func FXBusLevel(_ select: Int, _ value: Float){
        
        let value = Double(value)
        
        switch(select){
        case 0:
            reverb1Mix.volume = value
        case 1:
            reverb2Mix.volume = value
        case 2:
            delayMix.volume = value
        case 3:
            pitchShiftMix.volume = value
        default:
            break
        }
    }
}//Closes audioMixer Class
