//
//  MainPageView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 06/01/2026.
//

import SwiftUI
import MapKit

extension MKCoordinateRegion {
    static let applePark = MKCoordinateRegion(
        center: .init(latitude: 37.3346, longitude: -122.0090),
        latitudinalMeters: 1000,
        longitudinalMeters: 1000
    )
}

struct MainPageView: View {
    // Bottom Sheet Properties
    @State private var showBottomSheet: Bool = true
    @State private var sheetDetent: PresentationDetent = .height(80)
    @State private var sheetHeight: CGFloat = 0
    @State private var animationDuration: CGFloat = 0
    @State private var toolbarOpacity: CGFloat = 1
    @State private var safeAreaBottomInset: CGFloat = 0


    var body: some View {
        Map(initialPosition: .region(.applePark))
            .sheet(isPresented: $showBottomSheet) {
                BottomSheetView(sheetDetent: $sheetDetent)
                    .presentationDetents([.height(80), .height(350), .large], selection: $sheetDetent)
                    .presentationBackgroundInteraction(.enabled)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onGeometryChange(for: CGFloat.self) {
                        max(min($0.size.height, 400 + safeAreaBottomInset), 0)
                    } action: { oldValue, newValue in
                        
                        /// Limiting The Offset
                        sheetHeight = min(newValue, 350 + safeAreaBottomInset)
                        
                        /// Calculating Opacity
                        let progress = max(min((newValue - (350 + safeAreaBottomInset)) / 50, 1), 0)
                        toolbarOpacity = 1 - progress

                        /// Calculating Animation Duration
                        let diff = abs(newValue - oldValue)
                        let duration = max(min(diff / 100, 0.3), 0)
                        animationDuration = duration

                    }
                    .ignoresSafeArea()
                    .interactiveDismissDisabled()
            }
            .overlay(alignment: .bottomTrailing) {
                BottomFloatingToolBar(sheetHeight: sheetHeight)
                    .padding(.trailing, 15)
                    .offset(y: safeAreaBottomInset - 10)
            }
            .onGeometryChange(for: CGFloat.self) {
                $0.safeAreaInsets.bottom
            } action: { newValue in
                safeAreaBottomInset = newValue
            }

    }
    
    /// Bottom Floating View
    @ViewBuilder
    func BottomFloatingToolBar(sheetHeight: CGFloat) -> some View {
        VStack(spacing: 35) {
            Button {
                // car action
            } label: {
                Image(systemName: "car.fill")
            }

            Button {
                // location action
            } label: {
                Image(systemName: "location")
            }
        }
        .font(.title3)
        .foregroundStyle(Color.primary)
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
        .glassEffect(.regular, in: .capsule)
        .opacity(toolbarOpacity)
        .offset(y: -sheetHeight)
        .animation(.interpolatingSpring(duration: animationDuration, bounce: 0, initialVelocity: 0), value: sheetHeight)
    }

}


struct BottomSheetView: View {
    @Binding var sheetDetent: PresentationDetent

    // Bottom Sheet Properties
    @State private var searchText: String = ""
    @FocusState var isFocused: Bool

    var body: some View {
        ScrollView(.vertical) {

        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HStack(spacing: 10) {
                TextField("Search...", text: $searchText)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.gray.opacity(0.25), in: .capsule)
                    .focused($isFocused)

                /// Profile/Close Button for Search Field
                Button {
                    if isFocused {
                        isFocused = false
                    } else {
                        // handle Button Action
                    }
                } label: {
                    ZStack {
                        if isFocused {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.primary)
                                .frame(width: 48, height: 48)
                                .glassEffect(in: .circle)
                                .transition(.blurReplace)
                        } else {
                            Text("LS")
                                .font(.title2.bold())
                                .frame(width: 48, height: 48)
                                .foregroundStyle(.white)
                                .background(.gray, in: .circle)
                                .transition(.blurReplace)
                        }
                    }
                }

            }
            .padding(.horizontal, 18)
            .frame(height: 80)
            .padding(.top, 5)
        }
        /// Animating Focus Changes
        .animation(
            .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0),
            value: isFocused
        )
        /// Updating Sheet size when textfield is active
        .onChange(of: isFocused) { oldValue, newValue in
            sheetDetent = newValue ? .large : .height(350)
        }

    }
}


#Preview {
    MainPageView()
}

