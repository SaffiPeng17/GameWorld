//
//  ViewController.swift
//  GameWorld
//
//  Created by Saffi on 2018/7/16.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "guessnumber" {
            let destController = segue.destination as! PickNumberViewController
            destController.guessNumber = Int(arc4random_uniform(100))+1
        }
    }
}

