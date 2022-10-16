//
//  GlassMorphicCard.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct GlassMorphicCard<Content: View>: View {
    // MARK: - Card content
    @ViewBuilder var content: Content

    // MARK: - Environment Properties
    @Environment(\.colorScheme) var colorScheme

    // MARK: - Frame properties
    var width: CGFloat?
    var height: CGFloat? = 220

    var body: some View {
        ZStack {
            CustomBlurView(effect: .systemUltraThinMaterial) { _ in }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))

            // MARK: - The GlassMorphic card
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    .linearGradient(
                        colors: [
                            colorScheme == .dark ? .white.opacity(0.25) : .black.opacity(0.25),
                            colorScheme == .dark ? .white.opacity(0.05) : .black.opacity(0.05),
                            .clear
                        ],
                        startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .blur(radius: 5)

            // MARK: - Borders
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(0.6),
                            .clear,
                            .purple.opacity(0.2),
                            .purple.opacity(0.5)
                        ],
                        startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 2
                )

        }
        .shadow(color: .black.opacity(0.15),
                radius: 5, x: -10, y: 10)
        .shadow(color: .black.opacity(0.15),
                radius: 5, x: 10, y: -10)
        .overlay(
            content
                .padding(20)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .padding(.horizontal)
        .frame(width: width, height: height)
    }
}

struct GlassMorphicCard_Previews: PreviewProvider {
    static var previews: some View {
        GlassMorphicCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Preview card")
                }
            }
        }
    }
}
