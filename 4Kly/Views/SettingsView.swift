//
//  SettingsView.swift
//  4Kly
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        Form {

            // MARK: - Downloads
            Section("Downloads") {
                HStack {
                    Text("Save to:")
                    Spacer()
                    Text(viewModel.downloadLocation.lastPathComponent)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .truncationMode(.middle)
                    Button("Change...") {
                        Task { await viewModel.selectDownloadLocation() }
                    }
                }
            }

            // MARK: - Download Engine
            Section("Download Engine") {
                HStack {
                    Text("Update Engine")
                    Spacer()
                    if viewModel.isCheckingForUpdates {
                        ProgressView().controlSize(.small).padding(.trailing, 4)
                    }
                    Text(viewModel.currentYtdlpVersion)
                        .foregroundColor(.secondary)
                    if viewModel.availableYtdlpUpdate == nil
                        && !viewModel.isCheckingForUpdates
                        && !["Checking...", "Error", "Unknown", "Downloading..."].contains(viewModel.currentYtdlpVersion) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
                Button("Check for Updates") {
                    Task { await viewModel.checkForYtdlpUpdates() }
                }
                .disabled(viewModel.isCheckingForUpdates || viewModel.isUpdatingYtdlp)

                if let update = viewModel.availableYtdlpUpdate {
                    HStack {
                        Text("Update available: \(update.latestVersion)").foregroundColor(.green)
                        Spacer()
                        if viewModel.isUpdatingYtdlp {
                            ProgressView().controlSize(.small)
                        } else {
                            Button("Install Update") {
                                Task { await viewModel.installYtdlpUpdate() }
                            }
                        }
                    }
                }
            }

            // MARK: - Advanced (Pro — tapping toggle shows upgrade prompt)
            Section {
                Toggle(isOn: Binding(
                    get: { false },
                    set: { _ in viewModel.showProUpgradePrompt() }
                )) {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(spacing: 6) {
                            Text("Use browser cookies")
                            proBadge
                        }
                        Text("Pass cookies from Chrome, Firefox, or Brave to bypass age restrictions.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            } header: {
                Text("Advanced")
            }

            // MARK: - Subtitles (Pro — tapping toggle shows upgrade prompt)
            Section {
                Toggle(isOn: Binding(
                    get: { false },
                    set: { _ in viewModel.showProUpgradePrompt() }
                )) {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack(spacing: 6) {
                            Text("Download subtitles with video")
                            proBadge
                        }
                        Text("Save SRT or VTT subtitles alongside your video in any language.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            } header: {
                Text("Subtitles")
            }

            // MARK: - About
            Section("About") {
                HStack {
                    Text("4Kly Version:")
                    Spacer()
                    Text(appVersion).foregroundColor(.secondary)
                }
                Link("Visit 4kly.com", destination: URL(string: "https://4kly.com")!)
                Text("Powered by yt-dlp · MIT License")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text("4Kly is free and open source.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Link("Upgrade to Pro for 4K, playlists, cookies & more →",
                         destination: URL(string: "https://4kly.com")!)
                        .font(.caption)
                    Text("Your purchase supports independent development.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if let error = viewModel.errorMessage {
                Section { Text(error).foregroundColor(.red) }
            }
        }
        .formStyle(.grouped)
        .navigationTitle("Settings")
        .frame(minWidth: 500, minHeight: 400)
        .sheet(isPresented: $viewModel.showUpgradePrompt) {
            UpgradePromptSheet(
                promptInfo: viewModel.upgradePromptInfo,
                onUpgrade: {
                    viewModel.openUpgradeURL()
                    viewModel.showUpgradePrompt = false
                },
                onDismiss: {
                    viewModel.showUpgradePrompt = false
                }
            )
        }
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }

    private var proBadge: some View {
        Text("PRO")
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.2, blue: 1.0), Color(red: 0.2, green: 0.5, blue: 1.0)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(Capsule())
    }
}

#Preview {
    SettingsView(
        viewModel: SettingsViewModel(
            configService: ConfigurationService(),
            binaryUpdater: BinaryUpdater(githubAPI: GitHubAPIClient())
        )
    )
}
