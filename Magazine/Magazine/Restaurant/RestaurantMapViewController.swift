//
//  RestaurantMapViewController.swift
//  Magazine
//
//  Created by 아라 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentedCtr: UISegmentedControl!
    
    let list = RestaurantList().restaurantArray
    var filterList: [Restaurant] = []
    lazy var categoryList = ["전체"] + Array(Set<String>(self.list.map { $0.category })).sorted { $0 > $1}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterList = list
        
        mapView.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.517922, longitude: 126.886468)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let annotations = setRestaurantAnnotation()
        
        mapView.addAnnotations(annotations)
        
        setSegmentedControl()
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
        
//        var annotations = Array(repeating: MKPointAnnotation(), count: coordinates.count)
        
//        for (idx, anno) in annotations.enumerated() {
//            annotations[idx].coordinate = coordinates[idx]
//            annotations[idx].title = list[idx].name
//        }
        
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
