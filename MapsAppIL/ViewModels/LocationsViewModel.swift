//
//  LocationsViewModel.swift
//  MapsAppIL
//
//  Created by Иван Легенький on 24.01.2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationsList: Bool = false
    
    @Published var showLocationsSheet: Location?

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    public func toggleListView() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    public func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    public func nextButtonPressed() {
        guard let currentIDX = locations.firstIndex(where: {$0.id == mapLocation.id}) else { return }
        
        guard locations.indices.contains(currentIDX + 1) else {
            
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            
            return
        }
        
        let nextLocation = locations[currentIDX + 1]
        
        showNextLocation(location: nextLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
}
