import HTML
@_spi(DynamicHTML) import HTML_Rendering_Core

public struct Header<Content: HTML.View>: HTML.View {
    let size: Int
    let disableMargins: Bool

    @HTML.Builder let content: Content

    public init(
        _ size: Int = 3,
        disableMargins: Bool = false,
        @HTML.Builder content: () -> Content
    ) {
        self.size = size
        self.disableMargins = disableMargins
        self.content = content()
    }

    public var body: some HTML.View {
        tag("h\(size)") { content }
            .css
            .margin(disableMargins != true ? .zero : nil)
            .pseudo(.not(.firstChild)) {
                $0.marginTop(disableMargins != true ? .lengthPercentage(marginTop) : nil)
            }
            .pseudo(.not(.lastChild)) {
                $0.marginBottom(disableMargins != true ? .lengthPercentage(marginBottom) : nil)
            }
            .fontSize(fontSize)
            .fontWeight(700)
            .lineHeight(lineHeight)
    }

    var fontSize: W3C_CSS_Fonts.FontSize {
        switch size {
        case 1: .em(2)
        case 2: .em(1.5)
        case 3: .em(1.17)
        case 4: .em(1)
        case 5: .em(0.83)
        default: .em(0.67)
        }
    }
    var lineHeight: Double {
        switch size {
        case 1: 1.2
        case 2: 1.2
        case 3: 1.2
        case 4: 1.2
        case 5: 1.15
        default: 1.15
        }
    }
    var marginBottom: LengthPercentage {
        switch size {
        case 1: .em(1)
        case 2: .em(0.75)
        case 3: .em(0.5)
        case 4: .em(0.5)
        case 5: .em(0.5)
        default: .em(0.3)
        }
    }
    var marginTop: LengthPercentage {
        switch size {
        case 1: .em(2)
        case 2: .em(1.75)
        case 3: .em(1.5)
        case 4: .em(1.5)
        case 5: .em(0.5)
        default: .em(0.5)
        }
    }
}
