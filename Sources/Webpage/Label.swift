//
//  Label.swift
//  swift-webpage
//
//  Restored during the §Swap-2 institute port. The pre-port file was commented out
//  wholesale, leaving `Button.swift`'s icon branch referring to a `LabelTypealias`
//  that existed only inside that comment block.
//
//  Two deliberate changes from the pre-port shape:
//
//  1. The `init(alignment:spacing:_:icon:)` convenience took `icon: LegacySVG`.
//     `LegacySVG` is a coenttb-era type with no institute counterpart, so the
//     convenience is retired; construct with the generic `icon:`/`title:` builders.
//  2. `public typealias LabelTypealias = Label` is NOT restored. It only existed
//     because `Button`'s generic parameter was itself named `Label` and shadowed
//     this type. `Button` now names that parameter `Title`, so `Label` is reachable
//     directly.
//
//  Note this type shadows `HTML_Standard.Label` (the `<label>` form element) inside
//  this module. Reach the element as `HTML_Standard.Label`, or use the `label`
//  lowercase element alias.
//

import HTML

public struct Label<Title: HTML.View, Icon: HTML.View>: HTML.View {
    let alignment: VerticalAlign
    let spacing: W3C_CSS_Values.Length
    let title: Title
    let icon: Icon

    public init(
        alignment: VerticalAlign = .middle,
        spacing: W3C_CSS_Values.Length = 0.25.rem,
        @HTML.Builder icon: () -> Icon,
        @HTML.Builder title: () -> Title
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.icon = icon()
        self.title = title()
    }

    public var body: some HTML.View {
        HStack(alignment: alignment, spacing: spacing) {
            icon
            title
        }
    }
}
