//
//  PredictiveLearningView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 31/12/2025.
//

import SwiftUI

struct PredictiveLearningView: View {
    @AppStorage("smartLearningEnabled") private var smartLearningEnabled: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 60)

            // Top icon
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.black.opacity(0.75))
                    .frame(width: 92, height: 92)

                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.leading, 22)

            Text("Predictive Learning")
                .font(.system(size: 32, weight: .semibold))
                .padding(.top, 18)
                .padding(.leading, 22)

            Text("Enable smart pattern detection to receive\nproactive alerts for your regular journeys.\nYou can change this anytime in settings.")
                .font(.system(size: 17))
                .foregroundColor(.black.opacity(0.65))
                .padding(.top, 10)
                .padding(.leading, 22)
                .padding(.trailing, 22)

            // Smart Learning card
            HStack(alignment: .center, spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 44, height: 44)
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Smart Learning")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)

                    Text(smartLearningEnabled ? "Currently enabled" : "Currently disabled")
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()

                Toggle("", isOn: $smartLearningEnabled)
                    .labelsHidden()
                    .tint(.white) // makes the switch look closer on a dark card
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.black.opacity(0.9))
            )
            .padding(.horizontal, 22)
            .padding(.top, 22)

            // With learning enabled box
            VStack(alignment: .leading, spacing: 14) {
                Text("With Learning Enabled:")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))

                BulletRow(text: "Automatic journey detection")
                BulletRow(text: "Proactive early warnings")
                BulletRow(text: "Personalized alert timing")
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
            )
            .padding(.horizontal, 22)
            .padding(.top, 22)

            // Privacy guarantee box
            VStack(alignment: .leading, spacing: 10) {
                Text("Privacy Guarantee:")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))

                Text("Your data is only used to improve alerts. You\ncan disable learning anytime and clear all\nstored data in settings.")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.65))
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1)
            )
            .padding(.horizontal, 22)
            .padding(.top, 18)

            Spacer()

            Button {
                print("Start Using App tapped. SmartLearning=\(smartLearningEnabled)")
            } label: {
                Text("Start Using App")
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
    PredictiveLearningView()
}
