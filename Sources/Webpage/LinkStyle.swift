public import Dependencies

public struct LinkStyle: Sendable {
    public var underline: Bool?

    public init(
        underline: Bool? = nil
    ) {
        self.underline = underline
    }
}

private enum LinkStyleKey: Dependency.Key {
    static let liveValue = LinkStyle()
    static let testValue = LinkStyle()
}

extension Dependency.Values {
    public var linkStyle: LinkStyle {
        get { self[LinkStyleKey.self] }
        set { self[LinkStyleKey.self] = newValue }
    }
}
