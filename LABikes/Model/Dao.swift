//
//  Dao.swift
//  LABikes
//
//  Created by Matt Deuschle on 11/25/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

class Dao {

    var favoritesArchive: String

    static let shared = Dao()

    init() {
        let userDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let userDirecotry = userDirectories.first ?? ""
        favoritesArchive = "\(userDirecotry)/favoriteBikes"
    }

    func acrchiveFavorites(favoriteBikes: [Bike]) {
        NSKeyedArchiver.archiveRootObject(favoriteBikes, toFile: favoritesArchive)
    }

    func unarchiveFavorites() -> [Bike] {
        if let unarchivedBikes = NSKeyedUnarchiver.unarchiveObject(withFile: favoritesArchive) as? [Bike] {
            return unarchivedBikes.sorted(by: { $0.distance < $1.distance })
        }
        return [Bike]()
    }
}


