//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by SnoopyKing on 2017/12/13.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
protocol delegateProtocol {
    func newCityName(city: String)
}
class SecondViewController: UIViewController {
    
    var delegate: delegateProtocol?
    
    @IBAction func goBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var cityTextField: UITextField!
    @IBAction func getCityButton(_ sender: UIButton) {
        if cityTextField.text != "" {
            let input = cityTextField.text
            delegate?.newCityName(city: input!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
