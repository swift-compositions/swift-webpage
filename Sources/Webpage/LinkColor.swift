import HTML

extension HTML.View {

    public func linkColor(_ color: DarkModeColor) -> HTML.CSS<some HTML.View> {
        self.css
            .inlineStyle("--link-color", color.light.description)
            .dark { $0.inlineStyle("--link-color", color.dark.description) }
    }
}
