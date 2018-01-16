//
//  Detail.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/15/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import Foundation

struct Detail {

    let bike: Bike!
    private(set) public var label: String!
    private(set) public var detail: String!

    init(bike: Bike) {
        self.bike = bike
    }

    func getDetails() -> [Detail] {
        var nameDetail = Detail(bike: bike)
        nameDetail.label = "NAME"
        nameDetail.detail = bike.name
        var addressDetail = Detail(bike: bike)
        addressDetail.label = "ADDRESS"
        addressDetail.detail = bike.addressStreet
        var distance = Detail(bike: bike)
        distance.label = "DISTANCE"
        distance.detail = bike.miles
        var city = Detail(bike: bike)
        city.label = "CITY"
        city.detail = bike.addressCity
        var state = Detail(bike: bike)
        state.label = "STATE"
        state.detail = bike.addressState
        var zipCode = Detail(bike: bike)
        zipCode.label = "ZIP CODE"
        zipCode.detail = bike.addressZipCode
        var favorite = Detail(bike: bike)
        favorite.label = "FAVORITE?"
        favorite.detail = "\(bike.isFavorite)"
        var openTime = Detail(bike: bike)
        openTime.label = "OPEN TIME"
        openTime.detail = bike.openTime
        var closeTime = Detail(bike: bike)
        closeTime.label = "CLOSE TIME"
        closeTime.detail = bike.closeTime
        var totalDocks = Detail(bike: bike)
        totalDocks.label = "TOTAL DOCKS"
        totalDocks.detail = "\(bike.totalDocks)"
        var kioskStatus = Detail(bike: bike)
        kioskStatus.label = "KIOSK STATUS"
        kioskStatus.detail = bike.kioskStatus
        var kioskPublicStatus = Detail(bike: bike)
        kioskPublicStatus.label = "KIOSK PUBLIC STATUS"
        kioskPublicStatus.detail = bike.kioskPublicStatus
        var kioskConnectionStatus = Detail(bike: bike)
        kioskConnectionStatus.label = "KIOSK CONNECTION STATUS"
        kioskConnectionStatus.detail = bike.kioskConnectionStatus

        return [nameDetail, addressDetail, distance, city, state, zipCode, favorite, openTime, closeTime, totalDocks, kioskStatus, kioskPublicStatus, kioskConnectionStatus]
    }
}

