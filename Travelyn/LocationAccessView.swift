//
//  LocationAccessView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 31/12/2025.
//

import SwiftUI
import CoreLocation
import Combine
import UIKit

struct LocationAccessView: View {
    @StateObject private var location = LocationPermissionManager()
    @State private var goNext = false
    @State private var showSettingsHint = false

    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 60)

            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.black.opacity(0.75))
                    .frame(width: 92, height: 92)

                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.leading, 22)

            Text("Location Access")
                .font(.system(size: 32, weight: .semibold))
                .padding(.top, 18)
                .padding(.leading, 22)

            Text("Allow location access to automatically\ndetect your regular routes and provide more\naccurate alerts. This is optional but\nrecommended.")
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.65))
                .padding(.top, 10)
                .padding(.leading, 22)
                .padding(.trailing, 22)

            // How we use location box
            VStack(alignment: .leading, spacing: 14) {
                Text("How we use location:")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))

                BulletRow(text: "Detect your regular commute patterns")
                BulletRow(text: "Identify nearby disruptions automatically")
                BulletRow(text: "Provide location-specific alternatives")
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
            )
            .padding(.horizontal, 22)
            .padding(.top, 24)

            // Optional badge
            HStack(spacing: 10) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.black.opacity(0.55))
                Text("Optional – You can add routes manually instead")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black.opacity(0.55))
                Spacer()
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.12), lineWidth: 1)
                    .background(Color.black.opacity(0.03))
            )
            .padding(.horizontal, 22)
            .padding(.top, 16)

            Spacer()

            // Allow location access
            Button {
                if !CLLocationManager.locationServicesEnabled() {
                    showSettingsHint = true
                    return
                }
                switch location.authorizationStatus {
                case .notDetermined:
                    location.requestWhenInUse()
                case .authorizedWhenInUse, .authorizedAlways:
                    goNext = true
                case .denied, .restricted:
                    showSettingsHint = true
                @unknown default:
                    location.requestWhenInUse()
                }
            } label: {
                Text("Allow Location Access")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 22)

            // Skip
            Button {
                goNext = true
            } label: {
                Text("Skip for Now")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black.opacity(0.8))
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.black.opacity(0.2), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 24)
            .padding(.top, 12)

            // hidden navigation trigger (go to your next onboarding screen)
            NavigationLink("", destination: PredictiveLearningView(), isActive: $goNext)
                .hidden()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.ignoresSafeArea())
        .onChange(of: location.authorizationStatus) { newStatus in
            if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                goNext = true
            } else if newStatus == .denied || newStatus == .restricted {
                showSettingsHint = true
            }
        }
        .alert("Location is disabled",
               isPresented: $showSettingsHint) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("To enable location-based features, allow access in Settings.")
        }
    }
}

// MARK: - Location permission manager

final class LocationPermissionManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
        authorizationStatus = manager.authorizationStatus
    }

    func requestWhenInUse() {
        // This triggers the iOS system popup (first time)
        manager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}

private struct BulletRow: View {
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "checkmark")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black.opacity(0.6))
                .padding(.top, 2)

            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.65))

            Spacer()
        }
    }
}


#Preview {
    LocationAccessView()
}

