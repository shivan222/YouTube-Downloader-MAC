//
//  UpgradePromptView.swift
//  4Kly
//

import SwiftUI

struct UpgradePromptSheet: View {

    let promptInfo: UpgradePromptInfo?
    let onUpgrade: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            // Crown icon
            Image(systemName: "crown.fill")
                .font(.system(size: 40))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.yellow, Color.orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(.top, 24)

            Text("Unlock Premium Quality")
                .font(.title2.bold())

            // Two clickable tier cards
            HStack(spacing: 12) {

                // Free card — clicking closes popup
                Button(action: onDismiss) {
                    VStack(spacing: 8) {
                        Image(systemName: "play.rectangle")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        Text("Free")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("Up to 720p")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Continue Free →")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primary.opacity(0.05))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Continue with free version")

                // Premium card — clicking opens upgrade URL
                Button(action: onUpgrade) {
                    VStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.title3)
                            .foregroundColor(.purple)
                        Text("Premium")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Text("Up to 4K & 8K")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Get Pro →")
                            .font(.caption2)
                            .foregroundColor(.purple)
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.purple.opacity(0.08))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple.opacity(0.3), lineWidth: 1.5)
                            )
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Upgrade to Premium")
            }
            .padding(.horizontal, 20)

            Text("Your purchase supports independent development")
                .font(.caption)
                .foregroundColor(.secondary.opacity(0.7))
                .multilineTextAlignment(.center)

            Text("One-time payment · No subscription · Lifetime access")
                .font(.caption2)
                .foregroundColor(.secondary.opacity(0.6))
                .multilineTextAlignment(.center)

            Spacer(minLength: 4)
        }
        .frame(width: 380, height: 360)
        
        .padding(.bottom, 20)
    }

}

// MARK: - View Extension

extension View {
    func upgradePrompt(
        isPresented: Binding<Bool>,
        promptInfo: UpgradePromptInfo?,
        onUpgrade: @escaping () -> Void
    ) -> some View {
        sheet(isPresented: isPresented) {
            UpgradePromptSheet(
                promptInfo: promptInfo,
                onUpgrade: onUpgrade,
                onDismiss: { isPresented.wrappedValue = false }
            )
        }
    }
}

#Preview {
    UpgradePromptSheet(
        promptInfo: UpgradePromptInfo(
            message: "Upgrade to Premium for 4K downloads.",
            upgradeURL: URL(string: "https://4kly.com")
        ),
        onUpgrade: {},
        onDismiss: {}
    )
}
