import HTML

public struct Card<Content: HTML.View, Header: HTML.View, Footer: HTML.View>: HTML.View {
    let content: Content
    let header: Header
    let footer: Footer

    public init(
        @HTML.Builder content: () -> Content,
        @HTML.Builder header: () -> Header = { HTML.Empty() },
        @HTML.Builder footer: () -> Footer = { HTML.Empty() }
    ) {
        self.content = content()
        self.header = header()
        self.footer = footer()
    }

    public var body: some HTML.View {
        VStack(spacing: .rem(0)) {
            div {
                header
            }
            .css
            .light {
                $0.borderBottom(width: .px(1), style: .solid, color: .hex("#e8e8e8"))
            }
            .dark {
                $0.borderBottom(width: .px(1), style: .solid, color: .hex("#3d3d3d"))
            }

            VStack {
                VStack(spacing: .rem(0)) { content }
                    .css.flexGrow()

                footer
            }
            .css
            .flexGrow()
            .padding(top: .rem(0.5), horizontal: .rem(1.5), bottom: .rem(1.5))
        }
        .css
        .display(.flex)
        .flexDirection(.column)
        .dark {
            $0.borderBottom(width: .px(1), style: .solid, color: .hex("#353535"))
        }
        .dark {
            $0.inlineStyle("border", "1px #353535 solid")
        }
        .inlineStyle("box-shadow", "0 4px 12px rgba(0, 0, 0, 0.1)")
        .borderRadius(.length(7.5.px))
        .overflow(.hidden)
    }
}
