//
//  PingService.swift
//  4Kly
//
//  Silent anonymous telemetry — fires once on first install, once per launch.
//  Zero personal data. Fully GDPR compliant.
//
//  What is sent:
//    event:   "free_install" (first launch only) or "free_launch"
//    version: app bundle version (e.g. "1.0.0")
//    os:      macOS version string (e.g. "macOS 14.5")
//    arch:    "arm64" or "x86_64"
//
//  What is NOT sent: email, name, IP, device ID, any personal data.
//

import Foundation

struct PingService {

    private static let endpoint = URL(string: "https://4kly.com/api/ping")!
    private static let hasInstalledKey = "com.4kly.ping.hasInstalled"

    // MARK: - Public API

    /// Call once from AppDelegate.applicationDidFinishLaunching.
    /// Sends "free_install" on first launch, "free_launch" on subsequent ones.
    static func pingOnLaunch() {
        Task.detached(priority: .background) {
            let defaults = UserDefaults.standard
            let isFirstInstall = !defaults.bool(forKey: hasInstalledKey)

            await send(event: isFirstInstall ? "free_install" : "free_launch")

            if isFirstInstall {
                defaults.set(true, forKey: hasInstalledKey)
            }
        }
    }

    // MARK: - Private

    private static func send(event: String) async {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return }

        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        let osString  = "macOS \(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"

        var arch = "x86_64"
        #if arch(arm64)
        arch = "arm64"
        #endif

        let payload: [String: String] = [
            "event":   event,
            "version": version,
            "os":      osString,
            "arch":    arch,
        ]

        guard let body = try? JSONSerialization.data(withJSONObject: payload) else { return }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody   = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        _ = try? await URLSession.shared.data(for: request)
    }
}
