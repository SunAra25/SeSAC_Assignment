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
        
        setNavigation()
    }
    
    func setNavigation() {
        let item = UIBarButtonItem(title: "위치", style: .plain, target: self, action: #selector(checkDeviceLocationAuthorization))
        navigationItem.rightBarButtonItem = item
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
    
    @objc func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        } else {
            let center = CLLocationCoordinate2D(latitude: 37.517768794428, longitude: 126.88578560648)
            setRegionAndAnnotation(center: center)
        }
    }
    
    func checkCurrentLocationAuthorization() {
        var status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            presentSetting()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print(status)
        }
    }

    func presentSetting() {
        let alertController = UIAlertController(title: "위치 접근 권한이 없습니다.", message: "설정으로 이동하여 권한 설정을 해주세요.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: false, completion: nil)
    }
}
