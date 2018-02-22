//
//  DetailCell.swift
//  LABikes
//
//  Created by Matt Deuschle on 1/20/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet weak var favoriteSwtich: UISwitch!

    func config(with detail: Detail) {
        mainLabel.text = detail.label
        detailLabel.text = detail.detail
        favoriteSwtich.isHidden = true
        self.selectionStyle = .none
    }
}
