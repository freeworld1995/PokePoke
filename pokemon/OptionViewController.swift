//
//  OptionViewController.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/16/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {

    
    @IBOutlet var generationButtonColleciton: [UIButton]!
    @IBOutlet weak var toggleEffect: UISwitch! {
        didSet {
            toggleEffect.isOn = AudioManager.shareInstance.toggleEffects
        }
    }
    
    @IBOutlet weak var toggleMusic: UISwitch! {
        didSet {
            toggleMusic.isOn = AudioManager.shareInstance.toggleMusics
        }
    }
    
    @IBAction func effectToggled(_ sender: UISwitch) {
        AudioManager.shareInstance.toggleEffects = toggleEffect.isOn
    }
    

    @IBAction func musicToggled(_ sender: UISwitch) {
        AudioManager.shareInstance.toggleMusics = toggleMusic.isOn
    }
    
    @IBAction func generationPressed(_ sender: UIButton) {
        if sender.alpha == 1.0 {
            sender.alpha = 0.5
        } else {
            sender.alpha = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let genArray = UserDefaults.standard.object(forKey: "generations") as! [Int]? {
            
            if genArray.isEmpty {
                generationButtonColleciton.forEach {
                    $0.alpha = 1.0
                }
            }
            
            genArray.forEach {
                print($0)
                generationButtonColleciton[$0 - 1].alpha = 1.0
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        var genArray: [Int] = []
        
        generationButtonColleciton.forEach {
            if $0.alpha == 1 {
                genArray.append($0.tag)
            }
        }
        
        UserDefaults.standard.set(genArray, forKey: "generations")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
