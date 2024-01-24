//
//  LocationDetailsView.swift
//  MapsAppIL
//
//  Created by Иван Легенький on 24.01.2024.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                ImagesSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    TitleSection
                    
                    Divider()
                    
                    DescriptionSection
                    
                    Divider()
                    
                    MapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(BackButton, alignment: .topTrailing)
    }
}

extension LocationDetailsView {
    private var ImagesSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad
                           ? nil
                           : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var TitleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var DescriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    
    private var MapLayer: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )),
            annotationItems: [location]) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .shadow(radius: 10)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
            .allowsHitTesting(false)
    }
    
    private var BackButton: some View {
        Button {
            vm.showLocationsSheet = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}

#Preview {
    LocationDetailsView(location: LocationsDataService.locations[1])
        .environmentObject(LocationsViewModel())
}
