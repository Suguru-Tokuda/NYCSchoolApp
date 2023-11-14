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
    var isSheet: Bool = false
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let detailsViewContainer: NYCHighSchoolDetailView = {
        let view = NYCHighSchoolDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(isSheet: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isSheet = isSheet
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        if isSheet {
            if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.detents = [
                    .medium()
                ]
                setupUIForSheetView()
            }
        } else {
            self.setupUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension NYCHighSchoolDetailViewController {
    private func setupUI() {
        vm.coordiateSetHandlder = { school in
            self.setAnnotation(school: school)
        }
        
        view.addSubview(mapView)
        view.addSubview(detailsViewContainer)

        mapView.centerCoordinate = NYCHighSchoolDetailViewModel.initialCoordinate
        applyConstraints()
    }
    
    private func setupUIForSheetView() {
        view.addSubview(detailsViewContainer)
        applyConstraintsForSheetView()
    }
    
    private func applyConstraints() {
        let mapViewConstraints = [
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25)
        ]
        
        let detailsViewConstraints = [
            detailsViewContainer.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            detailsViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(mapViewConstraints)
        NSLayoutConstraint.activate(detailsViewConstraints)
    }
    
    private func applyConstraintsForSheetView() {
        let detailsViewConstraints = [
            detailsViewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            detailsViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            detailsViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            detailsViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(detailsViewConstraints)
    }
    
    private func setAnnotation(school: NYCHighSchool) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.title = school.schoolName
            annotation.coordinate = CLLocationCoordinate2D(latitude: school.latitude, longitude: school.longitude)
            self.mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
            self.mapView.addAnnotation(annotation)
        }
    }
}

extension NYCHighSchoolDetailViewController {
    func configure(school: NYCHighSchool, scoreData: NYCHighSchoolScorreData, showMapView: Bool = true) {
        DispatchQueue.main.async {
            self.vm.setSchool(school: school)
            self.setAnnotation(school: school)
            self.detailsViewContainer.configure(school: school, scoreData: scoreData)
        }
    }
}
