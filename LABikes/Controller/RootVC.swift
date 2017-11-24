//
//  RootVC.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RootVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapPopUpHeight: NSLayoutConstraint!

    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    var currentLocation = CLLocation()
    var mapPopUpVC: MapPopUpVC?
    var bikes: [Bike] = [Bike]() {
        didSet {
            if let navControllers = tabBarController?.viewControllers {
                if let navController = navControllers[1] as? UINavigationController {
                    if let listVC = navController.topViewController as? ListVC {
                        listVC.loadBikeData()
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        centerMapOnLocation(location: currentLocation)
        title = NavigationTitle.laBikes.rawValue
        mapView.delegate = self
        if let mapPopUpViewController = childViewControllers.last as? MapPopUpVC {
            mapPopUpVC = mapPopUpViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        mapPopUpHeight.constant = 0
        view.layoutIfNeeded()
    }
}

extension RootVC: CLLocationManagerDelegate {

    private func configureLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            locationManager.stopUpdatingLocation()
            centerMapOnLocation(location: location)
            DataService.shared.fetchBikeData(currentLocation: location, completion: { (success, bikes) in
                if success {
                    if let bikes = bikes {
                        self.bikes = bikes
                        self.dropPins(bikes: bikes)
                    }
                }
            })
        }
    }
}

extension RootVC: MKMapViewDelegate {

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let bikeAnnotation = view.annotation as? BikePointAnnotation,
            let bike = bikeAnnotation.bike,
            let popUpVC = mapPopUpVC,
            let latitude = bikeAnnotation.bike?.latitude,
            let longitude = bikeAnnotation.bike?.longitude else {
                return
        }
        popUpVC.updateBikeData(bike: bike)
        UIView.animate(withDuration: 0.2, animations: {
            self.mapPopUpHeight.constant = self.view.bounds.height / 3
            self.view.layoutIfNeeded()
        }, completion: nil)
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
    }

    private func dropPins(bikes: [Bike]) {
        for bike in bikes {
            let annotation = BikePointAnnotation(bike: bike)
            mapView.addAnnotation(annotation)
        }
    }
}






