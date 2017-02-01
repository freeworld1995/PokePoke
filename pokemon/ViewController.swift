//
//  ViewController.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/16/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let highscore = UserDefaults.standard.object(forKey: "highscore") as! Int?
        if highscore != nil {
            score.text = "\(highscore!)"
        } else {
            score.text = "0"
        }
        
        //        let path = Bundle.main.path(forResource: Sound.background, ofType: "mp3")
        //        let url = URL(string: path!)
        //        audio = try! AVAudioPlayer(contentsOf: url!)
        //        audio.play()
        
        AudioManager.shareInstance.background.play()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "optionSegue" {
                    AudioManager.shareInstance.background.stop()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
}

