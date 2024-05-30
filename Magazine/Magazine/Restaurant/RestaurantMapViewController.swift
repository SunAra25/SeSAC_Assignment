//
//  RestaurantMapViewController.swift
//  Magazine
//
//  Created by 아라 on 5/30/24.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    let list = RestaurantList().restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = CLLocationCoordinate2D(latitude: 37.517922, longitude: 126.886468)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let annotations = setRestaurantAnnotation()
        
        mapView.addAnnotations(annotations)
    }
    
    func setRestaurantAnnotation() -> [MKPointAnnotation] {
        let coordinates = list.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
        
        var annotations: [MKPointAnnotation] = []
        
        for (idx, coor) in coordinates.enumerated() {
            let anno = MKPointAnnotation()
            anno.coordinate  = coor
            anno.title = list[idx].name
            annotations.append(anno)
        }
//        var annotations = Array(repeating: MKPointAnnotation(), count: coordinates.count)
        
//        for (idx, anno) in annotations.enumerated() {
//            annotations[idx].coordinate = coordinates[idx]
//            annotations[idx].title = list[idx].name
//        }
        
        return annotations
    }
}
