//  Created by Marcin Krzyzanowski
//  https://github.com/krzyzanowskim/STTextView/blob/main/LICENSE.md

import AppKit

extension STTextView: NSTextLayoutManagerDelegate {

    public func textLayoutManager(_ textLayoutManager: NSTextLayoutManager, textLayoutFragmentFor location: NSTextLocation, in textElement: NSTextElement) -> NSTextLayoutFragment {
        let paragraphStyle: NSParagraphStyle
        if let lineGeometryConfiguration {
            paragraphStyle = notebookParagraphStyle(for: lineGeometryConfiguration)
        } else {
            paragraphStyle = _defaultTypingAttributes[.paragraphStyle] as? NSParagraphStyle ?? .default
        }

        let textLayoutFragment = STTextLayoutFragment(
            textElement: textElement,
            range: textElement.elementRange,
            paragraphStyle: paragraphStyle,
            lineGeometryConfiguration: lineGeometryConfiguration
        )
        return textLayoutFragment
    }

    private func notebookParagraphStyle(for lineGeometryConfiguration: STLineGeometryConfiguration) -> NSParagraphStyle {
        let paragraphStyle = (defaultParagraphStyle.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.minimumLineHeight = lineGeometryConfiguration.rowHeight
        paragraphStyle.maximumLineHeight = lineGeometryConfiguration.rowHeight
        return paragraphStyle.copy() as? NSParagraphStyle ?? paragraphStyle
    }
}
