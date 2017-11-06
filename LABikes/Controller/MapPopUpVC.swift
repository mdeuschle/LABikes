//
//  MapPopUpVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/29/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class MapPopUpVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    var bike: Bike?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = bike?.name
        addressLabel.text = bike?.addressStreet
        popUpView.layer.cornerRadius = 10
        popUpView.shadow()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        dismiss(animated: false, completion: nil)
    }

    @IBAction func directionsTapped(_ sender: UIButton) {
    }
}
