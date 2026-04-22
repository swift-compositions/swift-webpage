//
//  WebpageTests.swift
//  swift-webpage
//
//  Created by Coen ten Thije Boonkkamp on 02/12/2025.
//

import Testing
@testable import Webpage

@Suite("Webpage Tests")
struct WebpageTests {
    @Test func buttonStylesExist() {
        #expect(ButtonStyle.primary == ButtonStyle.primary)
        #expect(ButtonStyle.secondary == ButtonStyle.secondary)
        #expect(ButtonStyle.tertiary == ButtonStyle.tertiary)
    }
}
