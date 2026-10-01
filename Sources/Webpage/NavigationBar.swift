import Foundation
import HTML
import Standard_Library_Extensions

public struct NavigationBar: HTML.View {
    let logo: any HTML.View
    let backgroundColor: DarkModeColor?
    let sticky: Bool
    let items: [any NavItem]

    public init(
        sticky: Bool = false,
        backgroundColor: DarkModeColor? = nil,
        @HTML.Builder logo: () -> any HTML.View,
        @Array<any NavItem>.Builder items: () -> [any NavItem]
    ) {
        self.logo = logo()
        self.items = items()
        self.sticky = sticky
        self.backgroundColor = backgroundColor
    }

    public init(
        @HTML.Builder logo: () -> any HTML.View,
        @HTML.Builder centeredNavItems: () -> any HTML.View,
        @HTML.Builder trailingNavItems: () -> any HTML.View,
        @HTML.Builder mobileNavItems: () -> any HTML.View
    ) {
        self.logo = logo()
        self.items = [centeredNavItems(), trailingNavItems(), mobileNavItems()]
        self.sticky = false
        self.backgroundColor = nil

    }

    public var body: some HTML.View {
        nav {

            HTML.Style.Element {
                """
                /* Hide mobile menu by default */
                .mobile-menu {
                    display: none;
                    flex-basis: 100%;  /* Forces new line in flex container */
                    width: 100%;
                }

                /* Desktop styles (769px and up) */
                @media (min-width: 769px) {
                    .nav-item {
                        display: block;
                    }

                    #menu-icon {
                        display: none !important;
                    }

                    .mobile-menu {
                        display: none !important;
                    }
                }

                /* Mobile styles (768px and below) */
                @media (max-width: 768px) {
                    .nav-item {
                        display: none !important;
                    }

                    #menu-icon {
                        display: block;
                        margin-left: auto;
                    }

                    #menu-checkbox:checked ~ .mobile-menu {
                        display: block !important;
                    }
                }
                """
            }

            div {

                input.checkbox
                    .id("menu-checkbox")
                    .css
                    .display(Display.none)

                HTML.AnyView(logo)
                    .css
                    .lineHeight(0)

                HTMLForEach(items) { item in
                    HTML.AnyView(item)
                        .class("nav-item")
                }

                MenuButtonLabel()

                div {
                    HTMLForEach(items) { item in

                        if "\(type(of: item))".contains("NavSpacer") {
                            HTML.Empty()
                        } else {
                            div {
                                HTML.AnyView(item)
                            }
                            .css
                            .padding(.rem(1))
                            .borderBottom(width: .px(1), style: .solid, color: .border.tertiary)
                        }
                    }
                }
                .class("mobile-menu")
                .css
                .flexBasis(.percent(100))
                .borderTop(width: .px(1), style: .solid, color: .border.secondary)

                .marginTop(.rem(1))
            }
            .css
            .display(.flex)
            .flexDirection(.row)
            .flexWrap(.wrap)
            .alignItems(.center)
            .gap(.rem(1))
            .desktop {
                $0.padding(
                    top: .extraSmall,
                    right: .zero,
                    bottom: .small,
                    left: .zero
                )
            }
            .mobile {
                $0.padding(
                    top: .small,
                    right: .medium,
                    bottom: .small,
                    left: .medium
                )
            }
            .maxWidth(.px(1280))
            .marginTop(.zero)
            .marginBottom(.zero)
            .marginLeft(.auto)
            .marginRight(.auto)
        }
        .css
        .width(.percent(100))
        .if(sticky) { nav in
            nav
                .css
                .position(.sticky)
                .top(.zero)
                .zIndex(9999)
        }
        .if(let: backgroundColor) { nav, color in
            nav.css.backgroundColor(color)
        }
    }

    struct MenuButtonLabel: HTML.View {
        var body: some HTML.View {
            Bars()
                .id("menu-icon")
                .attribute("for", "menu-checkbox")
                .css
                .cursor(.pointer)
                .marginLeft(.auto)
                .desktop {
                    $0.display(Display.none)
                }
                .userSelect(UserSelect.none)
        }

