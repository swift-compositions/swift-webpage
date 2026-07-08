import HTML

@_spi(DynamicHTML) import HTML_Rendering_Core

public struct Paragraph<Content: HTML.View>: HTML.View {
    let size: Size
    @HTML.Builder let content: Content
    public init(
        _ size: Size = .regular,
        @HTML.Builder content: () -> Content
    ) {
        self.size = size
        self.content = content()
    }

    public var body: some HTML.View {
        tag("p") {
            content
        }
        .css
        .pseudo(.not(.lastChild)) { $0.padding(bottom: .rem(0.5)) }
        .padding(top: .px(0), right: .px(0), left: .px(0))
        .margin(.zero)
        .lineHeight(1.5)
    }

    public enum Size: Sendable {
        case big
        case regular
        case small
    }
}
