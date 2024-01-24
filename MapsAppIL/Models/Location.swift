//
//  Location.swift
//  MapsAppIL
//
//  Created by Иван Легенький on 24.01.2024.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id: UUID = .init()
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
}
