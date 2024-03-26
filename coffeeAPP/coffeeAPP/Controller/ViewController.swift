//
//  ViewController.swift
//  coffeeAPP
//
//  Created by 郭家宇 on 2024/3/25.
//

import UIKit

class ViewController: UIViewController {

    let cities=["taipei","yilan","taoyuan","hsinchu","miaoli","taichung","changhua","Nantou","Yunlin","Chiayi","Tainan","Kaohsiung","Pingtung"]
    let apiUrlString = "https://cafenomad.tw/api/v1.2/cafes"
    
    var pickView = UIPickerView()
    var coffees = [CaseInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