        struct Bars: HTML.View {
            var body: some HTML.View {
                label {
                    HTMLForEach(-1...1) { index in
                        Bar(index: index)
                    }
                    .css
                    .width(.px(24))
                    .height(.px(3))
                    .backgroundColor(.background.button)
                    .display(.block)
                    .inlineStyle("border-radius", "1.5px")
                    .inlineStyle("transition", "all .2s ease-out, background .2s ease-out")
                    .position(.relative)
                }
            }
        }

        struct Bar: HTML.View {
            let index: Int
            var body: some HTML.View {
                span {}
                    .css
                    .inlineStyle("top", index == 0 ? nil : "\(index * 5)px")
                    .selector("input:checked ~ #menu-icon") {
                        $0
                            .inlineStyle(
                                "top",
                                index == 0 ? nil : index == 1 ? "-5px" : "0"
                            )
                            .inlineStyle(
                                "transform",
                                "rotate(\(index * 45)deg)"
                            )
                            .inlineStyle(
                                "background",
                                index == 0 ? "transparent" : nil
                            )
                    }
            }
        }
    }
}

public struct Login {
    let isLoggedIn: Bool
    let accountHref: String
    let signupHref: String
    let loginHref: String

    public init(isLoggedIn: Bool, accountHref: String, signupHref: String, loginHref: String) {
        self.isLoggedIn = isLoggedIn
        self.accountHref = accountHref
        self.signupHref = signupHref
        self.loginHref = loginHref
    }
}

public struct NavigationBarSVGLogo<Content: HTML.View>: HTML.View {
    let href: HTML.Href.Attribute
    let content: Content

    public init(
        href: HTML.Href.Attribute,
        @HTML.Builder svg: () -> Content
    ) {
        self.content = svg()
        self.href = href
    }

    public var body: some HTML.View {
        Link(href: href) {
            content
        }
    }
}

public struct NavigationBarCenteredNavItems: HTML.View {

    let items: [NavListItem]

    public init(items: [NavListItem]) {
        self.items = items
    }

    public var body: some HTML.View {
        ul {
            HTML.Group {
                HTMLForEach(self.items) { item in
                    item
                }
            }
            .css
            .desktop {
                $0.padding(left: .small)
            }
        }

    }

    public struct NavListItem: HTML.View {
        let title: String
        let href: HTML.Href.Attribute

        public init(_ title: String, href: HTML.Href.Attribute) {
            self.title = title
            self.href = href
        }
        public var body: some HTML.View {
            li {
                Link(
                    title,
                    href: href
                )
                .css
                .pseudo(.not(.firstChild)) {
                    $0.padding(left: .rem(2))
                }
            }
            .css
            .display(.inline)
        }
    }
}

public struct NavigationBarTrailingNavItems: HTML.View {

    let items: [NavListItem]

    public init(
        items: [NavListItem]
    ) {
        self.items = items
    }

    public var body: some HTML.View {
        ul {
            HTMLForEach(self.items) { item in
                item
            }
            .css
            .display(.inline)
            .pseudo(.not(.firstChild)) {
                $0.padding(left: .rem(1))
            }
        }
    }

    public struct NavListItem: HTML.View {
        let title: String
        let href: HTML.Href.Attribute

        public init(_ title: String, href: HTML.Href.Attribute) {
            self.title = title
            self.href = href
        }
        public var body: some HTML.View {
            li {
                Link(
                    title,
                    href: href
                )
                .css
                .display(.block)
            }
        }
    }
}

#if DEBUG && canImport(SwiftUI)
    import SwiftUI

    var content: some HTML.View {
        NavigationBar {
            div {}
        } centeredNavItems: {
            NavigationBarCenteredNavItems(
                items: [
                    .init("hello", href: "#"),
                    .init("THERE", href: "#"),
                ]
            )
        } trailingNavItems: {
            NavigationBarTrailingNavItems(
                items: [
                    .init("TEST", href: ""),
                    .init("TEST2", href: ""),
                ]
            )
        } mobileNavItems: {
            ul {
                li { "test1" }
                li { "test2" }
            }
        }
    }

    #Preview {
        HTML.Document {
            content

            HTMLSourceText(html: content)
        }
        .frame(width: 400, height: 900)

    }
#endif

struct HTMLSourceText<Content: HTML.View>: HTML.View {

    let html: Content
    var body: some HTML.View {
        HTML.Text(
            try! String(
                HTML.Document {
                    html
                }
            )
        )
    }
}
