//
//  DataService.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import CoreLocation

class DataService {

    static let shared = DataService()

    func fetchBikeData(currentLocation: CLLocation, completion: @escaping (Bool, [Bike]?) -> Void) {
        guard let url = URL(string: URL_STRING) else {
            completion(false, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                do {
                    if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        if let objects = object["features"] as? [[String: Any]] {
                            var bikes = [Bike]()
                            for bike in objects {
                                if let coordinatesDic = bike["geometry"] as? [String: Any],
                                    let propertiesDic = bike["properties"] as? [String: Any] {
                                    let bike = Bike(coordinatesDic: coordinatesDic, propertiesDic: propertiesDic, currentLocation: currentLocation)
                                    self.checkIfFavorite(bike: bike)
                                    bikes.append(bike)
                                } else {
                                    completion(false, nil)
                                    print("Bike Dics are NIL")
                                }
                            }
                            DispatchQueue.main.async {
                                bikes.sort(by: { $0.distance < $1.distance })
                                completion(true, bikes)
                            }
                        } else {
                            completion(false, nil)
                        }
                    } else {
                        completion(false, nil)
                    }
                } catch {
                    print(error)
                }
            } else {
                completion(false, nil)
            }
        }
        task.resume()
    }

    private func checkIfFavorite(bike: Bike) {
        for favoriteBike in Dao().unarchiveFavorites() {
            if favoriteBike.kioskId == bike.kioskId {
                bike.adjustFavorite(isFavorite: true)
            }
        }
    }
}



