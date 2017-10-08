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

    @IBOutlet weak var bikeTableView: UITableView!
    @IBOutlet weak var bikeMapView: MKMapView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBarBackgroundView: UIView!
    
    var bikes = [Bike]()
    var filteredBikes = [Bike]()
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    let detailVC = DetailVC()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        bikeTableView.delegate = self
        bikeTableView.dataSource = self
        locationManager.delegate = self
        bikeMapView.delegate = self
        searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchBarBackgroundView.backgroundColor = .clear
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.returnKeyType = .done
        bikeTableView.estimatedRowHeight = 100
        bikeTableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: ReusalbleCell.bike.rawValue, bundle: nil)
        bikeTableView.register(nib, forCellReuseIdentifier: ReusalbleCell.bike.rawValue)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
}

extension RootVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredBikes.count
        }
        return bikes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusalbleCell.bike.rawValue, for: indexPath) as? BikeCell else {
            return BikeCell()
        }
        let bike: Bike!
        if inSearchMode {
            bike = filteredBikes[indexPath.row]
        } else {
            bike = bikes[indexPath.row]
        }
        cell.configCell(bike: bike)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC(nibName: "DetailVC", bundle: nil)
        if inSearchMode {
            detailVC.selectedBike = filteredBikes[indexPath.row]
        } else {
            detailVC.selectedBike = bikes[indexPath.row]
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RootVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            downloadBikeData()
        case .notDetermined, .denied, .restricted:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLoc = locations.first {
            currentLocation = currentLoc
            if currentLoc.verticalAccuracy < 1000 && currentLoc.horizontalAccuracy < 1000 {
                locationManager.stopUpdatingLocation()
                centerMapOnLocation(location: currentLocation)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    func downloadBikeData() {
        DataService.instance.getBikesData { (success, bikes) in
            DispatchQueue.main.async {
                if success {
                    if let bikes = bikes {
                        for bike in bikes {
                            if let coordinatesDic = bike["geometry"] as? [String: Any],
                                let propertiesDic = bike["properties"] as? [String: Any] {
                                let bike = Bike(coordinatesDic: coordinatesDic, propertiesDic: propertiesDic, currentLocation: self.currentLocation)
                                self.bikes.append(bike)
                                self.bikeTableView.reloadData()
                            } else {
                                print("Bike Dics are NIL")
                            }
                        }
                        self.bikes.sort(by: { $0.distance < $1.distance })
                        self.dropPins()
                    } else {
                        print("Bike Object NIL")
                    }
                } else {
                    print("Unable to download data")
                }
            }
        }
    }
}

extension RootVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let mapPin = MKAnnotationView()
        mapPin.canShowCallout = true
        mapPin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        mapPin.image = #imageLiteral(resourceName: "bikePin")
        return mapPin
    }

    func dropPins() {
        for bike in bikes {
            let newPin = BikePointAnnotation()
            newPin.coordinate = bike.coordinate2D
            newPin.title = bike.name
            newPin.subtitle = "Bikes Available: \(bike.bikesAvailable)"
            newPin.bikeStation = bike
            bikeMapView.addAnnotation(newPin)
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 20000, 20000)
        bikeMapView.setRegion(coordinateRegion, animated: true)
    }
}

extension RootVC: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animateHeight(height: 74)
        animateBackground(color: #colorLiteral(red: 0.8146468997, green: 0.8317709565, blue: 0.8496219516, alpha: 1))
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        inSearchMode = false
        searchBar.text = ""
        animateHeight(height: 340)
        animateBackground(color: .clear)
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            inSearchMode = false
            view.endEditing(true)
            bikeTableView.reloadData()
        } else {
            inSearchMode = true
            filteredBikes = bikes.filter( { $0.name.range(of: searchText) != nil })
            bikeTableView.reloadData()
        }
    }

    func animateBackground(color: UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.searchBarBackgroundView.backgroundColor = color
        }
    }

    func animateHeight(height: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.mapHeight.constant = height
            self.view.layoutIfNeeded()
        }) { (complete) in
            if complete {
                self.bikeTableView.reloadData()
            }
        }
    }
}






