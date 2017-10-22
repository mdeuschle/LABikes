//
//  TabBarController.swift
//  LABikes
//
//  Created by Matt Deuschle on 10/21/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [RootVC()]
    }

    required init?(coder _: NSCoder) {
        fatalError("Tab bar not initialized")
    }

    override init(nibName _: String?, bundle _: Bundle?) {
        fatalError("Tab bar not initialized")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }



}
