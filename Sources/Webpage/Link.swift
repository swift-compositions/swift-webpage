//
//  Link.swift
//  swift-webpage
//
//  Restored during the §Swap-2 institute port. The pre-port file was commented out
//  wholesale, which silently bound every `Link(href:) { … }` call site in
//  NavigationBar.swift to `HTML_Standard.Link` — the void `<link rel=…>` element —
//  instead of this anchor wrapper. That produced `missing argument label 'as:'` and
//  `value of type 'Link' has no member 'padding'` rather than a "not found" error.
//
//  The three `HTML.View` helpers the pre-port file carried (`linkColor`,
//  `linkUnderline`, `linkStyle`) are NOT restored: each was built on a
//  `.dependency(_:_:)` view modifier that has no institute counterpart. Scope a
//  `LinkStyle` with `withDependencies { $0.linkStyle = … }` instead.
//

import Dependencies
import HTML

public struct Link<Label: HTML.View>: HTML.View {
    @Dependency(\.linkStyle) var linkStyle
    let label: Label
    let href: HTML.Href.Attribute?

    public init(href: HTML.Href.Attribute?, @HTML.Builder label: () -> Label) {
        self.href = href
        self.label = label()
    }

    public init(_ title: String, href: HTML.Href.Attribute?) where Label == HTML.Text {
        self.init(href: href) {
            HTML.Text(title)
        }
    }

    public var body: some HTML.View {
        a(href: href) { label }
            .css
            .inlineStyle("color", "var(--link-color, #0066cc)")
            .visited {
                $0.inlineStyle("color", "var(--link-color, #0066cc)")
            }
            .pseudo(.link) {
                $0.inlineStyle("color", "var(--link-color, #0066cc)")
            }
            .visited {
                $0.inlineStyle(
                    "text-decoration",
                    linkStyle.underline == true ? "underline" : "none"
                )
            }
            .pseudo(.link) {
                $0.inlineStyle(
                    "text-decoration",
                    linkStyle.underline == true ? "underline" : "none"
                )
            }
            .hover {
                $0.inlineStyle(
                    "text-decoration",
                    linkStyle.underline == true ? "none" : "underline"
                )
            }
    }
}
