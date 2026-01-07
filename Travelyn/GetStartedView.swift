//
//  ContentView.swift
//  Travelyn
//
//  Created by Zaidan Mir on 28/12/2025.
//

import SwiftUI

struct GetStartedView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 80)

                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.85))
                        .frame(width: 140, height: 140)

                    Image(systemName: "bell.fill")
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundColor(.white)
                }

                Text("Travel Alert System")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.top, 26)

                Text("Get notified before your journey is\ndisrupted")
                    .font(.system(size: 18))
                    .foregroundColor(.black.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)

                Text("We learn your regular journeys to warn\nyou early about transport delays,\nclosures, and roadworks")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.55))
                    .multilineTextAlignment(.center)
                    .padding(.top, 14)
                    .padding(.horizontal, 36)

                Spacer()

                // ✅ Navigate to the next page
                NavigationLink {
                    SmartPatternLearningView()
                } label: {
                    Text("Get Started")
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
            .background(Color.white.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    GetStartedView()
}


