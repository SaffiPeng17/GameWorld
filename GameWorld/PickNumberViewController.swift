//
//  PickNumberViewController.swift
//  GameWorld
//
//  Created by Saffi on 2018/7/16.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit

class PickNumberViewController: UIViewController {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var guessTimes: UILabel!

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
    @IBAction func touchOKButton(_ sender: Any) {
        let inputNumber = (inputTextField.text == nil) ? 1 : Int(inputTextField.text!)!
        if Int(inputTextField.text!)! == guessNumber {
            descriptionLabel.textColor = .green
            descriptionLabel.text = "答對了！答案就是 \(guessNumber)！"
        } else {
            checkNumber(inputNumber)
            descriptionLabel.textColor = .red
            descriptionLabel.text = "\(range.min) ~ \(range.max)"
        }
        count += 1
        guessTimes.text = "猜測次數：\(count.description)"
    }

    //MARK: - functions
    func checkNumber(_ number: Int) {
        if number > guessNumber {
            range.max = number
        } else if number < guessNumber {
            range.min = number
        }
    }
}

