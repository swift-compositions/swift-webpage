import HTML

public struct CallToActionModule<Content: HTML.View>: HTML.View {

    let title: (content: String, color: DarkModeColor)
    let blurb: (content: String, color: DarkModeColor)?
    let content: Content

    public init(
        title: (content: String, color: DarkModeColor),
        blurb: (content: String, color: DarkModeColor)?,
        @HTML.Builder content: () -> Content = { HTML.Empty() }
    ) {
        self.title = title
        self.blurb = blurb
        self.content = content()
    }

    public var body: some HTML.View {
        div {
            div {
                HTML.Group {
                    div {
                        Header(2) { HTML.Raw(title.content) }
                            .css.color(title.color)
                    }

                    if let blurb {
                        div {
                            Paragraph(.big) { HTML.Raw(blurb.content) }
                                .css
                                .font(.body(.regular))
                                .color(blurb.color)
                                .desktop {
                                    $0.margin(vertical: .zero, horizontal: .auto)
                                }
                                .maxWidth(.rem(40))
                        }
                    }
                    content
                }
                .css.desktop { $0.textAlign(.center) }
            }
            .css
            .margin(vertical: .zero, horizontal: .auto)
            .maxWidth(.px(1280))
            .padding(
                vertical: .rem(3),
                horizontal: .rem(1.5)
            )
            .desktop {
                $0.padding(.rem(6))
            }
            .flexContainer(
                direction: .column,
                wrap: .wrap,
                rowGap: .rem(0.5)
            )
            .desktop {
                $0.alignItems(.center)
            }
        }
    }
}

#if DEBUG && canImport(SwiftUI)
    import SwiftUI
    #Preview {
        HTML.Document {
            CallToActionModule(
                title: (content: "HELLO THERE", color: .black),
                blurb: (content: "HELLO", color: .blue)
            )
            .css.border(.left, width: .px(3), style: .solid)

            CallToActionModule(
                title: (content: "HELLO THERE", color: .black),
                blurb: (content: "HELLO", color: .blue)
            )
            .css.border(.left, width: .px(3), style: .solid)
        }

        .frame(width: 600, height: 400)

    }
#endif
