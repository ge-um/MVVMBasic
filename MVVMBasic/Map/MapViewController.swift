//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
     
    private let mapView = MKMapView()
    
    private let list = RestaurantList.restaurantArray
    
//    private var displayedAnnotations: [MKPointAnnotation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        setUpInitialData()
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
        guard let first = list.first else {
            return
        }
        
        let firstRestaurantCoordinate = CLLocationCoordinate2D(latitude: first.latitude, longitude: first.longitude)
        let region = MKCoordinateRegion(
            center: firstRestaurantCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func setUpInitialData() {
        let annotations = RestaurantList.restaurantArray
        addAnnotations(annotations)
    }
    
    private func addAnnotations(_ restaurant: [Restaurant]) {
        let annotations = restaurant.map {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            annotation.title = $0.name
            annotation.subtitle = $0.address
            
            return annotation
        }
        mapView.addAnnotations(annotations)
    }

    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        Category.allCases.forEach { title in
            let alertAction = UIAlertAction(title: title.rawValue, style: .default) { _ in
                self.mapView.removeAnnotations(self.mapView.annotations)

                switch title {
                case .all:
                    self.addAnnotations(RestaurantList.restaurantArray)
                case .cancel:
                    break
                default:
                    self.addAnnotations(RestaurantList.restaurantArray.filter { $0.category == title.rawValue })
                }
            }
            alertController.addAction(alertAction)
        }
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
