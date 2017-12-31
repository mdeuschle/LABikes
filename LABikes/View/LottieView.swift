//
//  LottieView.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import Lottie

class LottieView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configure(view: UIView) {
        let animationView = LOTAnimationView(name: CycleAnimation.json.rawValue)
        animationView.frame = CGRect(origin: frame.origin, size: frame.size)
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 3
        animationView.loopAnimation = true
        view.addSubview(animationView)
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
