//
//  ViewController.swift
//  FirstGame
//
//  Created by ProSmart on 16.8.21..
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    
    var score = 0;
    var timer = Timer()
    var timer2 = Timer()
    
    var counter = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        //menja vrednost za score kad se klikne
        imageView.isUserInteractionEnabled = true
        let gestureRecognizers = UITapGestureRecognizer(target: self, action: #selector(updateScore))
        imageView.addGestureRecognizer(gestureRecognizers)
        
        //timer
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc func setTime(){
        timeLabel.text = String(counter)
        counter -= 1
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = String(counter)
        }
        
    }
    
    @objc func updateScore() {
        if counter != 0 {
            score += 1
            scoreText.text = String(score)
            updatePosition()
        }else{
            highScore.text = "Highscore: " + String(score)
            
        }
    }
    
    @objc func updatePosition() {
        let xCoord = CGFloat.random(in: 0...(view.frame.maxX - imageView.frame.width ))
        let yCoord = CGFloat.random(in: 0...350)

        UIView.animate(withDuration: 0.3) {
            self.imageView.transform = CGAffineTransform(translationX: xCoord, y: yCoord)
        }
    }
    
    
    
    
    
    
    @IBAction func button(_ sender: Any) {
        updatePosition()
        print(imageView.frame.origin)
        
    }
    

}

