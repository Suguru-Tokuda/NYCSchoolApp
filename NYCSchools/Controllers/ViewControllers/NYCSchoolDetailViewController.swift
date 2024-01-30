//
//  NYCSSchoolDetailViewController.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import UIKit
import MapKit

protocol NYCSchoolHomepageURLTapDelegate: AnyObject {
    func nycSchoolHomepageURLTap(urlStr: String)
}

class NYCSchoolDetailViewController: UIViewController {
    var vm: NYCSchoolDetailViewModel! = NYCSchoolDetailViewModel()
    var isSheet: Bool = false
    var sheetDismissed: (() -> ())?
    
    private var mapView: MKMapView! = {
        let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .dark
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private var detailsViewContainer: NYCSchoolDetailView! = {
        let view = NYCSchoolDetailView()
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
        navigationController?.navigationBar.tintColor = .label
        
        if isSheet {
            if let presentationController = presentationController as? UISheetPresentationController {
                presentationController.delegate = self
                presentationController.detents = [
                    .medium(),
                    .large()
                ]
                presentationController.prefersGrabberVisible = true
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        vm = nil
        mapView = nil
        detailsViewContainer = nil
    }
    
    deinit {
        vm = nil
    }
}

extension NYCSchoolDetailViewController {
    private func setupUI() {
        vm.coordiateSetHandlder = { school in
            self.setAnnotation(school: school)
        }
        
        view.addSubview(mapView)
        view.addSubview(detailsViewContainer)
        
        detailsViewContainer.delegate = self

        mapView.centerCoordinate = NYCSchoolDetailViewModel.initialCoordinate
        applyConstraints()
    }
    
    private func setupUIForSheetView() {
        view.addSubview(detailsViewContainer)
        detailsViewContainer.setUrlViewIsHidden(isHidden: true)
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
            detailsViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(detailsViewConstraints)
    }
    
    private func setAnnotation(school: NYCSchool) {
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

extension NYCSchoolDetailViewController {
    func configure(school: NYCSchool, scoreData: NYCSchoolScorreData, showMapView: Bool = true) {
        DispatchQueue.main.async {
            self.vm.setSchool(school: school)
            self.setAnnotation(school: school)
            self.detailsViewContainer.configure(school: school, scoreData: scoreData)
        }
    }
}

extension NYCSchoolDetailViewController: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.sheetDismissed?()
    }
}

extension NYCSchoolDetailViewController: NYCSchoolHomepageURLTapDelegate {
    func nycSchoolHomepageURLTap(urlStr: String) {
        if !urlStr.isEmpty {
            let vc = WebViewController(urlStr: urlStr)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
