//
//  Length.swift
//  swift-webpage
//
//  Semantic spacing scale shared by the Webpage components.
//
//  Restored during the §Swap-2 institute port. The pre-port file was commented out
//  wholesale, which left `.extraSmall` / `.small` / `.medium` unresolved at the
//  NavigationBar and NavItem call sites. Only the spacing scale is restored here —
//  the pre-port file also carried a font-size scale and `.root`/`.primary`/`.secondary`
//  aliases that no call site references; those stay retired rather than re-entering
//  the public surface unused.
//

import HTML

extension W3C_CSS_Values.LengthPercentage {
    public static let extraSmall: Self = .rem(0.5)
    public static let small: Self = .rem(0.75)
    public static let medium: Self = .rem(1.5)
    public static let large: Self = .rem(3)
    public static let extraLarge: Self = .rem(6)
}
