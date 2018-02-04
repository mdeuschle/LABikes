//
//  Detail.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/15/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

struct Detail {

    let bike: Bike!
    private(set) public var label: String!
    private(set) public var detail: String!

    init(bike: Bike) {
        self.bike = bike
    }

    func stationDetails() -> [Detail] {

        var favorite = Detail(bike: bike)
        favorite.label = "FAVORITE?"
        let favoriteLabel = bike.isFavorite ? "YES" : "NO"
        favorite.detail = favoriteLabel

        var name = Detail(bike: bike)
        name.label = "NAME"
        name.detail = bike.name

        var totalDocks = Detail(bike: bike)
        totalDocks.label = "TOTAL DOCKS"
        totalDocks.detail = "\(bike.totalDocks)"

        var open = Detail(bike: bike)
        open.label = "OPEN TIME"
        open.detail = "\(bike.openTime.twentyFourToTwelve)"

        var close = Detail(bike: bike)
        close.label = "CLOSE TIME"
        close.detail = "\(bike.closeTime.twentyFourToTwelve)"

        var kioskID = Detail(bike: bike)
        kioskID.label = "KIOSK ID"
        kioskID.detail = "\(bike.kioskId)"

        return [favorite, name, totalDocks, open, close, kioskID]
    }

    func statusDetails() -> [Detail] {

        var bikesAvailable = Detail(bike: bike)
        bikesAvailable.label = "BIKES AVAILABLE"
        bikesAvailable.detail = "\(bike.bikesAvailable)"

        var kioskStatus = Detail(bike: bike)
        kioskStatus.label = "KIOSK STATUS"
        kioskStatus.detail = "\(bike.kioskStatus)"

        var kioskConnection = Detail(bike: bike)
        kioskConnection.label = "KIOSK CONNECTION"
        kioskConnection.detail = "\(bike.kioskPublicStatus)"

        return [bikesAvailable, kioskStatus, kioskConnection]
    }

    func locationDetails() -> [Detail] {

        var distance = Detail(bike: bike)
        distance.label = "DISTANCE"
        let miles = bike.miles == String(1.0) ? "\(String(bike.miles)) mile" : "\(String(bike.miles)) miles"
        distance.detail = miles

        var address = Detail(bike: bike)
        address.label = "ADDRESS"
        address.detail = "\(bike.addressStreet), \(bike.addressCity) \(bike.addressState) \(bike.addressZipCode)"

        var latitude = Detail(bike: bike)
        latitude.label = "LATITUDE"
        latitude.detail = "\(bike.latitude)"

        var longitude = Detail(bike: bike)
        longitude.label = "LONGITUDE"
        longitude.detail = "\(bike.longitude)"

        return [distance, address, latitude, longitude]
    }
}

