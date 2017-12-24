//
//  Alert.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/22/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class Alert {

    let viewController: UIViewController!

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func showAlert(message: String = "An Error Has Occured") {
        let alertController = UIAlertController(title: "Alert",
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        viewController.present(alertController,
                               animated: true,
                               completion: nil)
    }
}




