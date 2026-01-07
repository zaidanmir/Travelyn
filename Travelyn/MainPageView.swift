//
//  MainPageView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 06/01/2026.
//

import SwiftUI
import MapKit

struct MainPageView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.509976, longitude: -0.104376),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        Map(initialPosition: position) {
            UserAnnotation()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainPageView()
}

