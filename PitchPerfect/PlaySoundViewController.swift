//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by savio jose on 15/06/16.
//  Copyright © 2016 savio jose. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var snailBtn: UIButton!
    @IBOutlet weak var rabbitBtn: UIButton!
    @IBOutlet weak var chipmunkBtn: UIButton!
    @IBOutlet weak var darthVaderBtn: UIButton!
    @IBOutlet weak var echoBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int {case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb}
    
    
    @IBAction func playSoundForButton(sender: UIButton){
        
        switch (ButtonType(rawValue: sender.tag)!) {
            
        case .Slow:
            playSound(rate: 0.5)
            
        case .Fast:
            playSound(rate: 1.5)
            
        case .Chipmunk:
            playSound(pitch: 1000)
            
        case .Vader:
            playSound(pitch: -1000)
            
        case .Echo:
            playSound(echo: true)
            
        case .Reverb:
            playSound(reverb: true)
            
        }
        
        configureUI(.Playing)
        
    }
    
    @IBAction func didClickStopButton(sender: AnyObject){
        
        stopAudio()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAudio()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI(.NotPlaying)
    }


}
