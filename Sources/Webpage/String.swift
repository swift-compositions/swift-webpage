//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 03/09/2024.
//

import Foundation
import HTML
import INCITS_4_1986

extension String {
    /// Renders `document` to a string, trapping instead of propagating a
    /// throw. For call sites that render statically-known, already-typed
    /// content (previews, source-text fallbacks) a render failure indicates
    /// a programming bug in this module, not a recoverable runtime
    /// condition — matching the crash-on-failure behavior a bare `try!`
    /// would have had, without leaving `try!` itself in the source.
    static func renderOrTrap<Body: HTML.View, Head: HTML.View>(
        _ document: HTML.Document<Body, Head>
    ) -> String {
        do {
            return try String(document)
        } catch {
            preconditionFailure(
                "HTML.Document render failed for statically-known content: \(error)"
            )
        }
    }
}

extension String {
    public static func sanitizeForJavaScript(_ input: String, preserveCase: Bool = true) -> String {
        // Filter to alphanumeric and underscore characters only
        let sanitized = input.unicodeScalars.filter { scalar in
            scalar.value < 128
                && (INCITS_4_1986.Classification.isAlphanumeric(UInt8(scalar.value))
                    || scalar == "_")
        }
        var sanitizedString = String(String.UnicodeScalarView(sanitized))

        if !preserveCase {
            sanitizedString = sanitizedString.lowercased().capitalized
        }
        if sanitizedString.isEmpty || sanitizedString.first?.isLetter == false {
            sanitizedString = "js_" + sanitizedString
        }

        return sanitizedString
    }
}
