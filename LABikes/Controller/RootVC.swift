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
    let locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    var currentLocation = CLLocation()
    let mapPopUpVC = MapPopUpVC(nibName: "MapPopUpView", bundle: nil)
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
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        configureLocationServices()
        centerMapOnLocation(location: currentLocation)
        title = "LABikes"
    }
}

extension RootVC: CLLocationManagerDelegate {

    private func configureLocationServices() {
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
        if let bikeAnnotation = view.annotation as? BikePointAnnotation {
            mapPopUpVC.modalPresentationStyle = .overCurrentContext
            mapPopUpVC.bike = bikeAnnotation.bike
            present(mapPopUpVC, animated: true, completion: nil)
            let coordinate = CLLocationCoordinate2DMake((bikeAnnotation.bike?.latitude)! - 0.0012, (bikeAnnotation.bike?.longitude)!)
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
            mapView.setRegion(region, animated: true)
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
            mapView.addGestureRecognizer(tap)
        }
    }

    @objc func dismissPopUp() {
        mapPopUpVC.dismiss(animated: true, completion: nil)
    }

    private func dropPins(bikes: [Bike]) {
        for bike in bikes {
            let annotation = BikePointAnnotation(bike: bike)
            mapView.addAnnotation(annotation)
        }
    }
}






