
//
//  PlayViewController.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/17/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit
import GameplayKit

class PlayViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    var point: Int = 0 {
        didSet {
            score.text = "\(point)"
        }
    }
    
    var front: UIImageView!
    var back: UIImageView!
    var detail: UILabel!
    
    var randAnswers: [pokemon]!
    var pokemons: [pokemon]!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = DatabaseManager.selectAllPokemons()
        randAnswers = randomAnswers()
        changeBackgroundColor()
        setupImage()
        setupAnswers()
        
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(endGame), userInfo: nil, repeats: false)
    }
    
    func endGame() {
        let highscore = UserDefaults.standard.object(forKey: "highscore") as! Int?
        
        if highscore != nil {
            if point > highscore! {
                UserDefaults.standard.set(point, forKey: "highscore")
            }
        }
        
        let ac = UIAlertController(title:"Game Over", message: "Your score is \(point)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "mainVC") as! ViewController
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true)
        })
        present(ac, animated: true)
    }
    
    func setupImage() {
        front = UIImageView(frame: cardView.bounds)
        front.image = UIImage(named: randAnswers[0].imgURL)?.withRenderingMode(.alwaysTemplate)
        back = UIImageView(frame: cardView.bounds)
        back.image = UIImage(named: randAnswers[0].imgURL)
        detail = UILabel(frame: CGRect(origin: back.bounds.origin, size: CGSize(width: 200, height: 50)))
        detail.font = UIFont(name: "Helvetica", size: 17)
        detail.text = "\(randAnswers[0].tag) - \(randAnswers[0].name)"
        back.addSubview(detail)
        cardView.subviews.forEach {
            $0.removeFromSuperview()
        }
        cardView.addSubview(front)
    }
    
    func setupAnswers() {
        let randAnswerShuffled = GKARC4RandomSource.sharedRandom().arrayByShufflingObjects(in: randAnswers) as! [pokemon]
        
        for i in 0..<randAnswerShuffled.count {
            answerButtons[i].setTitle(randAnswerShuffled[i].name, for: .normal)
        }
    }
    
    func reset() {
        answerButtons.forEach {
            $0.backgroundColor = UIColor.white
        }
        randAnswers.removeAll()
        randAnswers = randomAnswers()
        changeBackgroundColor()
        setupImage()
        setupAnswers()
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == randAnswers[0].name {
            sender.backgroundColor = UIColor.green
            
            point += 1
            
            UIView.transition(from: front, to: back, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) { [unowned self] in
                self.reset()
            }
            
        } else {
            sender.backgroundColor = UIColor.red
            
            if point == 0 {
                point = 0
            } else {
                point -= 1
            }
            
            UIView.transition(from: front, to: back, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
            
            answerButtons.forEach {
                if $0.titleLabel?.text == randAnswers[0].name {
                    $0.backgroundColor = UIColor.green
                }
            }
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) { [unowned self] in
                self.reset()
            }
        }
    }
    
    func changeBackgroundColor() {
        self.view.backgroundColor = String.hexStringToUIColor(hex: randAnswers[0].color)
    }
    
    func randomAnswers() -> [pokemon] {
        var pokemonAnswers: [pokemon] = []
        
        if pokemons.count > 0 {
            let arrayIndex = Int(arc4random_uniform(UInt32(pokemons.count)))
            
            let randRealPokemonAnswer = pokemons[arrayIndex]
            
            pokemons.remove(at: arrayIndex)
            
            let randFakePokemonAnswer1 = pokemons[Int(arc4random_uniform(UInt32(pokemons.count)))]
            let randFakePokemonAnswer2 = pokemons[Int(arc4random_uniform(UInt32(pokemons.count)))]
            let randFakePokemonAnswer3 = pokemons[Int(arc4random_uniform(UInt32(pokemons.count)))]
            
            pokemonAnswers = [randRealPokemonAnswer, randFakePokemonAnswer1, randFakePokemonAnswer2, randFakePokemonAnswer3]
        }
        
        return pokemonAnswers
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}