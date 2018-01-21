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

    private(set) public var latitude: Double!
    private(set) public var longitude: Double!
    private(set) public var addressStreet: String!
    private(set) public var addressCity: String!
    private(set) public var addressState: String!
    private(set) public var addressZipCode: String!
    private(set) public var bikesAvailable: Int!
    private(set) public var closeTime: String!
    private(set) public var kioskId: Int!
    private(set) public var kioskPublicStatus: String!
    private(set) public var kioskStatus: String!
    private(set) public var name: String!
    private(set) public var openTime: String!
    private(set) public var totalDocks: Int!
    private(set) public var trikesAvailable: Int!
    private(set) public var kioskConnectionStatus: String!
    private(set) public var coordinate2D: CLLocationCoordinate2D!
    private(set) public var distance: Double!
    private(set) public var isFavorite = false
    private(set) public var mapIcon: MapIcon!

    var miles: String {
        let miles = distance * 0.000621371
        let bikeMiles = Double(round(10 * miles)/10)
        return "\(bikeMiles) mi"
    }

    init(coordinatesDic: [String: Any], propertiesDic: [String: Any], currentLocation: CLLocation) {
        let coordDic = coordinatesDic["coordinates"] as? [Double] ?? [0.0, 0.0]
        longitude = coordDic[0]
        latitude = coordDic[1]
        addressStreet = propertiesDic["addressStreet"] as? String ?? ""
        addressCity = propertiesDic["addressCity"] as? String ?? ""
        addressState = propertiesDic["addressState"] as? String ?? ""
        addressZipCode = propertiesDic["addressZipCode"] as? String ?? ""
        bikesAvailable = propertiesDic["bikesAvailable"] as? Int ?? 0
        closeTime = propertiesDic["closeTime"] as? String ?? ""
        kioskId = propertiesDic["kioskId"] as? Int ?? 0
        kioskPublicStatus = propertiesDic["kioskPublicStatus"] as? String ?? ""
        kioskStatus = propertiesDic["kioskStatus"] as? String ?? ""
        name = propertiesDic["name"] as? String ?? ""
        openTime = propertiesDic["openTime"] as? String ?? ""
        totalDocks = propertiesDic["totalDocks"] as? Int ?? 0
        trikesAvailable = propertiesDic["trikesAvailalbe"] as? Int ?? 0
        kioskConnectionStatus = propertiesDic["kioskConnectionStatus"] as? String ?? ""
        distance = currentLocation.distance(from: CLLocation(latitude: latitude, longitude: longitude))
        coordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        isFavorite = false
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
        kioskId = aDecoder.decodeInteger(forKey: "kioskId")
        name = aDecoder.decodeObject(forKey: "name") as? String
        addressStreet = aDecoder.decodeObject(forKey: "addressStreet") as? String
        bikesAvailable = aDecoder.decodeInteger(forKey: "bikesAvailable")
        totalDocks = aDecoder.decodeInteger(forKey: "totalDocks")
        distance = aDecoder.decodeDouble(forKey: "distance")
        isFavorite = aDecoder.decodeBool(forKey: "isFavorite")
        addressCity = aDecoder.decodeObject(forKey: "addressCity") as? String
        addressState = aDecoder.decodeObject(forKey: "addressState") as? String
        addressZipCode = aDecoder.decodeObject(forKey: "addressZipCode") as? String
        openTime = aDecoder.decodeObject(forKey: "openTime") as? String
        closeTime = aDecoder.decodeObject(forKey: "closeTime") as? String
        kioskStatus = aDecoder.decodeObject(forKey: "kioskStatus") as? String
        kioskPublicStatus = aDecoder.decodeObject(forKey: "kioskPublicStatus") as? String
        kioskConnectionStatus = aDecoder.decodeObject(forKey: "kioskConnectionStatus") as? String
    }

    func encode(with aCoder: NSCoder) {
        if let kioskId = kioskId, let name = name, let addressStreet = addressStreet, let bikesAvailable = bikesAvailable, let distance = distance, let totalDocks = totalDocks, let addressCity = addressCity, let addressState = addressState, let addressZipCode = addressZipCode, let openTime = openTime, let closeTime = closeTime, let kioskStatus = kioskStatus, let kioskPublicStatus = kioskPublicStatus, let kioskConnectionStatus = kioskConnectionStatus {
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
        }
    }

    func getFavoriteIndex(favorites: [Bike]) -> Int? {
        return favorites.index(where: { $0.kioskId == self.kioskId })
    }

    func adjustFavorite(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}







