//
//  Bike.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation
import CoreLocation

struct Bike {
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
    var miles: String {
        get {
            let miles = distance * 0.000621371
            let bikeMiles = Double(round(10 * miles)/10)
            return "\(bikeMiles) mi"
        }
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
    }
}


