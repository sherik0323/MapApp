//
//  LocationDetailView.swift
//  SwiftUIMap
//
//  Created by Sherozbek on 18/01/24.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                
                VStack(alignment: .leading, spacing: 16.0){
                   titleSection
                   Divider()
                   descriptionSection
                   Divider()
                   mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
        }
        
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}


extension LocationDetailView {
    
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8.0){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16.0){
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
           
            if let url = URL(string: location.link) {
                Link(destination: url, label: {
                    Text("Read more on Wikipedia")
                        .font(.headline)
                        .tint(.blue)
                })
            }
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))), annotationItems: [location]) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapPinView()
                        .shadow(radius: 10)
                }
            }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
        
      
    }
    
    private var backButton: some View{
        Button(action: {
            vm.sheetLocation = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .shadow(radius: 4)
                .cornerRadius(10)
                .padding()
            
        })
    }
    
    

}
