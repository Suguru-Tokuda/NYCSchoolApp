//
//  NYCHighSchoolDetailViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit
import MapKit

class NYCHighSchoolDetailViewController: UIViewController {
    var vm: NYCHighSchoolDetailViewModel = NYCHighSchoolDetailViewModel()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension NYCHighSchoolDetailViewController {
    private func setupUI() {
        mapView.delegate = self
        
        vm.coordiateSetHandlder = { school in
            self.setAnnotation(school: school)
        }
        
        view.addSubview(mapView)
        mapView.centerCoordinate = NYCHighSchoolDetailViewModel.initialCoordinate
        applyConstraints()
    }
    
    private func applyConstraints() {
        let mapViewConstraints = [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ]
        
        NSLayoutConstraint.activate(mapViewConstraints)
    }
    
    private func setAnnotation(school: NYCHighSchool) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.title = school.schoolName
            annotation.coordinate = CLLocationCoordinate2D(latitude: school.latitude, longitude: school.longitude)
            self.mapView.addAnnotation(annotation)
        }
    }
}

extension NYCHighSchoolDetailViewController {
    func setSchool(school: NYCHighSchool) {
        vm.setSchool(school: school)
    }
}

extension NYCHighSchoolDetailViewController: MKMapViewDelegate {
    
}
