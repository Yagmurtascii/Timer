//
//  ViewController.swift
//  TimerProject
//
//  Created by Yagmur on 16.07.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var create: UIButton!
    
    @IBOutlet weak var minute: UITextField!
    
    var minutes = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        create.layer.cornerRadius = 25
        create.layer.masksToBounds = true
    }
    func createAlert(messages: String)
    {
        let alert = UIAlertController (title: "Error", message: messages, preferredStyle: UIAlertController.Style.alert)
        
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        
        alert.addAction(button)
        self.present(alert, animated: true)
    }

    @IBAction func create(_ sender: Any) {
    
        if minute.text == ""
        {
            createAlert(messages: "This field must not be empty")
        }
        else
        {
            minutes = minute.text!
        }
        if let min = Int32(minutes)
        {
            if min >= 100 || min < 1
            {
                createAlert(messages: "Check the value is between 0-100.")
            }
    
            else
            {
                performSegue(withIdentifier: "toTimeVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toTimeVC")
        {
            let destinationVC = segue.destination as! TimerViewController
            destinationVC.number = minutes
        }
    }
    
}

