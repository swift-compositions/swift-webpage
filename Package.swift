// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-webpage",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .macCatalyst(.v18)
    ],
    products: [
        .library(
            name: "Webpage",
            targets: ["Webpage"]
        )
    ],
    traits: [
        .trait(
            name: "Translating",
            description: "Include TranslatedString integration for internationalization support"
        )
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-html", from: "0.11.0"),
        .package(url: "https://github.com/coenttb/swift-css", from: "0.2.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.2"),        .package(url: "https://github.com/swift-incits/swift-incits-4-1986", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-translating", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "Webpage",
            dependencies: [
                .product(name: "HTML", package: "swift-html"),
                .product(name: "CSS Theme", package: "swift-css"),
                .product(name: "HTMLComponents", package: "swift-html"),
                .product(name: "Dependencies", package: "swift-dependencies"),                .product(name: "INCITS 4 1986", package: "swift-incits-4-1986"),
                .product(
                    name: "Translating",
                    package: "swift-translating",
                    condition: .when(traits: ["Translating"])
                )
            ],
            swiftSettings: [
                .define("TRANSLATING", .when(traits: ["Translating"]))
            ]
        ),
        .testTarget(
            name: "Webpage Tests",
            dependencies: ["Webpage"]
        )
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}
