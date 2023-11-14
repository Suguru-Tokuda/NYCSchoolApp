//
//  NYCHighSchool.swift
//  NYCSchools
//
//  Created by Suguru Tokuda on 11/10/23.
//

import Foundation

struct NYCHighSchool: Decodable, Identifiable {
    let id,
        schoolName,
        boro,
        overviewParaph,
        ellPrograms,
        neighborhood,
        location,
        phoneNumber,
        website,
        primaryAddressLine,
        city,
        stateCode,
        zip: String
    let totalStudents: Int
    let latitude, longitude, graduationRate, attendanceRate: Double
    let acamidecOpportunties: [String]
    let requirements: [Int : [String]]
    let admissionPriorities: [Int: [String]]
    let programs: [String]
    let codes: [String]
    let interests: [String]
    let methods: [String]
    
    var address: String {
        return "\(primaryAddressLine), \(city), \(stateCode)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case boro
        case overviewParaph = "overview_paragraph"
        case ellPrograms = "ell_programs"
        case neighborhood
        case location
        case phoneNumber = "phone_number"
        case website
        case primaryAddressLine = "primary_address_line_1"
        case city
        case stateCode = "state_code"
        case zip
        case totalStudents = "total_students"
        case attendanceRate = "attendance_rate"
        case graduationRate = "graduation_rate"
        case latitude
        case longitude
    }
    
    private struct DynamicCodignKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            // we are using this, this just return nil
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodignKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.schoolName = try container.decode(String.self, forKey: .schoolName)
        self.boro = try container.decode(String.self, forKey: .boro)
        self.overviewParaph = try container.decode(String.self, forKey: .overviewParaph)
        self.acamidecOpportunties = parseDynamicArray(container: dynamicContainer, propertyName: "academicopportunities")
        self.programs = parseDynamicArray(container: dynamicContainer, propertyName: "program")
        self.codes = parseDynamicArray(container: dynamicContainer, propertyName: "code")
        self.interests = parseDynamicArray(container: dynamicContainer, propertyName: "interest")
        self.methods = parseDynamicArray(container: dynamicContainer, propertyName: "method")
        self.requirements = parseDictionary(container: dynamicContainer, propertyName: "requirement", separator: "_")
        self.admissionPriorities = parseDictionary(container: dynamicContainer, propertyName: "admissionpriority", separator: "")
        self.ellPrograms = try container.decode(String.self, forKey: .ellPrograms)
        self.neighborhood = try container.decode(String.self, forKey: .neighborhood)
        self.location = try container.decode(String.self, forKey: .location)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.website = try container.decode(String.self, forKey: .website)
        self.primaryAddressLine = try container.decode(String.self, forKey: .primaryAddressLine)
        self.city = try container.decode(String.self, forKey: .city)
        self.stateCode = try container.decode(String.self, forKey: .stateCode)
        self.zip = try container.decode(String.self, forKey: .zip)
        self.totalStudents = Int(try container.decode(String.self, forKey: .totalStudents)) ?? 0
        self.attendanceRate = Double(try container.decodeIfPresent(String.self, forKey: .attendanceRate) ?? "0.00") ?? 0
        self.graduationRate = Double(try container.decodeIfPresent(String.self, forKey: .graduationRate) ?? "0.00") ?? 0
        self.latitude = Double(try container.decodeIfPresent(String.self, forKey: .latitude) ?? "0") ?? 0.0
        self.longitude = Double(try container.decodeIfPresent(String.self, forKey: .longitude) ?? "0") ?? 0.0
        
        // MARK: internal functions to parse arrays
        func parseDynamicArray(container: KeyedDecodingContainer<NYCHighSchool.DynamicCodignKeys>, propertyName: String) -> [String] {
            var res = [String]()
            
            var parseFailed = false
            var counter = 1
            
            while !parseFailed {
                do {
                    guard let key = DynamicCodignKeys(stringValue: "\(propertyName)\(counter)") else {
                        parseFailed = true
                        break
                    }
                    
                    let el = try container.decode(String.self, forKey: key)
                    if !res.contains(where: { $0 == el }) {
                        res.append(el)
                    }
                    counter += 1
                } catch {
                    parseFailed = true
                }
            }
            
            return res
        }
        
        // parse dictionary
        func parseDictionary(container: KeyedDecodingContainer<NYCHighSchool.DynamicCodignKeys>, propertyName: String, separator: String) -> [Int : [String]] {
            var res: [Int : [String]] = [:]
            
            var parseFailed = false
            var outerCounter = 1
            
            while !parseFailed {
                do {
                    var innerCounter = 1
                    var innerParseFailed = false
                    var requirements = [String]()
                    
                    let outerKey = DynamicCodignKeys(stringValue: "\(propertyName)\(outerCounter)\(separator)\(innerCounter)")
                    _ = try container.decode(String.self, forKey: outerKey!)
                    
                    while !innerParseFailed {
                        guard let key = DynamicCodignKeys(stringValue: "\(propertyName)\(outerCounter)\(separator)\(innerCounter)") else {
                            innerParseFailed = true
                            outerCounter += 1
                            break
                        }
                        
                        do {
                            let requirement = try container.decode(String.self, forKey: key)

                            if !requirements.contains(where: { $0 == requirement }) {
                                requirements.append(requirement)
                            }
                            
                            innerCounter += 1
                        } catch {
                            innerParseFailed = true
                        }
                    }

                    res[outerCounter] = requirements
                    outerCounter += 1
                } catch {
                    parseFailed = true
                }
            }
            
            return res
        }
    }
}
