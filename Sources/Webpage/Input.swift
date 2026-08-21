import HTML

public struct Input<CodingKey: RawRepresentable>: HTML.View where CodingKey.RawValue == String {
    public let codingKey: CodingKey
    public let disabled: HTML.Disabled.Attribute?
    public let form: HTML.Form.Attribute.ID?
    public let type: HTML.Input.Element.Variant
    public var style: Input.Style = .default

    public init(
        codingKey: CodingKey,
        disabled: HTML.Disabled.Attribute? = nil,
        form: HTML.Form.Attribute.ID? = nil,
        type: HTML.Input.Element.Variant
    ) {
        self.codingKey = codingKey
        self.disabled = disabled
        self.form = form
        self.type = type
    }

    public var body: some HTML.View {
        style.transform(
            input.init(
                name: .init(codingKey.rawValue),
                disabled: disabled,
                form: form,
                type: type
            )
            .id(codingKey.rawValue)
        )
    }
}

extension Input {
    public enum Style {
        case `default`
        case outlined
        case filled
        case minimal
        case error
        case success

        @HTML.Builder
        public func transform(_ html: some HTML.View) -> some HTML.View {
            switch self {
            case .default:
                html
                    .css
                    .padding(vertical: .px(14), horizontal: .px(10))
                    .border(width: .px(1), color: .gray900.withDarkColor(.gray100))
                    .backgroundColor(.white.withDarkColor(.black))
                    .color(.text.secondary)
                    .borderRadius(.px(5))

            case .outlined:
                html
                    .css
                    .padding(vertical: .px(14), horizontal: .px(10))
                    .border(width: .px(2), color: .blue500.withDarkColor(.blue400))
                    .backgroundColor(.transparent)
                    .color(.text.primary)
                    .borderRadius(.px(5))

            case .filled:
                html
                    .css
                    .padding(vertical: .px(14), horizontal: .px(10))
                    .border(.hidden)
                    .backgroundColor(.gray100.withDarkColor(.gray800))
                    .color(.text.primary)
                    .borderRadius(.px(5))

            case .minimal:
                html
                    .css
                    .padding(vertical: .px(8), horizontal: .px(4))
                    .border(.hidden)
                    .backgroundColor(.transparent)
                    .color(.text.primary)
                    .borderBottom(.init(.px(5), .solid))

            case .error:
                html
                    .css
                    .padding(vertical: .px(14), horizontal: .px(10))
                    .border(width: .px(1), color: .red500.withDarkColor(.red400))
                    .backgroundColor(DarkModeColor.red100.withDarkColor(.red900))
                    .color(.text.primary)
                    .borderRadius(.px(5))

            case .success:
                html
                    .css
                    .padding(vertical: .px(14), horizontal: .px(10))
                    .border(width: .px(1), color: .green500.withDarkColor(.green400))
                    .backgroundColor(.green100.withDarkColor(.green900))
                    .color(.text.primary)
                    .borderRadius(.px(5))
            }
        }
    }
}

extension Input {
    public func style(_ style: Style) -> Self {
        var copy = self
        copy.style = style
        return copy
    }
}
