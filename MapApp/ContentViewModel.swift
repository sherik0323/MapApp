//
//  ContentViewModel.swift
//  MapApp
//
//  Created by Sherozbek on 11/12/23.
//

import SwiftUI
import MapKit
import Foundation


class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager?
    var searchTerm = ""
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @Published private(set)  var places = [Place]()
    @Published private(set) var selectedPlace: Place?
    
    
    
    var selectedPlaceName: String {
        guard let selectPlace = selectedPlace else { return ""}
        
        return selectPlace.name
    }
    
    var selectedPlaceAdress: String{
        guard let selectPlace = selectedPlace else { return ""}
        if let street = selectPlace.placeMark.thoroughfare,
           let subAdress = selectPlace.placeMark.subThoroughfare {
            return street + "," + subAdress
            
        }
        return ""
    
    }
    
    
    func checkLocationIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("alert")
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Ограничен")
        case .denied:
            print("Отключены")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
            break
        }
        
        
    }
    
    
    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        request.region = region
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            guard let response = response else { return }
            
            DispatchQueue.main.async {
                self.places = response.mapItems.map({ item in
                    Place(name: item.name ?? "", placeMark: item.placemark, coordinate: item.placemark.coordinate, adress: item.placemark.locality)
                })
            }
        }
    }
    
    func selectedPlace(for place: Place ){
        self.selectedPlace = place
    }
    
    
}
