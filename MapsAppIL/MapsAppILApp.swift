//
//  MapsAppILApp.swift
//  MapsAppIL
//
//  Created by Иван Легенький on 24.01.2024.
//

import SwiftUI

@main
struct MapsAppILApp: App {
    @StateObject private var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
