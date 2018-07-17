//
//  SayTheWordsViewController.swift
//  GameWorld
//
//  Created by Xinhui Peng on 2018/7/17.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit

class SayTheWordsViewController: UIViewController {

    @IBOutlet weak var sentence: UILabel!
    
    var model = ["靠杯", "不要這樣", "好啊", "我要吃水果", "你很煩耶", "我想要去英國", "你說什麼", "我想看飢餓遊戲", "我是柯粉", "我是笨蛋", "你北七喔",
                 "想要花錢", "我想買Benz", "我要請假", "排骨酥湯", "昨天晚上吃什麼", "匯10萬塊給你", "買！都買", "帶你去吃好吃的", "我的錢就是你的錢",
                 "加油"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button events
    @IBAction func createSentneceButton(_ sender: Any) {
        let idx = Int(arc4random_uniform(UInt32(model.count)))
        sentence.text = model[idx]
    }

}
