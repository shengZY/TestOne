//
//  TwoViewController.swift
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/3/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit
import Charts

@objc(TwoViewController)

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor();
        // Do any additional setup after loading the view.
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        if convertedNumber != nil {
            print("convertedNumber contains some interger value")
        }
        
//        let age = -3
//        assert(age>=0 , "a person's age cannot be less than zero")
        var a  = 1
        a += 2
        print(a)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
