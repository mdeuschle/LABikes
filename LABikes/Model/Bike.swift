//
//  Bike.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

struct Bike {
    private(set) public var coordinates: [Double]!
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

    init(coordinatesDic: [String: [Double]], propertiesDic: [String: Any]) {
        self.coordinates = coordinatesDic["coordinates"] ?? [Double]()
        self.addressStreet = propertiesDic["addressStreet"] as? String ?? ""
        self.addressCity = propertiesDic["addressCity"] as? String ?? ""
        self.addressState = propertiesDic["addressState"] as? String ?? ""
        self.addressZipCode = propertiesDic["addressZipCode"] as? String ?? ""
        self.bikesAvailable = propertiesDic["bikesAvailable"] as? Int ?? 0
        self.closeTime = propertiesDic["closeTime"] as? String ?? ""
        self.kioskId = propertiesDic["kioskId"] as? Int ?? 0
        self.kioskPublicStatus = propertiesDic["kioskPublicStatus"] as? String ?? ""
        self.kioskStatus = propertiesDic["kioskStatus"] as? String ?? ""
        self.name = propertiesDic["name"] as? String ?? ""
        self.openTime = propertiesDic["openTime"] as? String ?? ""
        self.totalDocks = propertiesDic["totalDocks"] as? Int ?? 0
        self.trikesAvailable = propertiesDic["trikesAvailalbe"] as? Int ?? 0
        self.kioskConnectionStatus = propertiesDic["kioskConnectionStatus"] as? String ?? ""
    }
}

//"geometry": {
//    "coordinates": [
//    -118.25854,
//    34.0485
//    ],
//    "type": "Point"
//},
//"properties": {
//    "addressStreet": "723 Flower Street",
//    "addressCity": "Los Angeles",
//    "addressState": "CA",
//    "addressZipCode": "90017",
//    "bikesAvailable": 11,
//    "closeTime": "23:58:00",
//    "docksAvailable": 16,
//    "eventEnd": null,
//    "eventStart": null,
//    "isEventBased": false,
//    "isVirtual": false,
//    "isVisible": false,
//    "kioskId": 3005,
//    "kioskPublicStatus": "Active",
//    "kioskStatus": "FullService",
//    "name": "7th & Flower",
//    "notes": null,
//    "openTime": "00:02:00",
//    "publicText": "",
//    "timeZone": "Pacific Standard Time",
//    "totalDocks": 27,
//    "trikesAvailable": 0,
//    "kioskConnectionStatus": "Active"
//},
//"type": "Feature"
//},

