//
//  ViewController.swift
//  WeatherApp
//
//  Created by SnoopyKing on 2017/10/20.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class ViewController: UIViewController, delegateProtocol {
    func newCityName(city: String) {
//        print(city)
        SVProgressHUD.show(withStatus: "Loading")
        let keys: [String:String] = ["q":city, "appid": apikey]
        getWeatherData(url: openWeatherMapLink, keys: keys)
    }
    

    let openWeatherMapLink = "http://api.openweathermap.org/data/2.5/weather"
    let apikey = "6eb3fe49c49010ad9a4e3876db9b710b"
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let latitude = String(22.657497)
        let longitude = String(120.286261)
        let inputs : [String:String] = ["lat": latitude,"lon":longitude,"appid":apikey]
        getWeatherData(url: openWeatherMapLink, keys: inputs)

        
    }
    private func getWeatherData(url: String, keys: [String:String]) {
        Alamofire.request(url, method: HTTPMethod.get, parameters: keys, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let weatherJSONData: JSON  = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSONData)
                print(weatherJSONData)
            } else {
                print("error \(String(describing: response.result.error))")
            }
        }
    }
    func updateWeatherData(json:JSON) {
        if let tempeture = json["main"]["temp"].double {
            weatherDataModel.tempeture = Int(tempeture - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        }else {
            cityLabel.text = "連線失敗"
        }
        updateUI()
    }
    func updateUI() {
        temperatureLabel.text = "\(weatherDataModel.tempeture)℃"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        cityLabel.text = weatherDataModel.city
        SVProgressHUD.dismiss()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSecondView" {
            let destination = segue.destination as! SecondViewController
            destination.delegate = self
        }
    }
}

