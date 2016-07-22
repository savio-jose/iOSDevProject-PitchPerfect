//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by savio jose on 14/06/16.
//  Copyright © 2016 savio jose. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var startRecordingBtn: UIButton!
    @IBOutlet weak var stopRecordingBtn: UIButton!
    @IBOutlet weak var recordingLbl: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    struct Segue {
        static let PlaySound = "playSound"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopRecordingBtn.enabled = false
    }


    @IBAction func startRecording(sender: AnyObject) {
        
        startRecordingBtn.enabled = false
        stopRecordingBtn.enabled = true
        recordingLbl.text = "Recording in Progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }

    
    @IBAction func stopRecording(sender: AnyObject) {
        
        stopRecordingBtn.enabled = false
        startRecordingBtn.enabled = true
        
        recordingLbl.text = "Tap to Record"
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        
    }
    
    //callback method when recording is stopped
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            self.performSegueWithIdentifier(Segue.PlaySound, sender: audioRecorder.url)
        }else{
            
            print("Saving of recording failed.")
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == Segue.PlaySound) {
            let playSoundVC = segue.destinationViewController as! PlaySoundViewController
            let recordedAudioURL = sender as! NSURL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

