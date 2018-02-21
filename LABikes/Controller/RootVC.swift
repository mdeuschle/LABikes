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

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var mapPopUpHeight: NSLayoutConstraint!
    @IBOutlet private weak var weatherView: WeatherView!

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
        tabBarController?.tabBar.items?[0].title = TabBarName.map.rawValue
        tabsEnabled(false)
        weatherView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        mapPopUpHeight.constant = 0
        weatherView.isHidden = true
        view.layoutIfNeeded()
    }

    private func tabsEnabled(_ isEnabled: Bool) {
        for i in 1...2 {
            tabBarController?.tabBar.items?[i].isEnabled = isEnabled
        }
    }

    private func addGestureRecognizers() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipe.direction = .down
        mapPopUpVC?.view.addGestureRecognizer(swipe)
    }

    @objc private func dismissView() {
        UIView.animate(withDuration: 0.25) {
            self.mapPopUpHeight.constant = 0
            self.weatherView.isHidden = true
            self.view.layoutIfNeeded()
        }
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
            weatherView.downloadWeather()
            downloadBikes()
        }
    }

    func downloadBikes() {
        APIManager.shared.performAPICall(urlString: APIManager.Router.bikes.path) { (success, data) in
            if success {
                DispatchQueue.main.async {
                    self.tabsEnabled(true)
                    DataManager.shared.convertDataToBikes(data: data!)
                    self.dropPins()
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
        weatherView.isHidden = false
        guard let bikeAnnotation = view.annotation as? BikePointAnnotation,
            let bike = bikeAnnotation.bike,
            let popUpVC = mapPopUpVC,
            let latitude = bikeAnnotation.bike?.latitude,
            let longitude = bikeAnnotation.bike?.longitude else {
                return
        }
        popUpVC.configBike(bike: bike)
        popUpVC.configFavorite(isFavorite: bike.isFavorite)
        UIView.animate(withDuration: 0.25, animations: {
            self.mapPopUpHeight.constant = 238
            self.view.layoutIfNeeded()
        }, completion: nil)
        let coordinate = CLLocationCoordinate2DMake(latitude - 0.0028, longitude)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
        mapView.deselectAnnotation(mapView.selectedAnnotations[0], animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) { return nil }
        let annotationView = MKAnnotationView()
        annotationView.centerOffset = CGPoint(x: 0, y: -annotationView.frame.size.height / 2)
        if let icon = annotation.title {
            annotationView.image = UIImage(named: icon ?? "empty")
        }
        return annotationView
    }

    private func dropPins() {
        for bike in DataManager.shared.bikes {
            let annotation = BikePointAnnotation(bike: bike)
            mapView.addAnnotation(annotation)
        }
    }
}



