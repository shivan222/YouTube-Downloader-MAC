//
//  PlatformLogos.swift
//  4Kly
//
//  Platform logos — mix of custom-drawn SwiftUI (YouTube, Facebook, Vimeo, Instagram, Reddit)
//  and SVG image assets (SoundCloud, TikTok, Twitch, Dailymotion, X)
//

import SwiftUI

// MARK: - YouTube Logo (original custom drawn)
struct YouTubeLogo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(red: 1, green: 0, blue: 0))
                .frame(width: 42, height: 30)

            Path { path in
                path.move(to: CGPoint(x: 16, y: 9))
                path.addLine(to: CGPoint(x: 16, y: 21))
                path.addLine(to: CGPoint(x: 28, y: 15))
                path.closeSubpath()
            }
            .fill(Color.white)
            .frame(width: 42, height: 30)
        }
        .frame(width: 42, height: 30)
        .help("YouTube")
    }
}

// MARK: - Facebook Logo (original custom drawn)
struct FacebookLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.06, green: 0.52, blue: 0.98))
                .frame(width: 32, height: 32)

            Path { path in
                path.move(to: CGPoint(x: 18, y: 26))
                path.addLine(to: CGPoint(x: 18, y: 17))
                path.addLine(to: CGPoint(x: 22, y: 17))
                path.addLine(to: CGPoint(x: 22.5, y: 14))
                path.addLine(to: CGPoint(x: 18, y: 14))
                path.addLine(to: CGPoint(x: 18, y: 12))
                path.addQuadCurve(to: CGPoint(x: 20, y: 10), control: CGPoint(x: 18, y: 10))
                path.addLine(to: CGPoint(x: 22, y: 10))
                path.addLine(to: CGPoint(x: 22, y: 7))
                path.addLine(to: CGPoint(x: 19, y: 7))
                path.addQuadCurve(to: CGPoint(x: 14, y: 12), control: CGPoint(x: 14, y: 7))
                path.addLine(to: CGPoint(x: 14, y: 14))
                path.addLine(to: CGPoint(x: 11, y: 14))
                path.addLine(to: CGPoint(x: 11, y: 17))
                path.addLine(to: CGPoint(x: 14, y: 17))
                path.addLine(to: CGPoint(x: 14, y: 26))
                path.closeSubpath()
            }
            .fill(Color.white)
            .frame(width: 32, height: 32)
        }
        .frame(width: 42, height: 30)
        .help("Facebook")
    }
}

// MARK: - Vimeo Logo (original custom drawn)
struct VimeoLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.10, green: 0.82, blue: 0.95))
                .frame(width: 32, height: 32)

            Path { path in
                path.move(to: CGPoint(x: 10, y: 11))
                path.addLine(to: CGPoint(x: 16, y: 22))
                path.addLine(to: CGPoint(x: 22, y: 11))
                path.addLine(to: CGPoint(x: 19, y: 11))
                path.addLine(to: CGPoint(x: 16, y: 18))
                path.addLine(to: CGPoint(x: 13, y: 11))
                path.closeSubpath()
            }
            .fill(Color.white)
            .frame(width: 32, height: 32)
        }
        .frame(width: 42, height: 30)
        .help("Vimeo")
    }
}

// MARK: - Instagram Logo (original custom drawn)
struct InstagramLogo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.51, green: 0.23, blue: 0.72),
                            Color(red: 0.89, green: 0.19, blue: 0.42),
                            Color(red: 0.99, green: 0.69, blue: 0.27)
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                )
                .frame(width: 30, height: 30)

            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.white, lineWidth: 2.5)
                .frame(width: 22, height: 22)

            Circle()
                .stroke(Color.white, lineWidth: 2.5)
                .frame(width: 10, height: 10)

            Circle()
                .fill(Color.white)
                .frame(width: 3, height: 3)
                .offset(x: 6, y: -6)
        }
        .frame(width: 42, height: 30)
        .help("Instagram")
    }
}

// MARK: - Reddit Logo (original custom drawn)
struct RedditLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 1.0, green: 0.27, blue: 0.0))
                .frame(width: 32, height: 32)

            Path { path in
                path.move(to: CGPoint(x: 18, y: 6))
                path.addQuadCurve(to: CGPoint(x: 22, y: 4), control: CGPoint(x: 20, y: 4))
            }
            .stroke(Color.white, lineWidth: 1.5)
            .frame(width: 32, height: 32)

            Circle()
                .fill(Color.white)
                .frame(width: 4, height: 4)
                .offset(x: 5, y: -10)

            Ellipse()
                .fill(Color.white)
                .frame(width: 22, height: 16)
                .offset(y: 3)

            Circle()
                .fill(Color.white)
                .frame(width: 8, height: 8)
                .offset(x: -10, y: -2)

            Circle()
                .fill(Color.white)
                .frame(width: 8, height: 8)
                .offset(x: 10, y: -2)

            Circle()
                .fill(Color(red: 1.0, green: 0.27, blue: 0.0))
                .frame(width: 6, height: 6)
                .offset(x: -5, y: 2)

            Circle()
                .fill(Color(red: 1.0, green: 0.27, blue: 0.0))
                .frame(width: 6, height: 6)
                .offset(x: 5, y: 2)

            Path { path in
                path.move(to: CGPoint(x: 12, y: 21))
                path.addQuadCurve(to: CGPoint(x: 20, y: 21), control: CGPoint(x: 16, y: 24))
            }
            .stroke(Color(red: 1.0, green: 0.27, blue: 0.0), lineWidth: 1.5)
            .frame(width: 32, height: 32)
        }
        .frame(width: 42, height: 30)
        .help("Reddit")
    }
}

// MARK: - SoundCloud Logo (SVG asset)
struct SoundCloudLogo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 1.0, green: 0.33, blue: 0.0))
                .frame(width: 32, height: 32)
            Image("soundcloud")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
        }
        .frame(width: 42, height: 30)
        .help("SoundCloud")
    }
}

// MARK: - TikTok Logo (SVG asset)
struct TikTokLogo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.black)
                .frame(width: 32, height: 32)
            Image("tiktok")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
        }
        .frame(width: 42, height: 30)
        .help("TikTok")
    }
}

// MARK: - Twitch Logo (SVG asset)
struct TwitchLogo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 0.569, green: 0.275, blue: 1.0))
                .frame(width: 32, height: 32)
            Image("twitch")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
        }
        .frame(width: 42, height: 30)
        .help("Twitch")
    }
}

// MARK: - Dailymotion Logo (SVG asset)
struct DailymotionLogo: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 0.0, green: 0.4, blue: 0.863))
                .frame(width: 32, height: 32)
            Image("dailymotion")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
        }
        .frame(width: 42, height: 30)
        .help("Dailymotion")
    }
}

// MARK: - Twitter/X Logo (SVG asset)
struct TwitterLogo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 32, height: 32)
            Image("x")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 18, height: 18)
        }
        .frame(width: 42, height: 30)
        .help("X (Twitter)")
    }
}
