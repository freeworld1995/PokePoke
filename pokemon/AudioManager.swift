//
//  AudioManager.swift
//  pokemon
//
//  Created by Jimmy Hoang on 1/30/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import AVFoundation

class AudioManager: NSObject, AVAudioPlayerDelegate {
    static var shareInstance = AudioManager()
    var play: AVAudioPlayer!
    var background: AVAudioPlayer!
    var click: AVAudioPlayer!
    var toggle: AVAudioPlayer!
    var wrong: AVAudioPlayer!
    var correct: AVAudioPlayer!
    
    var toggleMusics: Bool = false {
        didSet {
            UserDefaults.standard.set(toggleMusics, forKey: "toggleMusics")
            
            if toggleMusics {
                backgroundAudios.forEach { $0.volume = 1 }
            } else {
                backgroundAudios.forEach { $0.volume = 0 }
            }
        }
    }
    
    var toggleEffects: Bool = false {
        didSet {
            UserDefaults.standard.set(toggleEffects, forKey: "toggleEffects")
            
            if toggleEffects {
                effectAudios.forEach { $0.volume = 1 }
            } else {
                effectAudios.forEach { $0.volume = 0 }
            }
        }
    }
    
    var backgroundAudios = [AVAudioPlayer]()
    var effectAudios = [AVAudioPlayer]()
    
    override init() {
        super.init()
        
        // Becuz willSet, DidSet will not run in initialization -> user 'defer'
        defer {
            toggleMusics = UserDefaults.standard.object(forKey: "toggleMusics") as? Bool ?? true
            toggleEffects = UserDefaults.standard.object(forKey: "toggleEffects") as? Bool ?? true
        }

        self.play = getFile(name: Sound.play, type: "mp3")
        self.background = getFile(name: Sound.background, type: "mp3")
        self.click = getFile(name: Sound.click, type: "wav")
        self.toggle = getFile(name: Sound.toggle, type: "wav")
        self.wrong =  getFile(name: Sound.wrong, type: "wav")
        self.correct = getFile(name: Sound.correct, type: "wav")
        
        backgroundAudios = [play, background]
        effectAudios = [click, correct, wrong]
        
        backgroundAudios.forEach {
            $0.numberOfLoops = -1
        }
        
    }
    
    func setInitialValue(newValue: Bool) {
        self.toggleMusics = newValue
    }
    
    func getFile(name: String, type: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name, withExtension: type) else { return nil}
        
        var audioPlayer = AVAudioPlayer()
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            
        } catch {
            print(error)
        }
        
        return audioPlayer
    }
}
