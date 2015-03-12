//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by JC Smith on 2/18/15.
//  Copyright (c) 2015 JC Smith. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //class vars
    var audioPlayer = AVAudioPlayer()
    var error:NSError?
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
        audioPlayer.volume = 1.0
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    //snail
    @IBAction func playAudioSlowly(sender: UIButton) {
        //init playing
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        
        audioPlayer.currentTime = 0.0 //start at the begining of the sound file
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    //hare
    @IBAction func PlayAudioQuickly(sender: UIButton) {
        //init playing
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        
        audioPlayer.currentTime = 0.0 //start at the begining of the sound file
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    //stop playback
    @IBAction func stopAudioPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    //set pitch to chipmunk-like
    @IBAction func playAudioLikeAChipmunk(sender: UIButton) {
       playAudioWithVariablePitch(1000)
    }
    
    //Luke I am your father
    @IBAction func playAudioLikeDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    //create a pitch effect based on input for added versitility
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
