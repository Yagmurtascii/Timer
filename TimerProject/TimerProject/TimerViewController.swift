//
//  TimerViewController.swift
//  TimerProject
//
//  Created by Yagmur on 16.07.2024.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {

    @IBOutlet weak var minuteFirstDigitLabel: UILabel!
    @IBOutlet weak var minuteSecondDigitLabel: UILabel!
    @IBOutlet weak var start: UIButton!
    
    @IBOutlet weak var nav: UINavigationItem!
    
    var audio : AVAudioPlayer?
    var number = ""
    var minuteFirstDigit : Int64 = 0
    var minuteSecondDigit : Int64 = 0

    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = "Custom Back"
        self.nav.backBarButtonItem = backButton
        minuteFirstDigitLabel.layer.cornerRadius = 50
        minuteFirstDigitLabel.layer.masksToBounds = true
        minuteSecondDigitLabel.layer.cornerRadius = 50
        minuteSecondDigitLabel.layer.masksToBounds = true
        start.layer.cornerRadius = 25
        start.layer.masksToBounds = true
        iniatializeSound(soundName: "click")
        digits()
    }
    override func viewWillDisappear(_ animated: Bool) {
          
        timer.invalidate()
           audio?.stop() // Stop audio when navigating away from the view
       }
    func iniatializeSound(soundName: String)
    {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
                    let url = URL(fileURLWithPath: path)
                    do {
                        audio = try AVAudioPlayer(contentsOf: url)
                    } catch {
                        print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
                    }
                }
    }
    
    func playSound() {
        audio?.currentTime = 0 // Rewind to start
        audio?.play()
        
    }

    func digits()
    {
        var numberString = String(number)
        if numberString.count == 1
        {
            numberString = "0" + numberString
            print(numberString)
        }
        let arrays = Array(numberString)
      
        if let firstDigit =  Int64(String(arrays[0]))
        {
            minuteFirstDigit = firstDigit
        }
            
        if let secondDigit = Int64(String(arrays[1]))
        {
            minuteSecondDigit = secondDigit
        }
    }
    
    @objc func timerFunc()
    {
       
        minuteFirstDigitLabel.text = String(minuteFirstDigit)
        minuteSecondDigitLabel.text = String(minuteSecondDigit)
        minuteSecondDigit -= 1
        playSound()
        if ( minuteSecondDigit == -1)  && minuteFirstDigit != 0
        {
           
            minuteSecondDigit = 9
            minuteFirstDigit -= 1
        }
        
        else if minuteFirstDigit == 0 && minuteSecondDigit == -1
        {
            
            minuteSecondDigit = 0
            minuteFirstDigit = 0
            timer.invalidate()
            audio?.play()
        }
        
    }
    
    
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        start.isHidden = true
    }
}


    

    


