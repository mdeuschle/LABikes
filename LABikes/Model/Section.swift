//
//  Section.swift
//  LABikes
//
//  Created by Matt Deuschle on 2/4/18.
//  Copyright © 2018 Matt Deuschle. All rights reserved.
//

import UIKit

struct Section {

    private(set) var detail: Detail
    let headers = [SectionHeader.station, SectionHeader.status, SectionHeader.location]

    init(detail: Detail) {
        self.detail = detail
    }

    func configRowCount(section: Int) -> Int {
        switch section {
        case 0:
            return detail.stationDetails.count
        case 1:
            return detail.statusDetails.count
        case 2:
            return detail.locationDetails.count
        default:
            return 0
        }
    }

    func configCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailCell()
        switch indexPath.section {
        case 0:
            let stationDetail = detail.stationDetails[indexPath.row]
            cell.config(with: stationDetail)
        case 1:
            let statusDetail = detail.statusDetails[indexPath.row]
            cell.config(with: statusDetail)
        case 2:
            let locationDetail = detail.locationDetails[indexPath.row]
            cell.config(with: locationDetail)
        default:
            cell.config(with: detail)
        }
        return cell
    }
}





