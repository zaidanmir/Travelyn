//
//  EnableNotificationsView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 31/12/2025.
//

import SwiftUI
import UserNotifications
import UIKit

struct EnableNotificationsView: View {
    @State private var statusText: String = "Required permission"
    @State private var showSettingsHint = false
    @State private var goNext = false   // triggers navigation

    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 60)

            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.black.opacity(0.75))
                    .frame(width: 92, height: 92)

                Image(systemName: "bell.fill")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.leading, 22)

            Text("Enable Notifications")
                .font(.system(size: 32, weight: .semibold))
                .padding(.top, 18)
                .padding(.leading, 22)

            Text("Receive timely alerts about disruptions\naffecting your regular journeys. This\npermission is required for the app to work\neffectively.")
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.65))
                .padding(.top, 10)
                .padding(.leading, 22)
                .padding(.trailing, 22)

            VStack(alignment: .leading, spacing: 14) {
                Text("What you'll receive:")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))

                BulletRow(text: "Early warnings before journey disruptions")
                BulletRow(text: "Real-time updates on delays and closures")
                BulletRow(text: "Alternative route suggestions")
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
            )
            .padding(.horizontal, 22)
            .padding(.top, 24)

            HStack(spacing: 10) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.black.opacity(0.55))
                Text(statusText)
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

            Button {
                requestNotifications()
            } label: {
                Text("Allow Notifications")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 24)

            // Hidden navigation trigger
            NavigationLink("", destination: LocationAccessView(), isActive: $goNext)
                .hidden()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.ignoresSafeArea())
        .onAppear { refreshPermissionStatus() }
        .alert("Notifications are disabled",
               isPresented: $showSettingsHint) {
            Button("Open Settings") { openAppSettings() }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("To enable alerts, allow notifications in Settings.")
        }
    }

    private func requestNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                        DispatchQueue.main.async {
                            statusText = granted ? "Enabled" : "Required permission"
                            if granted {
                                goNext = true   // auto-advance
                            }
                        }
                    }

            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async {
                    statusText = "Enabled"
                    goNext = true // already allowed → go next
                }

            case .denied:
                DispatchQueue.main.async { showSettingsHint = true }

            @unknown default:
                break
            }
        }
    }

    private func refreshPermissionStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    statusText = "Enabled"
                case .denied, .notDetermined:
                    statusText = "Required permission"
                @unknown default:
                    statusText = "Required permission"
                }
            }
        }
    }

    private func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
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
    EnableNotificationsView()
}

