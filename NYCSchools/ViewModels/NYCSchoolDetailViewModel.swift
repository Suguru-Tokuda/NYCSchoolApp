//
//  NYCSchoolDetailViewModel.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/13/23.
//

import MapKit

class NYCSchoolDetailViewModel {
    static let initialCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7831, longitude: -73.9712)
    var school: NYCSchool?
    var scoreData: NYCSchoolScorreData?
    var service: NYCSchoolService
    var coordinate: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: initialCoordinate.latitude,
            longitude: initialCoordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1,
                                   longitudeDelta: 0.1))
    var coordiateSetHandlder: ((NYCSchool) -> ())?
    var getNYCScoreDataHandler: ((Error?) -> ())?
    
    init(service: NYCSchoolService = NYCSchoolService()) {
        self.service = service
    }
    
    func setSchool(school: NYCSchool) {
        self.school = school
        coordiateSetHandlder?(school)
    }
    
    func getNYCScoreData(id: String) async -> NYCSchoolScorreData? {
        do {
            guard let scoreData = try await service.getNYCSchoolScore(id: id) else {
                self.getNYCScoreDataHandler?(NetworkError.noDataFoundError)
                return nil
            }
            
            self.scoreData = scoreData
            return self.scoreData
        } catch {
            self.getNYCScoreDataHandler?(error)
            return nil
        }
    }
    
    func getAnnotationsToAdd(schools: [NYCSchool], region: MKCoordinateRegion) -> [NYCSchool] {
        let center = region.center
        let centerLong = center.longitude
        let centerLat = center.latitude
        let spanLongHalf = region.span.longitudeDelta / 2
        let spanLatHalf = region.span.latitudeDelta / 2
        
        let longMax = center.longitude + abs(spanLongHalf)
        let longMin = center.longitude - abs(spanLongHalf)
        let latMax = center.latitude + abs(spanLatHalf)
        let latMin = center.latitude - abs(spanLatHalf)
        
        return schools.filter { school in
            let lat = school.latitude
            let long = school.longitude
            
            if lat >= centerLat && long >= centerLong && lat <= latMax && long <= longMax {// top right
                return true
            } else if lat >= centerLat && lat <= latMax && long <= centerLong && long >= longMin { // bottom right
                return true
            } else if lat <= centerLat && lat >= latMin && long >= centerLong && long <= longMax { // top left
                return true
            } else if lat <= centerLat && lat >= latMin && long <= centerLong && long >= longMin { // bottom left
                return true
            }
                        
            return false
        }
    }
}
