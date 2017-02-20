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
    
    var transition = TriangleTransition()
    
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
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "optionSegue" {
            AudioManager.shareInstance.background.stop()
        }
        
        if let playViewVC = segue.destination as? PlayViewController {
            playViewVC.transitioningDelegate = self
//            playViewVC.modalPresentationStyle  = .
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        AudioManager.shareInstance.background.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        return transition
    }
}

