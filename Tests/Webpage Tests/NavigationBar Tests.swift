//
//  NavigationBar Tests.swift
//  swift-webpage
//
//  Regression tests for fable-448 F-002.
//

import Testing
@testable import Webpage
import HTML

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
