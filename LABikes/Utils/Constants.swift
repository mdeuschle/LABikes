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
    case rootVC = "RootVC"
    case mapPopUpView = "MapPopUpView"
}

enum ReusableCell: String {
    case bike = "BikeCell"
    case map = "MapCell"
}

enum NavigationTitle: String {
    case laBikes = "LABikes"
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





