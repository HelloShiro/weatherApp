//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by SnoopyKing on 2017/12/12.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit

class WeatherDataModel {
    var tempeture: Int = 0;
    var condition: Int = 0;
    var city: String = "";
    var weatherIconName: String = "";
    
    func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...232:
            return "thunderstorm"
        case 300...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "mist"
        case 800:
            return "sunny"
        case 801...804:
            return "clouds"
        default:
            return "thunderstorm"
        }
    }
}
