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
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var hScore = 0;
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
        timeLabel.text = "Time: " + String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(updatePosition), userInfo: nil, repeats: true)
                
        //postavljanje HighScore
        if let hs = UserDefaults.standard.object(forKey: "highScore") as? Int {
            hScore = hs
            highScoreLabel.text = "HighScore: " + String(hScore)
            
        }
        
        
    }
    
    @objc func setTime(){
        
        counter -= 1
        timeLabel.text = "Time: " +  String(counter)
        if counter == 0 {
            timer.invalidate()
            timer2.invalidate()
            checkHighscore(highScore: score)
            print(score)
            
            
            timeLabel.text = "Time: " +  String(counter)
        }
        
    }
    
    @objc func updateScore() {
        if counter != 0 {
            score += 1
            scoreText.text = "Score: " + String(score)
            updatePosition()
        }else{
            
            //self.checkHighscore(highScore: self.score)
            let alert = UIAlertController(title: "Time is up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let buttonOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreText.text = "Score: " + String(0)
                self.viewDidLoad()
                
                
            }
            alert.addAction(buttonOK)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkHighscore(highScore : Int){
        
        if highScore > hScore {
            highScoreLabel.text = "HighScore: " + String(highScore)
            UserDefaults.standard.set(highScore, forKey: "highScore")
            
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
        UserDefaults.standard.set(0, forKey: "highScore")
        highScoreLabel.text = "HighScore: " + UserDefaults.standard.string(forKey: "highScore")!
        
        
    }
    

}

