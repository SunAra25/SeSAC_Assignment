//
//  RestaurantMapViewController.swift
//  Magazine
//
//  Created by 아라 on 5/30/24.
//

import UIKit
import CoreLocation
import MapKit

class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentedCtr: UISegmentedControl!
    let locationManager = CLLocationManager()
    let list = RestaurantList().restaurantArray
    var filterList: [Restaurant] = []
    lazy var categoryList = ["전체"] + Array(Set<String>(self.list.map { $0.category })).sorted { $0 > $1}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterList = list
        
        mapView.delegate = self
        locationManager.delegate = self
        
        let annotations = setRestaurantAnnotation()
        
        mapView.addAnnotations(annotations)
        
        setSegmentedControl()
        
        checkDeviceLocationAuthorization()
    }
    
    func setSegmentedControl() {
        segmentedCtr.removeAllSegments()
        
        for (idx, category) in categoryList.enumerated() {
            segmentedCtr.insertSegment(withTitle: category, at: idx, animated: true)
        }
        
        segmentedCtr.addTarget(self, action: #selector(segmentedCtrDidTap(segment:)), for: .valueChanged)
        segmentedCtr.selectedSegmentIndex = 0
    }
    
    func setRestaurantAnnotation() -> [MKPointAnnotation] {
        let coordinates = filterList.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
            
        var annotations: [MKPointAnnotation] = []
        
        for (idx, coor) in coordinates.enumerated() {
            let anno = MKPointAnnotation()
            anno.coordinate  = coor
            anno.title = filterList[idx].name
            annotations.append(anno)
        }
        
        return annotations
    }
    
    @objc func segmentedCtrDidTap(segment: UISegmentedControl) {
        mapView.removeAnnotations(mapView.annotations)
        
        let idx = segment.selectedSegmentIndex
        
        if idx == 0 {
            filterList = list
        } else {
            filterList = list.filter { $0.category == categoryList[idx] }
        }
        
        let newAnno = setRestaurantAnnotation()
        
        mapView.addAnnotations(newAnno)
    }
}

extension RestaurantMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkCurrentLocationAuthorization()
    }
}

extension RestaurantMapViewController {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
    }
    
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        } else {
            // TODO: 설정 유도
        }
    }
    
    func checkCurrentLocationAuthorization() {
        var status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            // TODO: 설정 유도
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print(status)
        }
    }

}
