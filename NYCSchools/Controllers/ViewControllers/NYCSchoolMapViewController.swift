//
//  NYCSchoolMapViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/14/23.
//

import UIKit
import MapKit

class NYCSchoolMapViewController: UIViewController {
    var listVM: NYCListViewModel! = NYCListViewModel()
    var mapVM: NYCSchoolDetailViewModel! = NYCSchoolDetailViewModel()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.overrideUserInterfaceStyle = .dark
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    deinit {
        listVM = nil
        mapVM = nil
    }
}

extension NYCSchoolMapViewController {
    private func presentDetailsView(school: NYCSchool, mapView: MKMapView, annotation: MKAnnotation) {
        Task {
            let detailsVC = NYCSchoolDetailViewController(isSheet: true)
            
            detailsVC.sheetDismissed = {
                mapView.deselectAnnotation(annotation, animated: true)
            }
            
            detailsVC.vm.getNYCScoreDataHandler = { [weak self] error in
                if error != nil {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error Fetching School Data", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                        self?.present(alert, animated: true)
                    }
                }
            }
            
            if let scoreData = await detailsVC.vm.getNYCScoreData(id: school.id) {
                DispatchQueue.main.async {
                    detailsVC.configure(school: school, scoreData: scoreData, showMapView: false)
                    self.present(detailsVC, animated: true)
                }
            }
        }
    }

}

extension NYCSchoolMapViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        mapView.delegate = self
        mapView.setRegion(mapVM.coordinate, animated: false)
        
        listVM.getNYCSchoolsCompletionHandler = { error in
            if error == nil {
                let schoolsToAdd = self.mapVM.getAnnotationsToAdd(schools: self.listVM.nycSchools, region: self.mapView.region)
                self.addAnnotations(schools: schoolsToAdd, region: self.mapView.region)
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error Fetching School Data", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
        }

        view.addSubview(mapView)
        
        Task {
            await listVM.getAllNYCSchools()
        }
    }
    
    private func addAnnotations(schools: [NYCSchool], region: MKCoordinateRegion) {
        DispatchQueue.main.async {
            // remove all annotations first
            self.mapView.removeAnnotations(self.mapView.annotations)
            var annotations: [MKPointAnnotation] = []
            
            schools.forEach { school in
                let annotation = CustomPointAnnotation()
                annotation.title = "\(school.schoolName) - \(school.graduationRate.toPercentageStr(decimalPlaces: 0))"
                annotation.id = school.id
                annotation.coordinate = CLLocationCoordinate2D(latitude: school.latitude, longitude: school.longitude)
                annotations.append(annotation)
            }
            
            if !annotations.isEmpty {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
}

extension NYCSchoolMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if let annotationPoint = annotation as? CustomPointAnnotation {
            let id = annotationPoint.id
            if let school = listVM.nycSchools.first(where: { $0.id == id }) {
                presentDetailsView(school: school, mapView: mapView, annotation: annotation)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let schoolsToAdd = self.mapVM.getAnnotationsToAdd(schools: self.listVM.nycSchools, region: self.mapView.region)
        self.addAnnotations(schools: schoolsToAdd, region: self.mapView.region)
    }
}
