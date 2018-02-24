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
    var detail: String!

    init(bike: Bike) {
        self.bike = bike
    }

    var stationDetails: [Detail] {

        var favorite = Detail(bike: bike)
        favorite.label = "Favorite?"
        let favoriteLabel = bike.isFavorite ? "YES" : "NO"
        favorite.detail = favoriteLabel

        var name = Detail(bike: bike)
        name.label = "Name"
        name.detail = bike.name

        var totalDocks = Detail(bike: bike)
        totalDocks.label = "Total Docks"
        totalDocks.detail = "\(bike.totalDocks)"

        var open = Detail(bike: bike)
        open.label = "Open Time"
        open.detail = "\(bike.openTime.twentyFourToTwelve)"

        var close = Detail(bike: bike)
        close.label = "Close Time"
        close.detail = "\(bike.closeTime.twentyFourToTwelve)"

        var kioskID = Detail(bike: bike)
        kioskID.label = "Kiosk ID"
        kioskID.detail = "\(bike.kioskId)"

        return [favorite, name, totalDocks, open, close, kioskID]
    }

    var statusDetails: [Detail] {

        var bikesAvailable = Detail(bike: bike)
        bikesAvailable.label = "Bikes Available"
        bikesAvailable.detail = "\(bike.bikesAvailable)"

        var kioskStatus = Detail(bike: bike)
        kioskStatus.label = "Kiosk Status"
        kioskStatus.detail = "\(bike.kioskStatus)"

        var kioskConnection = Detail(bike: bike)
        kioskConnection.label = "Kiosk Connection"
        kioskConnection.detail = "\(bike.kioskPublicStatus)"

        return [bikesAvailable, kioskStatus, kioskConnection]
    }

    var locationDetails: [Detail] {

        var distance = Detail(bike: bike)
        distance.label = "Distance"
        let miles = bike.miles == String(1.0) ? "\(String(bike.miles)) mile" : "\(String(bike.miles)) miles"
        distance.detail = miles

        var address = Detail(bike: bike)
        address.label = "Address"
        address.detail = "\(bike.addressStreet), \(bike.addressCity) \(bike.addressState) \(bike.addressZipCode)"

        var latitude = Detail(bike: bike)
        latitude.label = "Latitude"
        latitude.detail = "\(bike.latitude)"

        var longitude = Detail(bike: bike)
        longitude.label = "Longitude"
        longitude.detail = "\(bike.longitude)"

        return [distance, address, latitude, longitude]
    }
}

