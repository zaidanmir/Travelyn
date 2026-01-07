//
//  SmartPatternLearningView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 31/12/2025.
//

import SwiftUI

struct SmartPatternLearningView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 60)

            // Top icon block
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.black.opacity(0.75))
                    .frame(width: 92, height: 92)

                Image(systemName: "brain.head.profile") // closest SF Symbol
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.leading, 22)

            Text("Smart Pattern Learning")
                .font(.system(size: 30, weight: .semibold))
                .padding(.top, 18)
                .padding(.leading, 22)

            Text("The app learns your regular commutes and\ntravel patterns to send you timely alerts\nbefore disruptions affect your journey.")
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.65))
                .padding(.top, 10)
                .padding(.leading, 22)
                .padding(.trailing, 22)

            // Feature list
            VStack(spacing: 22) {
                FeatureRow(
                    icon: "point.topleft.down.curvedto.point.bottomright.up",
                    title: "Detects Your Routes",
                    subtitle: "Identifies your regular journeys\nautomatically"
                )

                FeatureRow(
                    icon: "clock.fill",
                    title: "Learns Your Schedule",
                    subtitle: "Understands when you typically travel"
                )

                FeatureRow(
                    icon: "exclamationmark.triangle.fill",
                    title: "Proactive Alerts",
                    subtitle: "Warns you before you leave home"
                )
            }
            .padding(.top, 28)
            .padding(.horizontal, 22)

            // Info box
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "shield.fill")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 2)

                Text("Your data is only used to improve alerts.\nYou can disable learning anytime.")
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.65))

                Spacer()
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
                    .background(Color.white)
            )
            .padding(.horizontal, 22)
            .padding(.top, 26)

            Spacer()

 
            NavigationLink {
                EnableNotificationsView()
            } label: {
                Text("Continue")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(14)
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

private struct FeatureRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.08))
                    .frame(width: 52, height: 52)

                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black.opacity(0.65))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))

                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.6))
            }

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        SmartPatternLearningView()
    }
}

