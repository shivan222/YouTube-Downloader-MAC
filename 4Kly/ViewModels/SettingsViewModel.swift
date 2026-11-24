//
//  SettingsViewModel.swift
//  4Kly
//
//  ViewModel for settings UI
//  Implements Requirements: 8.1, 8.3, 8.4, 3.6, 13.1
//

import Foundation
import SwiftUI
import AppKit

@MainActor
class SettingsViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var downloadLocation: URL
    @Published var currentYtdlpVersion: String = "Checking..."
    @Published var availableYtdlpUpdate: UpdateInfo?
    @Published var isCheckingForUpdates: Bool = false
    @Published var isUpdatingYtdlp: Bool = false
    @Published var errorMessage: String?

    /// Controls upgrade prompt sheet visibility
    @Published var showUpgradePrompt: Bool = false

    /// Info for the upgrade prompt
    @Published var upgradePromptInfo: UpgradePromptInfo?

    // MARK: - Dependencies

    private let configService: ConfigurationService
    private let binaryUpdater: BinaryUpdater

    // MARK: - Initialization

    init(configService: ConfigurationService, binaryUpdater: BinaryUpdater) {
        self.configService = configService
        self.binaryUpdater = binaryUpdater
        self.downloadLocation = configService.downloadLocation

        Task {
            try? await Task.sleep(for: .seconds(5))
            let shouldCheck = await binaryUpdater.shouldCheckForUpdate()
            if shouldCheck {
                await checkForYtdlpUpdates()
                if availableYtdlpUpdate != nil {
                    await installYtdlpUpdate()
                }
            } else {
                do {
                    let version = try await binaryUpdater.getCurrentVersion()
                    currentYtdlpVersion = version
                } catch {
                    currentYtdlpVersion = "Downloading..."
                    try? await Task.sleep(for: .seconds(10))
                    if let version = try? await binaryUpdater.getCurrentVersion() {
                        currentYtdlpVersion = version
                        errorMessage = nil
                    }
                }
            }
        }
    }

    // MARK: - Upgrade Prompt

    /// Called when user tries to enable a Pro-only feature in Settings.
    /// Shows the same UpgradePromptSheet used elsewhere in the app.
    func showProUpgradePrompt() {
        upgradePromptInfo = UpgradePromptInfo(
            message: "Browser cookies, subtitle downloads, 4K & 8K quality, and more are available in 4Kly Pro.",
            upgradeURL: configService.upgradeURL
        )
        showUpgradePrompt = true
    }

    /// Opens the upgrade URL in the default browser
    func openUpgradeURL() {
        guard let url = upgradePromptInfo?.upgradeURL else { return }
        NSWorkspace.shared.open(url)
    }

    // MARK: - Public Methods

    func checkForYtdlpUpdates() async {
        isCheckingForUpdates = true
        errorMessage = nil
        do {
            let updateInfo = try await binaryUpdater.checkForUpdates()
            availableYtdlpUpdate = updateInfo
            if let updateInfo = updateInfo {
                currentYtdlpVersion = updateInfo.currentVersion
            } else {
                let version = try await binaryUpdater.getCurrentVersion()
                currentYtdlpVersion = version
            }
        } catch {
            errorMessage = "Failed to check for updates: \(error.localizedDescription)"
            currentYtdlpVersion = "Error"
        }
        isCheckingForUpdates = false
    }

    func selectDownloadLocation() async {
        let panel = NSOpenPanel()
        panel.title = "Select Download Location"
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.canCreateDirectories = true

        let response = panel.runModal()
        guard response == .OK, let selectedURL = panel.url else { return }

        let validator = PathValidator()
        let result = validator.validate(selectedURL)

        switch result {
        case .valid:
            configService.downloadLocation = selectedURL
            downloadLocation = selectedURL
            errorMessage = nil
        case .invalid(let reason):
            errorMessage = "Invalid download location: \(reason)"
        }
    }

    func installYtdlpUpdate() async {
        guard let updateInfo = availableYtdlpUpdate else { return }
        isUpdatingYtdlp = true
        errorMessage = nil
        do {
            try await binaryUpdater.performUpdate(to: updateInfo)
            currentYtdlpVersion = updateInfo.latestVersion
            availableYtdlpUpdate = nil
        } catch {
            errorMessage = "Failed to install update: \(error.localizedDescription)"
        }
        isUpdatingYtdlp = false
    }
}
