//
//  Constants.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

typealias BikeHandler = (Bool, [[String: Any]]?) -> Void

enum NibName: String {
    case mapPopUpView = "MapPopUpView"
    case bikeDetailView = "BikeDetailView"
    case weatherVC = "WeatherVC"
    case bikeCell = "BikeCell"
    case detailCell = "DetailCell"
}

enum ReusableCell: String {
    case bike = "BikeCell"
    case map = "MapCell"
    case listCell = "ListCell"
    case detailCell = "DetailCell"
}

enum NavigationTitle: String {
    case laBikes = "LABikes"
    case favorites = "Favorites"
    case stationDetails = "Details"
}

enum SegueID: String {
    case mapPopUpSegue = "mapPopUpSegue"
}

enum CycleAnimation: String {
    case json = "cycle_animation"
}

enum TabBarName: String {
    case map = "MAP"
    case list = "LIST"
}

enum SectionHeader: String {
    case station = "STATION"
    case status = "STATUS"
    case location = "LOCATION"
}




