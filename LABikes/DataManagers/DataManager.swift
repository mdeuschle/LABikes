//
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
            if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSON {
                if let objects = object["features"] as? [JSON] {
                    objects.forEach { bike in
                        if let coordinatesDic = bike["geometry"] as? JSON,
                            let propertiesDic = bike["properties"] as? JSON,
                            let location = Location.shared.location {
                            if let bike = Bike(coordinatesDic: coordinatesDic, propertiesDic: propertiesDic, currentLocation: location) {
                                checkIfFavorite(bike: bike)
                                bikes.append(bike)
                            }
                        }
                    }
                }
            }
        } catch { }
        bikes.sort(by: { $0.distance < $1.distance })
    }

    func convertDataToTemperature(data: Data?) -> String? {
        var temp: String?
        do {
            if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSON {
                if let main = object["main"] as? JSON {
                    if let temperature = main["temp"] as? Double {
                        temp = KelvinToFahrenheitConverter(kelvin: temperature).convert()
                    }
                }
            }
        } catch { }
        return temp
    }

    func convertDataToIconURL(data: Data?) -> String? {
        var url: String?
        do {
            if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSON {
                if let weather = object["weather"] as? [JSON] {
                    if let weatherDic = weather.first {
                        if let iconString = weatherDic["icon"] as? String {
                            url = "http://openweathermap.org/img/w/\(iconString).png"
                        }
                    }
                }
            }
        } catch { }
        return url
    }

    func convertDataToWeatherImage(data: Data?) -> UIImage {
        guard let image = UIImage(data: data!) else {
            return UIImage()
        }
        return image
    }

    func checkIfFavorite(bike: Bike) {
        Dao().unarchiveFavorites().forEach { favoriteBike in
            if favoriteBike.kioskId == bike.kioskId {
                bike.adjustFavorite(isFavorite: true)
            }
        }
    }
}










