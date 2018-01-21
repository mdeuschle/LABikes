//
//  DetailCell.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/20/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    func config(bike: Bike, indexPathRow: Int) {
        let detail = Detail(bike: bike)
        let details = detail.getDetails()
        let cellDetail = details[indexPathRow]
        self.textLabel?.text = cellDetail.label
        self.detailTextLabel?.text = cellDetail.detail
        self.imageView?.image = cellDetail.image
        self.selectionStyle = .none
    }
}
