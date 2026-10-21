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
