//
//  TwoViewController.swift
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/3/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

import UIKit

@objc(TwoViewController)

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor();
        self.fd_interactivePopDisabled = true;
        // Do any additional setup after loading the view.
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
