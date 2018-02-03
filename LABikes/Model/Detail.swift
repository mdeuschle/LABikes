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
    private(set) public var image: UIImage!

    init(bike: Bike) {
        self.bike = bike
    }

    func getDetails() -> [Detail] {

        var nameDetail = Detail(bike: bike)
        nameDetail.label = "NAME"
        nameDetail.detail = bike.name
        nameDetail.image = "🚴".emojiToImage()

        var bikesAvailable = Detail(bike: bike)
        bikesAvailable.label = "BIKES AVAILABLE"
        bikesAvailable.detail = "Bikes Available: \(String(bike.bikesAvailable)) | Total Docks: \(String(bike.totalDocks))"
        if bike.bikesAvailable <= 0 {
            bikesAvailable.image = "👎".emojiToImage()
        } else {
            bikesAvailable.image = "👍".emojiToImage()
        }

        var distance = Detail(bike: bike)
        distance.label = "DISTANCE"
        let miles = bike.miles == String(1.0) ? "\(String(bike.miles)) mile" : "\(String(bike.miles)) miles"
        distance.detail = miles
        distance.image = "🗺".emojiToImage()

        var addressDetail = Detail(bike: bike)
        addressDetail.label = "ADDRESS"
        addressDetail.detail = "\(bike.addressStreet), \(bike.addressCity) \(bike.addressState) \(bike.addressZipCode)"
        addressDetail.image = "🌇".emojiToImage()

        var favorite = Detail(bike: bike)
        favorite.label = "ONE OF MY FAVORITES?"
        let favoriteLabel = bike.isFavorite ? "YES" : "NO"
        favorite.detail = favoriteLabel
        if bike.isFavorite {
            favorite.image = "😍".emojiToImage()
        } else {
            favorite.image = "😕".emojiToImage()
        }

        var time = Detail(bike: bike)
        time.label = "OPEN & CLOSE TIMES"
        time.detail = "OPENS @ \(bike.openTime.twentyFourToTwelve) | CLOSES @ \(bike.closeTime.twentyFourToTwelve)"
        time.image = "⏰".emojiToImage()

        var latAndLon = Detail(bike: bike)
        latAndLon.label = "LATITUDE & LONGITUDE"
        latAndLon.detail = "LAT: \(String(bike.latitude)) | LON: \(String(bike.longitude))"
        latAndLon.image = "🗺".emojiToImage()

        var kioskStatus = Detail(bike: bike)
        kioskStatus.label = "KIOSK STATUS"
        kioskStatus.detail = "\(bike.kioskStatus) & \(bike.kioskConnectionStatus)"
        if bike.kioskPublicStatus == "Active"{
            kioskStatus.image = "✅".emojiToImage()
        } else {
            kioskStatus.image = "❌".emojiToImage()
        }

        var kioskID = Detail(bike: bike)
        kioskID.label = "KIOSK ID"
        kioskID.detail = String(bike.kioskId)
        kioskID.image = "🆔".emojiToImage()

        var thankYou = Detail(bike: bike)
        thankYou.label = "TACOS"
        thankYou.detail = "Are yummy!"
        thankYou.image = "🌮".emojiToImage()

        return [nameDetail, bikesAvailable, favorite, distance, addressDetail, latAndLon, time, kioskStatus, kioskID, thankYou]
    }
}

