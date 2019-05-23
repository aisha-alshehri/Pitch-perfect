//
//  RecoredViewController.swift
//  PitchPerfect
//
//  Created by Aisha dafer on 13/07/1440 AH.
//  Copyright © 1440 Aisha dafer. All rights reserved.
//

import UIKit
import AVFoundation

class RecoredViewController: UIViewController , AVAudioRecorderDelegate{

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLable: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
    }
    
   
    @IBAction func RecoredButton(_ sender: UIButton) {
    
        recordingLable.text = "Recording in progress"
        stopRecordButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()   }

    @IBAction func StopButton(_ sender: UIButton) {
        stopRecordButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLable.text = "Tab to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording" , sender: audioRecorder.url)
        } else {
            print("error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    }

