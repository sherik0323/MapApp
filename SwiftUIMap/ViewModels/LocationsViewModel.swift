//
//  LocationsViewModel.swift
//  SwiftUIMap
//
//  Created by Sherozbek on 16/01/24.
//

import SwiftUI
import MapKit
import Foundation

class LocationsViewModel: ObservableObject {
    
    // ALl loaded location
    @Published var locations: [Location]
    
    // First location
    @Published var mapLocation: Location{
        didSet{
                updateMapRegion(location: mapLocation)
            }
    }
        
    // Current region on Map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
     
    
    //show LocationList
    @Published var showLocationList: Bool = false
    
    // Show location sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
        
    }
    
    private func updateMapRegion(location: Location ){
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan )
        }
        
    }
    
     func toogleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
         
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else{
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
}
