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

class TwoViewController: UIViewController ,UITextFieldDelegate {
    var textfield : ZYAnimationTextfield! /** textfield */
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
        

        let array = ["2","3","5","7","9","11","5","7","3","2"]
        let orderArray =  array.sort { (first, second) -> Bool in
            first < second
        }
        print(orderArray)
        let set  = Set(orderArray)
        print(set)
        
        
        var lastArray :Array<AnyObject> = []
        for item in set {
            var originalArray :Array<String> = []
            for original in orderArray {
                if original == item {
                    originalArray.append(item)
                }
            }
            
            lastArray.append(originalArray)
        }
        print(lastArray)
        textfield =  ZYAnimationTextfield.init(frame: CGRectMake(40, 100, kSCreenWith - 80, 84) ,viewType: ZYTextfieldViewType.VerCode,delegate: self)
        textfield.descriptionLabel.text = "请输入用户名"
        textfield.verTimeLbl.text = "获取验证码"
        textfield.borderColor(UIColor.redColor())
        textfield.verButton.addTarget(self, action: #selector(TwoViewController.verCodeButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(textfield)
    }
    func verCodeButtonClicked(button:UIButton) {
        print("get vercode")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getPriousorLaterDateFormDate(date:NSDate , day : Int) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.day = day
        let calender = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let mdate =  calender?.dateByAddingComponents(dateComponents, toDate: date, options: NSCalendarOptions.WrapComponents)
        return mdate!
    }
    
    func makeXValues() -> [String] {
        var dateArr = [ String ]()
        let currentDate = NSDate()
        let labelFormatter = NSDateFormatter()
        labelFormatter.dateFormat = "MMM-dd"
        for i  in -4..<2 {
            let date  = getPriousorLaterDateFormDate(currentDate, day: i)
            let dateStr = labelFormatter.stringFromDate(date)
            dateArr.append(dateStr)
        }
        return dateArr
    }
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        if range.location > 5 {
//            return false
//        }
//        return true
//    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textfield.textfield.resignFirstResponder()
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
