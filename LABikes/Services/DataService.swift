//
//  DataService.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import CoreLocation

class DataService: FetchBikeDataServiceContract {

    weak var bikeDataDisplayDelegate: BikeDataDisplay?

    init(bikeDataDisplayDelegate: BikeDataDisplay) {
        self.bikeDataDisplayDelegate = bikeDataDisplayDelegate
    }

    func fetchBikeData(currentLocation: CLLocation) {
        guard let url = URL(string: URL_STRING) else {
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
                                    bikes.append(bike)
                                } else {
                                    print("Bike Dics are NIL")
                                }
                            }
                            if let delegate = self.bikeDataDisplayDelegate {
                                DispatchQueue.main.async {
                                    delegate.displayBikeData(bikes: bikes)
                                }
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}



