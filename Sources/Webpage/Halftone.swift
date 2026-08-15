//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 01/09/2024.
//

public import Dependencies
import Foundation
import HTML

public struct Halftone<Image: HTML.View>: HTML.View {
    let grayscale: String
    let dotSize: W3C_CSS_Values.Length
    let lineColor: DarkModeColor
    let lineContrast: Int
    let photoBrightness: Int
    let photoContrast: Int
    let photoBlur: W3C_CSS_Values.Length
    let blendMode: MixBlendMode
    let rotationAngle: Int
    let image: Image

    @Dependency(\.objectStyle.position) var objectPosition

    public var body: some HTML.View {
        div {
            div {
                image
                    .css
                    .objectPosition(objectPosition)
                    .position(.absolute)
                    .top(0)
                    .left(0)
                    .width(.percent(100))
                    .height(.percent(100))
                    .objectFit(.cover)
                    .mixBlendMode(blendMode)
                    .inlineStyle(
                        "filter",
                        """
                            grayscale(\(grayscale))
                            brightness(\(photoBrightness)%)
                            contrast(\(photoContrast)%)
                            blur(\(photoBlur.description))
                        """
                    )
            }
            .css
            .position(.absolute)
            .top(.zero)
            .right(.zero)
            .bottom(.zero)
            .left(.zero)
            .inlineStyle("filter", "contrast(\(lineContrast)%)")
            .overflow(.hidden)
            .before {
                $0
                    .inlineStyle("content", "''")
                    .position(.absolute)
                    .top(.percent(-50))
                    .right(.percent(-50))
                    .bottom(.percent(-50))
                    .left(.percent(-50))
                    .inlineStyle(
                        "background",
                        "radial-gradient(circle at center, \(lineColor.light.description), \(lineColor.dark.description))"
                    )
                    .inlineStyle(
                        "background-size",
                        "\(dotSize.description) \(dotSize.description)"
                    )
                    .transform(.rotate(.deg(Double(rotationAngle))))
            }
        }
    }
}

extension HTML.View {
    public func halftone(
        grayscale: String = "0",
        dotSize: W3C_CSS_Values.Length = .em(0.3),
        lineColor: DarkModeColor = .offBlack.withDarkColor(.offWhite),
        lineContrast: Int = 2000,
        photoBrightness: Int = 100,
        photoContrast: Int = 100,
        photoBlur: W3C_CSS_Values.Length = .px(1),
        blendMode: MixBlendMode = .hardLight,
        rotationAngle: Int = 20
    ) -> some HTML.View {
        Halftone(
            grayscale: grayscale,
            dotSize: dotSize,
            lineColor: lineColor,
            lineContrast: lineContrast,
            photoBrightness: photoBrightness,
            photoContrast: photoContrast,
            photoBlur: photoBlur,
            blendMode: blendMode,
            rotationAngle: rotationAngle,
            image: self
        )
    }
}

// Unsure whether this should be added.
private enum ObjectStyleKey: Dependency.Key {
    static let liveValue = ObjectStyle(position: .inherit)
    static let testValue = ObjectStyle(position: .inherit)
}

extension Dependency.Values {
    public var objectStyle: ObjectStyle {
        get { self[ObjectStyleKey.self] }
        set { self[ObjectStyleKey.self] = newValue }
    }
}

#if DEBUG && canImport(SwiftUI)
    import SwiftUI
    #Preview {
        HTML.Document {
            div {
                // Empty div with background styling
            }
            .css
            .width(.px(300))
            .height(.px(300))
            .inlineStyle("background", "linear-gradient(45deg, #ff6b6b, #4ecdc4)")
            .halftone(  //            dotSize: .px(4),
                //            lineColor: .black
                )
        }
    }

    #Preview {
        HTML.Document {
            HTML.Text(
                String.renderOrTrap(
                    HTML.Document {
                        div {
                            // Empty div with background styling
                        }
                        .halftone()
                        .css
                        .width(.px(300))
                        .height(.px(300))
                        .inlineStyle("background", "linear-gradient(45deg, #ff6b6b, #4ecdc4)")
                    }
                )
            )
        }
    }
#endif

// EXAMPLE FOR GENERATING BLOG POST CARD IMAGE
// PageModule(theme: .content) {
//    div {
//        div {
//            div {
//                Image.prehalftone
//                    .inlineStyle("filter", "sepia(0.8) hue-rotate(-260deg) saturate(2) brightness(1.15) contrast(1.2)")
//                    .halftone(
//                        lineColor: .black.withDarkColor(.white),
//                        lineContrast: 1500,
//                        photoBrightness: 90,
//                        photoContrast: 110,
//                        photoBlur: .px(0.5),
//                        blendMode: .overlay,
//                        rotationAngle: 15
//                    )
//            }
//            .overflow(.hidden)
//        }
//        .height(.px(300))
//        .width(.px(384))
//    }
//    .position(.relative)
// }
