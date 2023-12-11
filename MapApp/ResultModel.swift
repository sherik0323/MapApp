//
//  ResultModel.swift
//  MapApp
//
//  Created by Sherozbek on 11/12/23.
//

import Foundation
import MapKit


struct Place: Identifiable {
    var id: UUID = UUID()
    var name: String
    var placeMark: MKPlacemark
    var coordinate: CLLocationCoordinate2D
    var adress: String? 
}
