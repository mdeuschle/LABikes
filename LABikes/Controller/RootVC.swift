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
    var mapPopUpVC: MapPopUpVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        title = NavigationTitle.laBikes.rawValue
        mapView.delegate = self
        if let mapPopUpViewController = childViewControllers.last as? MapPopUpVC {
            mapPopUpVC = mapPopUpViewController
        }
        addGestureRecognizers()
        let locationButton = MKUserTrackingBarButtonItem(mapView: mapView)
        navigationItem.rightBarButtonItem = locationButton
    }

    private func addGestureRecognizers() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipe.direction = .down
        mapPopUpVC?.view.addGestureRecognizer(swipe)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        mapPopUpHeight.constant = 0
        view.layoutIfNeeded()
    }

    @objc func dismissView() {
        mapPopUpHeight.constant = 0
        view.layoutIfNeeded()
    }
}

extension RootVC: CLLocationManagerDelegate {

    private func configureLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            Location.shared.location = location
            centerMapOnLocation(location: location)
            downloadBikes()
            downloadWeather()
        }
    }

    private func downloadBikes() {
        APIManager.shared.performAPICall(urlString: APIManager.Router.bikes.path) { (success, object) in
            if success {
                if let bikeObject = object {
                    if let bikes = JSONHelper.shared.convertJSONObjectToBikes(object: bikeObject) {
                        DispatchQueue.main.async {
                            self.dropPins(bikes: bikes)
                        }
                    }
                }
            }
        }
    }

    private func downloadWeather() {
        print("WEATHER URL: \(APIManager.Router.weather.path)")

        APIManager.shared.performAPICall(urlString: APIManager.Router.weather.path) { (success, object) in
            if success {
                if let weatherObject = object {
                    print("WEATHER: \(weatherObject)")
                }
            }
        }
    }
}

extension RootVC: MKMapViewDelegate {

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000, 5000)
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
        popUpVC.config(bike: bike)
        UIView.animate(withDuration: 0.1, animations: {
            self.mapPopUpHeight.constant = self.view.bounds.height / 3
            self.view.layoutIfNeeded()
        }, completion: nil)
        let coordinate = CLLocationCoordinate2DMake(latitude - 0.0015, longitude)
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

