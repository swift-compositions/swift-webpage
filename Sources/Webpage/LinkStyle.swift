//
//  LinkStyle.swift
//  swift-webpage
//
//  Scoped styling for `Link`. Split out of the restored `Link.swift` so each public
//  type keeps its own file per [API-IMPL-005]. Follows the institute `Dependency.Key`
//  / `Dependency.Values` shape already used by `Halftone.swift`.
//
//  Scope it with the institute `withDependencies`:
//
//      withDependencies {
//          $0.linkStyle = LinkStyle(underline: true)
//      } operation: {
//          // Link renders underlined here
//      }
//

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
