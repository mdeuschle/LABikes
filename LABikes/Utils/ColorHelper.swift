//
//  ColorHelper.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/7/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

enum Color {
    case red
    case blue
    case black
    case grey

    func getColor() -> UIColor {
        switch self {
        case .red:
            return UIColor(red: 189/255, green: 49/255, blue: 40/255, alpha: 1)
        case .blue:
            return UIColor(red: 89/255, green: 193/255, blue: 202/255, alpha: 1)
        case .black:
            return UIColor(red: 39/255, green: 50/255, blue: 52/255, alpha: 1)
        case .grey:
            return UIColor(red: 232/255, green: 219/255, blue: 220/255, alpha: 1)
        }
    }
}





