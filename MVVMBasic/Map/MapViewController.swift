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
    private let allAnnotations = RestaurantList.restaurantArray.map {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        annotation.title = $0.name
        annotation.subtitle = $0.address
        
        return annotation
    }
    
    private var displayedAnnotations: [MKPointAnnotation] = []

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
        displayedAnnotations = allAnnotations
        mapView.addAnnotations(displayedAnnotations)
    }
    
    private func addAnnotation(restaurant: Restaurant) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
        annotation.title = restaurant.name
        annotation.subtitle = restaurant.address
    }

    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "전체", style: .default) { _ in
            self.mapView.addAnnotations(self.allAnnotations)
        }


        let alert2Action = UIAlertAction(title: "한식", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)

            self.displayedAnnotations = {
                RestaurantList.restaurantArray.filter { $0.category == "한식"}.map {
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    annotation.title = $0.name
                    annotation.subtitle = $0.address
                    
                    return annotation
                }
            }()
            self.mapView.addAnnotations(self.displayedAnnotations)
        }
        
        let alert3Action = UIAlertAction(title: "양식", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)

            self.displayedAnnotations = {
                RestaurantList.restaurantArray.filter { $0.category == "양식"}.map {
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    annotation.title = $0.name
                    annotation.subtitle = $0.address
                    
                    return annotation
                }
            }()
            self.mapView.addAnnotations(self.displayedAnnotations)
            print("얼럿 3이 선택되었습니다.")
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)

            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(cancelAction)
         
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
