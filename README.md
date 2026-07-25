# swift-webpage

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Composable web-page UI components — page headers, navigation bars, cards, alerts, and more — built on the swift-html view DSL.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-webpage.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Webpage", package: "swift-webpage")
    ]
)
```

## License

Apache 2.0. See [LICENSE](LICENSE.md).
