import Foundation
import HTML

extension HTML.View {
    @HTML.Builder
    public func focusOnPageLoad() -> some HTML.View {
        let focusClass = "focus-on-load-\(UUID().uuidString)"

        HTML.Group {
            self.class(.init(focusClass))

            script {
                """
                document.addEventListener('DOMContentLoaded', function() {
                    const elements = document.getElementsByClassName('\(focusClass)');
                    if (elements.length > 0) {
                        elements[0].focus();
                    }
                });
                """
            }
        }
    }
}
