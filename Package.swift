// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-webpage",
    platforms: [
        .iOS(.v27),
        .macOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .macCatalyst(.v18),
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
        .package(url: "https://github.com/swift-foundations/swift-html.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-css.git", branch: "main"),
        .package(
            url: "https://github.com/swift-foundations/swift-dependencies.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-incits/swift-incits-4-1986.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-translating.git", branch: "main"),
        .package(
            url: "https://github.com/swift-foundations/swift-translating-dependencies.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Webpage",
            dependencies: [
                .product(name: "HTML", package: "swift-html"),
                .product(name: "CSS Theming", package: "swift-css"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "INCITS 4 1986", package: "swift-incits-4-1986"),
                .product(
                    name: "Translating",
                    package: "swift-translating",
                    condition: .when(traits: ["Translating"])
                ),
                .product(
                    name: "Translating Dependencies",
                    package: "swift-translating-dependencies",
                    condition: .when(traits: ["Translating"])
                ),
            ],
            swiftSettings: [
                .define("TRANSLATING", .when(traits: ["Translating"]))
            ]
        ),
        .testTarget(
            name: "Webpage Tests",
            dependencies: ["Webpage"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings =
        existing + [
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
        ]
}
