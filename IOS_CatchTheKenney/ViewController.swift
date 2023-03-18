//
//  ViewController.swift
//  IOS_CatchTheKenney
//
//  Created by Enes Talha Yılmaz on 1.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHighScore: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTimeCount: UILabel!
    @IBOutlet weak var ivGesture: UIImageView!
    var timer = Timer()
    var timeCounter = 10
    var scoreCounter = 0
    var isLoadingFirstTime = true
    override func viewDidLoad() {
        super.viewDidLoad()
        ivGesture.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(OnTUIKenney))
        ivGesture.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func OnTUIKenney()
    {
        scoreCounter += 1
        lblScore.text = "Score:  \(scoreCounter)"
    }
    override func viewDidAppear(_ animated: Bool) {
        if isLoadingFirstTime
        {
            StartAlert()
            isLoadingFirstTime = false
        }
    }
    func StartTheGame()
    {
        scoreCounter=0
        lblScore.text = "Score:  \(scoreCounter)"
        lblHighScore.text = "High Score: \( String(UserDefaults.standard.integer(forKey: "highScore")))"
        
        StartTimer()
    }
    func MoveOnLoop(){
    }
    @objc func TimesUpOnGame()
    {
        timeCounter -= 1
        lblTimeCount.text = String(timeCounter)
        if(UserDefaults.standard.integer(forKey: "highScore") < scoreCounter)
        {
            UserDefaults.standard.set(scoreCounter, forKey: "highScore")
            lblHighScore.text = "High Score: \( String(UserDefaults.standard.integer(forKey: "highScore")))"
            
            
        }
        if timeCounter <= 0
        {
            timer.invalidate()
            StartAlert()
        }
    }
    func StartAlert()
    {
        let alert = UIAlertController(title: "Menu", message: "Start The Game", preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "Start", style: UIAlertAction.Style.default,handler: {
            UIAlertAction in self.StartTheGame()
            
        })
        alert.addAction(alertAction)
        present(alert, animated: true)
        
    }
    func StartTimer()
    {
        timeCounter=10
        lblTimeCount.text = String(timeCounter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimesUpOnGame), userInfo: nil, repeats: true)
        
    }

    
    
}

