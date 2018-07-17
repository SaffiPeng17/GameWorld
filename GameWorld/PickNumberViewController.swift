//
//  PickNumberViewController.swift
//  GameWorld
//
//  Created by Saffi on 2018/7/16.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit


enum GuessNumber {
    case single
    case multiple
}

class PickNumberViewController: UIViewController {

    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet weak var singleView: UIStackView!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var guessTimes: UILabel!
    
    var gameType: GuessNumber = .single
    var guessNumber = 0
    var range = (min: 1, max: 100)
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //點一下Keyboard以外的地方，會收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //MARK: - Button events
    @IBAction func segmentCtrlChanged(_ sender: UISegmentedControl) {
        gameType = (sender.selectedSegmentIndex == 1) ? .multiple : .single
        singleView.isHidden = (sender.selectedSegmentIndex == 1)
    }
    
    @IBAction func touchOKButton(_ sender: Any) {
        count += 1
        guessTimes.text = "猜測次數：\(count.description)"
        let inputNumber = (inputTextField.text == nil) ? 1 : Int(inputTextField.text!)!
        if Int(inputTextField.text!)! == guessNumber {
            let message = "答對了！答案就是 \(guessNumber)！\n\(guessTimes.text!)"
            let alert = UIAlertController(title: "Congratulation", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.newGame()
            }))
            present(alert, animated: true)
        } else {
            checkNumber(inputNumber)
            descriptionLabel.text = "\(range.min) ~ \(range.max)"
        }
    }

    //MARK: - functions
    func newGame() {
        guessNumber = Int(arc4random_uniform(100))+1
        range = (min: 1, max: 100)
        count = 0
        
        inputTextField.text = ""
        descriptionLabel.text = ""
        guessTimes.text = ""
    }
    
    func checkNumber(_ number: Int) {
        if number > guessNumber {
            range.max = number
        } else if number < guessNumber {
            range.min = number
        }
    }
}

