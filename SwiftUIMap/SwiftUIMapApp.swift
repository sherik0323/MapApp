//
//  SwiftUIMapApp.swift
//  SwiftUIMap
//
//  Created by Sherozbek on 13/01/24.
//

import SwiftUI

@main
struct SwiftUIMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
