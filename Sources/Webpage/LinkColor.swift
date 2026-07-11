//
//  LinkColor.swift
//  swift-webpage
//
//  Consumer-pulled by the identity/HTML decomposition lane (2026-07-10): the 29
//  `.linkColor(_:)` call sites in swift-authentication need this modifier to compile.
//
//  This restores the `linkColor` capability that Link.swift documents as deliberately
//  NOT ported (see the drop note at the top of Link.swift: the pre-port `linkColor`,
//  `linkUnderline`, and `linkStyle` helpers all rode a `.dependency(_:_:)` view modifier
//  that has no institute counterpart). Rather than reintroduce that machinery, this
//  modifier sets the `--link-color` CSS custom property directly on the wrapping element.
//  `Link` already reads that property (`color: var(--link-color, #0066cc)` in Link.swift),
//  so the value cascades to the anchor for the base, `:visited`, and `:link` states
//  without any dependency plumbing.
//

import HTML

extension HTML.View {
    /// Sets the `--link-color` CSS custom property used by ``Link``.
    ///
    /// ``Link`` resolves its anchor color from `var(--link-color, #0066cc)`, so setting
    /// this custom property on an enclosing element re-colors every descendant link for
    /// both light and dark mode. The light value is applied unconditionally and the dark
    /// value is emitted under a `prefers-color-scheme: dark` media query.
    ///
    /// ```swift
    /// Link("Reset password", href: resetHref)
    ///     .linkColor(.branding.primary)
    /// ```
    ///
    /// This is the adjudicated, dependency-free replacement for the pre-port `linkColor`
    /// helper. Link.swift's header records why the original three helpers (`linkColor`,
    /// `linkUnderline`, `linkStyle`) were not restored: each was built on a
    /// `.dependency(_:_:)` view modifier with no institute counterpart. This modifier
    /// deliberately avoids that machinery, writing the color straight to a CSS custom
    /// property instead. The `DarkModeColor` argument is fully resolved by the caller
    /// (e.g. `.branding.primary` reads `DarkModeColor.Theme.current` at the call site),
    /// so no `@Dependency(\.theme)` read is needed here.
    ///
    /// - Parameter color: The light/dark link color to expose as `--link-color`.
    public func linkColor(_ color: DarkModeColor) -> HTML.CSS<some HTML.View> {
        self.css
            .inlineStyle("--link-color", color.light.description)
            .dark { $0.inlineStyle("--link-color", color.dark.description) }
    }
}
