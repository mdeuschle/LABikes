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

    func configCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableCell.detailCell.rawValue, for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            let stationDetail = detail.stationDetails[indexPath.row]
            cell.config(with: stationDetail)
            if indexPath.row == 0 {
                cell.favoriteSwtich.isHidden = false
                cell.favoriteSwtich.isOn = detail.bike.isFavorite ? true : false
            }
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





