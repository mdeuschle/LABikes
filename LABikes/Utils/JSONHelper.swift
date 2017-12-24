//
//  JSONHelper.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/20/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

struct JSONHelper {

    static let shared = JSONHelper()

    func convertJSONObjectToBikes(object: [String: Any]) -> [Bike]? {
        var bikes = [Bike]()
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
        return bikes
    }
}

private func checkIfFavorite(bike: Bike) {
    for favoriteBike in Dao().unarchiveFavorites() {
        if favoriteBike.kioskId == bike.kioskId {
            bike.adjustFavorite(isFavorite: true)
        }
    }
}








