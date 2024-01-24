//
//  LocationsListView.swift
//  MapsAppIL
//
//  Created by Иван Легенький on 24.01.2024.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    ListRowView(location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                .foregroundColor(.primary)
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationsListView {
    

    private func ListRowView(_ location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(30)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}
