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
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet weak var guessPlayer1: UILabel!
    @IBOutlet weak var guessPlayer2: UILabel!
    
    var gameType: GuessNumber = .single
    var named = (player0:"邊緣人", player1: "Player 1", player2: "Player 2")
    var whoIsThere = ""
    var multiPlayerRecord = ["Player 1": [Int](), "Player 2": [Int]()]
    var guessNumber = 0
    var range = (min: 1, max: 100)

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
        newGame()
        whoIsThere = (sender.selectedSegmentIndex == 1) ? named.player1 : named.player0
        userLabel.text = "\(whoIsThere) 換你了"
    }
    
    @IBAction func touchOKButton(_ sender: Any) {
        let inputNumber = (inputTextField.text == nil) ? 1 : Int(inputTextField.text!)!
        if inputNumber == guessNumber {
            let message = (gameType == .multiple) ? "\(whoIsThere) 輸了！\n爆炸數字就是 \(guessNumber)！X_X" : "答對了！答案就是 \(guessNumber)！\n\(multiPlayerRecord["Player 1"]!.count)"
            let alert = UIAlertController(title: "Congratulation", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.newGame()
            }))
            present(alert, animated: true)
        } else {
            if checkNumber(inputNumber) {
                descriptionLabel.text = "\(range.min) ~ \(range.max)"
                inputTextField.text = ""
                //change
                if gameType == .multiple {
                    var array = multiPlayerRecord[whoIsThere]
                    array?.append(inputNumber)
                    multiPlayerRecord[whoIsThere] = array
                    guessPlayer1.text = "Player1 猜測：\(multiPlayerRecord["Player 1"]!.compactMap({String($0)}).joined(separator: ", "))"
                    guessPlayer2.text = "Player2 猜測：\(multiPlayerRecord["Player 2"]!.compactMap({String($0)}).joined(separator: ", "))"
                    
                    whoIsThere = (whoIsThere == named.player1) ? named.player2 : named.player1
                    userLabel.text = "\(whoIsThere) 換你了"
                    userLabel.textColor = (whoIsThere == named.player1) ? .blue : UIColor(red: 195/255, green: 118/255, blue: 154/255, alpha: 1)
                } else {
                    var array = multiPlayerRecord["Player 1"]
                    array?.append(inputNumber)
                    multiPlayerRecord["Player 1"] = array
                    guessPlayer1.text = "猜測：\(multiPlayerRecord["Player 1"]!.map({"\($0)"}).joined(separator: ", "))"
                }
            }
        }
    }

    //MARK: - functions
    func newGame() {
        guessNumber = Int(arc4random_uniform(100))+1
        range = (min: 1, max: 100)
        whoIsThere = ""
        multiPlayerRecord = ["Player 1": [Int](), "Player 2": [Int]()]
        
        inputTextField.text = nil
        descriptionLabel.text = (gameType == .multiple) ? "爆炸數字為 1~100 範圍內的數字" : "請輸入 1~100 範圍內的數字"
        guessPlayer1.text = (gameType == .multiple) ? "Player1 猜測紀錄：" : "猜測紀錄："
        guessPlayer2.text = "Player2 猜測紀錄："
        guessPlayer2.isHidden = !(gameType == .multiple)
    }
    
    func checkNumber(_ number: Int) -> Bool {
        guard number > range.min && number < range.max else {
            let alert = UIAlertController(title: "Error", message: "輸入的數字不在範圍內！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }
        range.max = (number > guessNumber) ? number : range.max
        range.min = (number < guessNumber) ? number : range.min

        return true
    }
}

