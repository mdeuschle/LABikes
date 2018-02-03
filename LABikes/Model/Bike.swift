//
//  Bike.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import CoreLocation

class Bike: NSObject, NSCoding {

    let latitude: Double
    let longitude: Double
    let addressStreet: String
    let addressCity: String
    let addressState: String
    let addressZipCode: String
    let bikesAvailable: Int
    let closeTime: String
    let kioskId: Int
    let kioskPublicStatus: String
    let kioskStatus: String
    let name: String
    let openTime: String
    let totalDocks: Int
    let kioskConnectionStatus: String
    let coordinate2D: CLLocationCoordinate2D
    let distance: Double
    private(set) public var isFavorite = false
    let mapIcon: MapIcon
    var miles: String {
        let miles = distance * 0.000621371
        let bikeMiles = Double(round(10 * miles)/10)
        return "\(bikeMiles)"
    }

    init?(coordinatesDic: [String: Any], propertiesDic: [String: Any], currentLocation: CLLocation) {
        guard let coordDic = coordinatesDic["coordinates"] as? [Double],
            let addressStreet = propertiesDic["addressStreet"] as? String,
            let addressCity = propertiesDic["addressCity"] as? String,
            let addressState = propertiesDic["addressState"] as? String,
            let addressZipCode = propertiesDic["addressZipCode"] as? String,
            let bikesAvailable = propertiesDic["bikesAvailable"] as? Int,
            let closeTime = propertiesDic["closeTime"] as? String,
            let kioskId = propertiesDic["kioskId"] as? Int,
            let kioskPublicStatus = propertiesDic["kioskPublicStatus"] as? String,
            let kioskStatus = propertiesDic["kioskStatus"] as? String,
            let name = propertiesDic["name"] as? String,
            let openTime = propertiesDic["openTime"] as? String,
            let totalDocks = propertiesDic["totalDocks"] as? Int,
            let kioskConnectionStatus = propertiesDic["kioskConnectionStatus"] as? String else {
                return nil
        }
        self.addressStreet = addressStreet
        self.addressCity = addressCity
        self.addressState = addressState
        self.addressZipCode = addressZipCode
        self.bikesAvailable = bikesAvailable
        self.closeTime = closeTime
        self.kioskId = kioskId
        self.kioskPublicStatus = kioskPublicStatus
        self.kioskStatus = kioskStatus
        self.name = name
        self.openTime = openTime
        self.totalDocks = totalDocks
        self.kioskConnectionStatus = kioskConnectionStatus
        longitude = coordDic[0]
        latitude = coordDic[1]
        distance = currentLocation.distance(from: CLLocation(latitude: latitude, longitude: longitude))
        coordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let availablePercentage = Double(bikesAvailable) / Double(totalDocks)
        switch availablePercentage {
        case 0:
            mapIcon = .empty
        case 0.001..<0.1:
            mapIcon = .red
        case 0.1..<0.3:
            mapIcon = .quarter
        case 0.3..<0.6:
            mapIcon = .half
        case 0.6..<0.9:
            mapIcon = .threeQuarter
        case 0.9...1:
            mapIcon = .full
        default:
            mapIcon = .empty
        }
    }

    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let addressStreet = aDecoder.decodeObject(forKey: "addressStreet") as? String,
            let addressCity = aDecoder.decodeObject(forKey: "addressCity") as? String,
            let addressState = aDecoder.decodeObject(forKey: "addressState") as? String,
            let addressZipCode = aDecoder.decodeObject(forKey: "addressZipCode") as? String,
            let openTime = aDecoder.decodeObject(forKey: "openTime") as? String,
            let closeTime = aDecoder.decodeObject(forKey: "closeTime") as? String,
            let kioskStatus = aDecoder.decodeObject(forKey: "kioskStatus") as? String,
            let kioskPublicStatus = aDecoder.decodeObject(forKey: "kioskPublicStatus") as? String,
            let kioskConnectionStatus = aDecoder.decodeObject(forKey: "kioskConnectionStatus") as? String else {
                return nil
        }
        self.name = name
        self.addressStreet = addressStreet
        self.addressCity = addressCity
        self.addressState = addressState
        self.addressZipCode = addressZipCode
        self.openTime = openTime
        self.closeTime = closeTime
        self.kioskStatus = kioskStatus
        self.kioskPublicStatus = kioskPublicStatus
        self.kioskConnectionStatus = kioskConnectionStatus
        latitude = aDecoder.decodeDouble(forKey: "latitude")
        longitude = aDecoder.decodeDouble(forKey: "longitude")
        kioskId = aDecoder.decodeInteger(forKey: "kioskId")
        bikesAvailable = aDecoder.decodeInteger(forKey: "bikesAvailable")
        totalDocks = aDecoder.decodeInteger(forKey: "totalDocks")
        distance = aDecoder.decodeDouble(forKey: "distance")
        isFavorite = aDecoder.decodeBool(forKey: "isFavorite")
        coordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let availablePercentage = Double(bikesAvailable) / Double(totalDocks)
        switch availablePercentage {
        case 0:
            mapIcon = .empty
        case 0.001..<0.1:
            mapIcon = .red
        case 0.1..<0.3:
            mapIcon = .quarter
        case 0.3..<0.6:
            mapIcon = .half
        case 0.6..<0.9:
            mapIcon = .threeQuarter
        case 0.9...1:
            mapIcon = .full
        default:
            mapIcon = .empty
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(kioskId, forKey: "kioskId")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(addressStreet, forKey: "addressStreet")
        aCoder.encode(bikesAvailable, forKey: "bikesAvailable")
        aCoder.encode(totalDocks, forKey: "totalDocks")
        aCoder.encode(distance, forKey: "distance")
        aCoder.encode(isFavorite, forKey: "isFavorite")
        aCoder.encode(addressCity, forKey: "addressCity")
        aCoder.encode(addressState, forKey: "addressState")
        aCoder.encode(addressZipCode, forKey: "addressZipCode")
        aCoder.encode(openTime, forKey: "openTime")
        aCoder.encode(closeTime, forKey: "closeTime")
        aCoder.encode(kioskStatus, forKey: "kioskStatus")
        aCoder.encode(kioskPublicStatus, forKey: "kioskPublicStatus")
        aCoder.encode(kioskConnectionStatus, forKey: "kioskConnectionStatus")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }

    func getFavoriteIndex(favorites: [Bike]) -> Int? {
        return favorites.index(where: { $0.kioskId == self.kioskId })
    }

    func adjustFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}







