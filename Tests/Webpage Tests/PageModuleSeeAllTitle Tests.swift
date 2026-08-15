//
//  PageModuleSeeAllTitle Tests.swift
//  swift-webpage
//
//  Regression tests for fable-448 F-001. `PageModuleSeeAllTitle` is generic
//  over `Title`, so this uses the generic-namespace carve-out: a top-level
//  `@Suite("Name") struct Tests`.
//

import HTML
import Testing

@testable import Webpage

@Suite("PageModuleSeeAllTitle")
struct Tests {
    @Test
    func seeAllAnchorRendersLabelNotLiteralSourceText() throws {
        let view = PageModuleSeeAllTitle(title: "Latest", seeAllURL: "/all")
        let rendered = try String(HTML.Document { view })
        #expect(!rendered.contains("String.seeAll"))
        #expect(rendered.contains("See all"))
    }
}
