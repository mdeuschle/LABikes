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

    func config(with detail: Detail) {
        mainLabel.text = detail.label
        detailLabel.text = detail.detail
        self.selectionStyle = .none
    }
}
