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
