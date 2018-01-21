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
        bikesAvailable.label = "BIKES AVAILALBE"
        bikesAvailable.detail = String(bike.bikesAvailable)
        if bike.bikesAvailable <= 0 {
            bikesAvailable.image = "👎".emojiToImage()
        } else {
            bikesAvailable.image = "👍".emojiToImage()
        }
        var totalDocks = Detail(bike: bike)
        totalDocks.label = "TOTAL DOCKS"
        totalDocks.detail = String(bike.totalDocks)
        totalDocks.image = "👉".emojiToImage()
        var distance = Detail(bike: bike)
        distance.label = "DISTANCE"
        distance.detail = bike.miles
        distance.image = "🗺".emojiToImage()
        var addressDetail = Detail(bike: bike)
        addressDetail.label = "ADDRESS"
        addressDetail.detail = bike.addressStreet
        addressDetail.image = "🗺".emojiToImage()
        var city = Detail(bike: bike)
        city.label = "CITY"
        city.detail = bike.addressCity
        city.image = "🌇".emojiToImage()
        var state = Detail(bike: bike)
        state.label = "STATE"
        state.detail = bike.addressState
        state.image = "🗺".emojiToImage()
        var zipCode = Detail(bike: bike)
        zipCode.label = "ZIP CODE"
        zipCode.detail = bike.addressZipCode
        zipCode.image = "📭".emojiToImage()
        var favorite = Detail(bike: bike)
        favorite.label = "ONE OF MY FAVORITES?"
        let favoriteLabel = bike.isFavorite ? "YES" : "NO"
        favorite.detail = favoriteLabel
        if bike.isFavorite {
            favorite.image = "😍".emojiToImage()
        } else {
            favorite.image = "🙁".emojiToImage()
        }
        var openTime = Detail(bike: bike)
        openTime.label = "OPEN TIME"
        openTime.detail = bike.openTime.twentyFourToTwelve
        openTime.image = "🕚".emojiToImage()
        var closeTime = Detail(bike: bike)
        closeTime.label = "CLOSE TIME"
        closeTime.detail = bike.closeTime.twentyFourToTwelve
        closeTime.image = "🕛".emojiToImage()
        var kioskStatus = Detail(bike: bike)
        kioskStatus.label = "KIOSK STATUS"
        kioskStatus.detail = bike.kioskStatus
        if bike.kioskStatus == "FullService" {
            kioskStatus.image = "✅".emojiToImage()
        }
        var kioskPublicStatus = Detail(bike: bike)
        kioskPublicStatus.label = "KIOSK PUBLIC STATUS"
        kioskPublicStatus.detail = bike.kioskPublicStatus
        if bike.kioskPublicStatus == "Active" {
            kioskPublicStatus.image = "✅".emojiToImage()
        }
        var kioskConnectionStatus = Detail(bike: bike)
        kioskConnectionStatus.label = "KIOSK CONNECTION STATUS"
        kioskConnectionStatus.detail = bike.kioskConnectionStatus
        if bike.kioskPublicStatus == "Active" {
            kioskConnectionStatus.image = "✅".emojiToImage()
        }
        var kioskID = Detail(bike: bike)
        kioskID.label = "KIOSK ID"
        kioskID.detail = String(bike.kioskId)
        kioskID.image = "🆔".emojiToImage()
        var thankYou = Detail(bike: bike)
        thankYou.label = "THANK YOU"
        thankYou.detail = "Thank you for downloading LABikes!"
        thankYou.image = "🤓".emojiToImage()
        return [nameDetail, bikesAvailable, totalDocks, distance, addressDetail, city, state, zipCode, favorite, openTime, closeTime, kioskStatus, kioskPublicStatus, kioskConnectionStatus, kioskID, thankYou]
    }
}

