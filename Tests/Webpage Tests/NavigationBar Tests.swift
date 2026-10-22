import HTML
import Standard_Library_Extensions
import Testing

@testable import Webpage

extension NavigationBar {
    @Suite
    struct Unit {
        @Test
        func primaryInitializerRendersNavItemsInOutput() throws {
            let bar = NavigationBar {
                div { "logo" }
            } items: {
                Link("Articles", href: "/articles")
                Link("Contact", href: "/contact")
            }
            let rendered = try String(HTML.Document { bar })
            #expect(rendered.contains("Articles"))
            #expect(rendered.contains("Contact"))
        }

        @Test
        func `mobile menu rendering remains unchanged`() throws {
            let rendered = try String(
                MobileMenu(
                    items: [
                        Link("Articles", href: "/articles"),
                        NavSpacer(),
                        Link("Contact", href: "/contact"),
                    ]
                )
            )
            let articles = HTML.AnyView(
                div {
                    Link("Articles", href: "/articles")
                }
                .css
                .padding(.rem(1))
                .borderBottom(
                    width: .px(1),
                    style: .solid,
                    color: .border.tertiary
                )
            )
            let contact = HTML.AnyView(
                div {
                    Link("Contact", href: "/contact")
                }
                .css
                .padding(.rem(1))
                .borderBottom(
                    width: .px(1),
                    style: .solid,
                    color: .border.tertiary
                )
            )
            let snapshot = try String(
                div {
                    articles
                    contact
                }
                .class("mobile-menu")
                .css
                .flexBasis(.percent(100))
                .borderTop(
                    width: .px(1),
                    style: .solid,
                    color: .border.secondary
                )
                .marginTop(.rem(1))
            )

            #expect(rendered == snapshot)
        }

        @Test
        func legacyInitializerRendersAllThreeBuildersInOutput() throws {
            let bar = NavigationBar {
                div { "logo" }
            } centeredNavItems: {
                Link("Centered", href: "/centered")
            } trailingNavItems: {
                Link("Trailing", href: "/trailing")
            } mobileNavItems: {
                Link("Mobile", href: "/mobile")
            }
            let rendered = try String(HTML.Document { bar })
            #expect(rendered.contains("Centered"))
            #expect(rendered.contains("Trailing"))
            #expect(rendered.contains("Mobile"))
        }
    }
}
