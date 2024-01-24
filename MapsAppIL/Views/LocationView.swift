//
//  LocationView.swift
//  MapsAppIL
//
//  Created by Иван Легенький on 24.01.2024.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            MapLayer
            
            VStack(spacing: 0) {
                Header
                    .padding(.horizontal, 20)
                    .frame(maxWidth: maxWidthForIpad)
               
                Spacer()
                
                LocationsPreviewStack
            }
        }
        .sheet(item: $vm.showLocationsSheet, onDismiss: nil) { location in
            LocationDetailsView(location: location)
        }
    }
}

extension LocationView {
    private var Header: some View {
        VStack {
            Button {
                vm.toggleListView()
            } label: {
                Text(vm.mapLocation.name + " " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation.id)
                    .overlay(alignment: .leading, content: {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? -180 : 0))
                    })
           
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var MapLayer: some View {
        Map(
            coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation.id == location.id ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            }
        )
            .ignoresSafeArea(.all)
    }
    
    private var LocationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation.id == location.id {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.5), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .move(edge: .bottom)
                        ))
                }
            }
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationsViewModel())
}
