import HTML
import Testing

@testable import Webpage

@Suite("PageModuleSeeAllTitle")
struct Tests {
    @Test
    func seeAllAnchorRendersLabelNotLiteralSourceText() throws {
        let view = PageModuleSeeAllTitle(title: "Latest", seeAllURL: "/all")
        let rendered = try String(HTML.Document { view })
        #expect(!rendered.contains("String.see_all"))
        #expect(rendered.contains("See all"))
    }
}
