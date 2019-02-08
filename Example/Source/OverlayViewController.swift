//
//  OverlayViewController.swift
//  iOS Example
//
//  Created by Watanabe Toshinori on 2/6/19.
//  Copyright © 2019 Watanabe Toshinori. All rights reserved.
//

import UIKit
import FakeTouch

class OverlayViewController: UIViewController {
    
    @IBOutlet weak var recorderButton: UIButton!

    @IBOutlet weak var playerButton: UIButton!
    
    var events = [TouchEvent]() {
        didSet {
            playerButton.isHidden = events.isEmpty
        }
    }
    
    var player: TouchPlayer?
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        recorderButton.layer.cornerRadius = recorderButton.frame.height / 4
        recorderButton.layer.masksToBounds = true

        playerButton.layer.cornerRadius = playerButton.frame.height / 4
        playerButton.layer.masksToBounds = true
        playerButton.isHidden = true
    }

    // MARK: - Action
    
    @IBAction func recorderTapped(_ sender: Any) {
        let recorder = TouchRecorder.shared
        
        if recorder.isRecording {
            recorderButton.setImage(UIImage(named: "RecordDisabled")!, for: .normal)
            
            recorder.stop()

        } else {
            recorderButton.setImage(UIImage(named: "RecordEnabled")!, for: .normal)

            recorder.record { [weak self] (events, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                self?.events = events
            }
        }
    }
    
    @IBAction func playerTapped(_ sender: Any) {
        if let player = player, player.isPlaying {
            playerButton.setImage(UIImage(named: "PlayerPlay"), for: .normal)

            player.stop()

            self.player = nil

        } else {
            playerButton.setImage(UIImage(named: "PlayerStop"), for: .normal)

            let player = TouchPlayer(events: events)

            player.play(finishPlayHandler: { [weak self] (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self?.playerButton.setImage(UIImage(named: "PlayerPlay"), for: .normal)
            })
            
            self.player = player
        }
    }

}
