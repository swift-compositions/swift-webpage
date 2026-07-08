//
//  NavItem.swift
//  swift-html
//
//  Navigation item types for NavigationBar
//

import Foundation
import HTML
import CSS_Theming

// MARK: - NavItem Protocol
public typealias NavItem = HTML.View

// MARK: - NavLink
public struct NavLink: HTML.View {
    // `HTML.View` refines the move-only `Render.View` and carries a recursive
    // `Body: HTML.View` constraint, so `any HTML.View` cannot self-conform. The
    // ecosystem composes through the concrete `HTML.AnyView` eraser plus generics
    // (see the type comment on `HTML.AnyView`). Erase once, at construction.
    let title: HTML.AnyView
    let href: Href
    let isActive: Bool

    public init<Title: HTML.View>(
        _ title: Title,
        href: Href,
        isActive: Bool
    ) {
        self.title = HTML.AnyView(title)
        self.href = href
        self.isActive = isActive
    }

    public var body: some HTML.View {
        a(href: href) {
            title
        }
        .css
        .fontWeight(isActive ? .semiBold : nil)
        .color(isActive ? .text.link : .text.tertiary)
        .visited { $0.color(HTMLColor.text.link) }
        .pseudo(.link) { $0.color(HTMLColor.text.link) }
        .visited { $0.textDecoration(TextDecoration.none) }
        .pseudo(.link) { $0.textDecoration(TextDecoration.none) }
        .hover { $0.textDecoration(TextDecoration.underline) }
    }
}

// MARK: - NavButton
public struct NavButton: HTML.View {
    public enum Style {
        case primary
        case secondary
        case danger
        case success

        var backgroundColor: HTMLColor {
            switch self {
            case .primary: return .blue
            case .secondary: return .gray
            case .danger: return .red
            case .success: return .green
            }
        }

        var textColor: HTMLColor {
            switch self {
            case .primary, .danger, .success: return .white
            case .secondary: return .text.primary
            }
        }

        var borderColor: HTMLColor? {
            switch self {
            case .secondary: return .border.secondary
            default: return nil
            }
        }
    }

    let title: String
    let href: Href
    let style: Style

    public init(
        _ title: String,
        href: Href,
        style: Style = .primary
    ) {
        self.title = title
        self.href = href
        self.style = style
    }

    public var body: some HTML.View {
        a(href: href) {
            title
        }
        .css
        .padding(vertical: .rem(0.5), horizontal: .rem(1))
        .backgroundColor(style.backgroundColor)
        .color(style.textColor)
        .borderRadius(.px(4))
        .textDecoration(TextDecoration.none)
        .fontWeight(.medium)
        .if(style.borderColor != nil) { button in
            button.border(
                width: .px(1),
                style: .solid,
                color: style.borderColor!
            )
        }
        .css
        .inlineStyle("transition", "all 0.2s")
        .hover {
            $0
                .opacity(0.9)
                .transform(.translateY(.px(-1)))
        }
    }
}

// MARK: - NavDivider
public struct NavDivider: HTML.View {
    public init() {}

    public var body: some HTML.View {
        span {}
            .css
            .width(.px(1))
            .height(.rem(1.5))
            .backgroundColor(.border.secondary)
            .margin(horizontal: .rem(0.5))
            .display(.inlineBlock)
    }
}

// MARK: - NavDropdown
public struct NavDropdown<Items: HTML.View>: HTML.View {
    let title: String
    let items: Items

    public init(
        _ title: String,
        @HTML.Builder items: () -> Items
    ) {
        self.title = title
        self.items = items()
    }

    public var body: some HTML.View {
        div {
            button {
                title
                span { "▼" }
                    .css
                    .marginLeft(.rem(0.25))
                    .fontSize(.rem(0.75))
            }
            .css
            .backgroundColor(.transparent)
            .border(.hidden)
            .color(.text.primary)
            .cursor(.pointer)
            .padding(.rem(0.5))
            .fontWeight(.medium)

            div {
                items
            }
            .class("dropdown-menu")
            .css
            .selector(":hover .dropdown-menu") { $0.display(.block) }
            .display(Display.none)
            .position(.absolute)
            .top(.percent(100))
            .right(.px(0))
            .backgroundColor(.background.primary)
            .border(.init(width: .px(1), style: .solid, color: .border.secondary))
            .borderRadius(.px(4))
            .padding(.rem(0.5))
            .minWidth(.px(150))
            .zIndex(1000)
            .inlineStyle("box-shadow", "0 4px 6px rgba(0, 0, 0, 0.1)")
        }
        .class("dropdown")
        .css
        .position(.relative)
    }
}

// MARK: - NavSpacer
public struct NavSpacer: HTML.View {
    public init() {}

    public var body: some HTML.View {
        div {}
            .css
            .flexGrow(1)  // Takes up all available space between items
            .desktop { $0.display(.block) }
            .mobile { $0.display(Display.none) }  // Hide on mobile
    }
}

// MARK: - NavGroup
public struct NavGroup<Items: HTML.View>: HTML.View {
    let items: Items
    let spacing: W3C_CSS_Values.Length

    public init(
        spacing: W3C_CSS_Values.Length = .rem(1),
        @HTML.Builder items: () -> Items
    ) {
        self.items = items()
        self.spacing = spacing
    }

    public var body: some HTML.View {
        div {
            items
        }
        .css
        .display(.flex)
        .alignItems(.center)
        .gap(.length(spacing))
    }
}
