import HTML

extension NavigationBar.MobileMenu {
    struct Item: HTML.View {
        let item: any NavItem
    }
}

extension NavigationBar.MobileMenu.Item {
    var body: some HTML.View {
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
