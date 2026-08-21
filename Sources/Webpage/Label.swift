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
