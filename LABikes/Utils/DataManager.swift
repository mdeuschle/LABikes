//
//  JSONHelper.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/20/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class DataManager {

    static let shared = DataManager()

    var bikes = [Bike]()

    func convertDataToBikes(data: Data?) {
        do {
            if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                if let objects = object["features"] as? [[String: Any]] {
                    for bike in objects {
                        if let coordinatesDic = bike["geometry"] as? [String: Any],
                            let propertiesDic = bike["properties"] as? [String: Any],
                            let location = Location.shared.location {
                            let bike = Bike(coordinatesDic: coordinatesDic, propertiesDic: propertiesDic, currentLocation: location)
                            checkIfFavorite(bike: bike)
                            bikes.append(bike)
                        } else {
                            print("Unable to parson JSON")
                        }
                    }
                } else {
                    print("Unable to parson JSON")
                }
            }
        } catch {
            print(error)
        }
        bikes.sort(by: { $0.distance < $1.distance })
    }

    func convertDataToTemperature(data: Data?) -> String? {
        var temp: String?
        do {
            if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                if let main = object["main"] as? [String: Any] {
                    if let temperature = main["temp"] as? Double {
                        temp = KelvinToFahrenheitConverter(kelvin: temperature).convert()
                    }
                }
            }
        } catch {
            print(error)
        }
        return temp
    }

    func convertDataToIconURL(data: Data?) -> String? {
        var url: String?
        do {
            if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                if let weather = object["weather"] as? [[String: Any]] {
                    if let weatherDic = weather.first {
                        if let iconString = weatherDic["icon"] as? String {
                            url = "http://openweathermap.org/img/w/\(iconString).png"
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
        return url
    }

    func convertDataToWeatherImage(data: Data?) -> UIImage {
        var result = UIImage()
        if let image = UIImage(data: data!) {
            result = image
        }
        return result
    }

    func checkIfFavorite(bike: Bike) {
        for favoriteBike in Dao().unarchiveFavorites() {
            if favoriteBike.kioskId == bike.kioskId {
                bike.adjustFavorite(isFavorite: true)
            }
        }
    }
}










