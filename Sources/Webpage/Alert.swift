import HTML

public struct Alert<Content: HTML.View, Actions: HTML.View>: HTML.View {
    public enum Severity {
        case info
        case success
        case warning
        case error

        var backgroundColor: DarkModeColor {
            switch self {
            case .info: return .blue.opacity(0.1)
            case .success: return .green.opacity(0.1)
            case .warning: return .orange.opacity(0.1)
            case .error: return .red.opacity(0.1)
            }
        }

        var borderColor: DarkModeColor {
            switch self {
            case .info: return .blue.opacity(0.3)
            case .success: return .green.opacity(0.3)
            case .warning: return .orange.opacity(0.3)
            case .error: return .red.opacity(0.3)
            }
        }

        var textColor: DarkModeColor {
            switch self {
            case .info: return .blue
            case .success: return .green
            case .warning: return .orange
            case .error: return .red
            }
        }

        var defaultIcon: String {
            switch self {
            case .info: return "ℹ️"
            case .success: return "✅"
            case .warning: return "⚠️"
            case .error: return "❌"
            }
        }
    }

    let severity: Severity
    let title: String?
    let icon: String?
    let dismissible: Bool
    let content: Content
    let actions: Actions

    public init(
        severity: Severity = .info,
        title: String? = nil,
        icon: String? = nil,
        dismissible: Bool = false,
        @HTML.Builder content: () -> Content,
        @HTML.Builder actions: () -> Actions
    ) {
        self.severity = severity
        self.title = title
        self.icon = icon
        self.dismissible = dismissible
        self.content = content()
        self.actions = actions()
    }

    public var body: some HTML.View {
        div {
            div {

                if let icon = icon {
                    span { icon }
                        .css
                        .fontSize(.rem(1.25))
                        .marginRight(.rem(0.75))
                } else {
                    span { severity.defaultIcon }
                        .css
                        .fontSize(.rem(1.25))
                        .marginRight(.rem(0.75))
                }

                div {
                    if let title = title {
                        div { HTML.Text(title) }
                            .css
                            .fontWeight(.semiBold)
                            .marginBottom(.rem(0.25))
                    }

                    content
                }
                .css
                .flexGrow()

                if !(actions is HTML.Empty) {
                    div {
                        actions
                    }
                    .css
                    .display(.flex)
                    .gap(.rem(0.5))
                    .marginLeft(.rem(1))
                }

                if dismissible {
                    button {
                        "×"
                    }
                    .css
                    .fontSize(.rem(1.5))
                    .lineHeight(1)
                    .padding(.rem(0.25))
                    .marginLeft(.rem(1))
                    .backgroundColor(.transparent)
                    .border(.hidden)
                    .cursor(.pointer)
                    .color(severity.textColor)
                    .attribute("onclick", "this.closest('.alert').remove()")
                }
            }
            .css
            .display(.flex)
            .alignItems(.flexStart)
        }
        .class("alert")
        .css
        .padding(.rem(1))
        .backgroundColor(severity.backgroundColor)
        .border(width: .px(1), style: .solid, color: severity.borderColor)
        .borderRadius(.px(8))
        .color(severity.textColor)
    }
}

public struct Banner<Content: HTML.View, Actions: HTML.View>: HTML.View {
    public enum Style {
        case standard
        case slim
        case prominent

        var padding: LengthPercentage {
            switch self {
            case .standard: return .rem(1.5)
            case .slim: return .rem(0.75)
            case .prominent: return .rem(2)
            }
        }
    }

    let style: Style
    let backgroundColor: DarkModeColor
    let textColor: DarkModeColor
    let sticky: Bool
    let content: Content
    let actions: Actions

    public init(
        style: Style = .standard,
        backgroundColor: DarkModeColor = .blue,
        textColor: DarkModeColor = .white,
        sticky: Bool = false,
        @HTML.Builder content: () -> Content,
        @HTML.Builder actions: () -> Actions
    ) {
        self.style = style
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.sticky = sticky
        self.content = content()
        self.actions = actions()
    }

    public var body: some HTML.View {
        div {
            div {
                content

                if !(actions is HTML.Empty) {
                    div {
                        actions
                    }
                    .css
                    .display(.flex)
                    .gap(.rem(1))
                    .marginLeft(.auto)
                }
            }
            .css
            .display(.flex)
            .alignItems(.center)
            .justifyContent(.spaceBetween)
            .maxWidth(.px(1200))
            .margin(.auto)
            .padding(horizontal: style.padding)
        }
        .css
        .padding(vertical: style.padding)
        .backgroundColor(backgroundColor)
        .color(textColor)
        .if(sticky) { banner in
            banner
                .css
                .position(.sticky)
                .top(.px(0))
                .zIndex(100)
        }
    }
}

extension Alert where Actions == HTML.Empty {
    public init(
        severity: Severity = .info,
        title: String? = nil,
        icon: String? = nil,
        dismissible: Bool = false,
        @HTML.Builder content: () -> Content
    ) {
        self.init(
            severity: severity,
            title: title,
            icon: icon,
            dismissible: dismissible,
            content: content,
            actions: { HTML.Empty() }
        )
    }
}

extension Banner where Actions == HTML.Empty {
    public init(
        style: Style = .standard,
        backgroundColor: DarkModeColor = .blue,
        textColor: DarkModeColor = .white,
        sticky: Bool = false,
        @HTML.Builder content: () -> Content
    ) {
        self.init(
            style: style,
            backgroundColor: backgroundColor,
            textColor: textColor,
            sticky: sticky,
            content: content,
            actions: { HTML.Empty() }
        )
    }
}
