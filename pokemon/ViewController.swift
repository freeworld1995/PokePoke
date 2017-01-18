//
//  ViewController.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/16/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

