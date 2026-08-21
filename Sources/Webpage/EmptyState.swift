import Foundation
import HTML

public struct EmptyState<Action: HTML.View>: HTML.View {

    let icon: String?

    let title: String

    let description: String?

    let action: Action?

    let textAlign: TextAlign

    let spacing: W3C_CSS_Values.Length?

    let iconSize: LengthPercentage?

    public init(
        icon: String? = nil,
        title: String,
        description: String? = nil,
        textAlign: TextAlign = .center,
        spacing: W3C_CSS_Values.Length? = nil,
        iconSize: LengthPercentage? = nil,
        @HTML.Builder action: () -> Action
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.textAlign = textAlign
        self.spacing = spacing
        self.iconSize = iconSize
        self.action = action()
    }

    public var body: some HTML.View {
        div {
            VStack(spacing: spacing ?? .rem(1)) {

                if let icon = icon {
                    div { icon }
                        .css
                        .fontSize(.lengthPercentage(iconSize ?? .rem(3)))
                        .marginBottom(.rem(0.5))
                }

                Header(2) { title }
                    .css
                    .fontSize(.rem(1.5))
                    .color(.text.primary)
                    .marginBottom(.rem(0.5))

                if let description = description {
                    Paragraph { description }
                        .css
                        .color(.text.secondary)
                        .maxWidth(.rem(30))
                        .marginRight(.auto)
                        .marginLeft(.auto)
                        .marginBottom(.rem(1))
                }

                if let action = action {
                    div { action }
                        .css
                        .marginTop(.rem(1))
                }
            }
        }
        .css
        .textAlign(textAlign)
        .padding(vertical: .rem(3), horizontal: .rem(2))
    }
}

extension EmptyState where Action == HTML.Empty {

    public init(
        icon: String? = nil,
        title: String,
        description: String? = nil,
        textAlign: TextAlign = .center,
        spacing: W3C_CSS_Values.Length? = nil,
        iconSize: LengthPercentage? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.textAlign = textAlign
        self.spacing = spacing
        self.iconSize = iconSize
        self.action = nil
    }
}

extension EmptyState {

    public static func noData<A: HTML.View>(
        title: String = "No Data Yet",
        description: String? = "Start by adding some data to see it here.",
        @HTML.Builder action: () -> A = { HTML.Empty() }
    ) -> EmptyState<A> {
        EmptyState<A>(
            icon: "📊",
            title: title,
            description: description,
            action: action
        )
    }

    public static func noResults<A: HTML.View>(
        searchTerm: String? = nil,
        @HTML.Builder action: () -> A = { HTML.Empty() }
    ) -> EmptyState<A> {
        let description = searchTerm.map { "No results found for \"\($0)\"" } ?? "No results found"
        return EmptyState<A>(
            icon: "🔍",
            title: "No Results",
            description: description,
            action: action
        )
    }

    public static func comingSoon<A: HTML.View>(
        feature: String? = nil,
        @HTML.Builder action: () -> A = { HTML.Empty() }
    ) -> EmptyState<A> {
        let title = feature.map { "\($0) Coming Soon" } ?? "Coming Soon"
        return EmptyState<A>(
            icon: "🚀",
            title: title,
            description: "This feature is under development and will be available soon.",
            action: action
        )
    }

    public static func error<A: HTML.View>(
        message: String? = "Something went wrong. Please try again.",
        @HTML.Builder action: () -> A = { HTML.Empty() }
    ) -> EmptyState<A> {
        EmptyState<A>(
            icon: "⚠️",
            title: "Error",
            description: message,
            action: action
        )
    }
}
