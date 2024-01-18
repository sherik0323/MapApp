//
//  LocationMapPinView.swift
//  SwiftUIMap
//
//  Created by Sherozbek on 17/01/24.
//

import SwiftUI

struct LocationMapPinView: View {
    
    let accentColor: Color = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundStyle(accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
                
        }
        
        
        
    }
}

#Preview {
    LocationMapPinView()
}

