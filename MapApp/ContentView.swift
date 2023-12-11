//
//  ContentView.swift
//  MapApp
//
//  Created by Sherozbek on 10/12/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()

    @State var isShowDetails = false
    init() {
        contentViewModel.checkLocationIsEnable()
    }
    var body: some View {
        NavigationStack{
            Map(coordinateRegion: $contentViewModel.region, 
                showsUserLocation: true,  annotationItems: contentViewModel.places) { place in
                MapAnnotation(coordinate: place.coordinate) { 
                    VStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        Text(place.name)
                            .font(.system(size: 12))
                    }
                    .onTapGesture {
                        contentViewModel.selectedPlace(for: place)
                        isShowDetails.toggle()
                    }
                }
            }
                .ignoresSafeArea()
                .sheet(isPresented: $isShowDetails) {
                    SelectedPlaceView(placeName: contentViewModel.selectedPlaceName, adress:  contentViewModel.selectedPlaceAdress)
                    
                }
        }
        .searchable(text: $contentViewModel.searchTerm)
        .onSubmit(of: .search) {
            contentViewModel.search()
        }
    }
}

#Preview {
    ContentView()
}
 
struct SelectedPlaceView: View {
    var placeName: String
    var adress: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(placeName)
                .font(.system(size: 20, weight: .black))
                .lineLimit(0)
            Text(adress)
                .padding(.top, 10)
                .padding(.bottom, 30)
            
            Button {
                    
            } label: {
                Text("Select")
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background {
                        Color.pink
                    }
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 20)
        .presentationDetents([.height(200)])
    }
    

}
