import AppKit

public struct STEditorContextSnapshot: Equatable, Sendable {
    public let caretLocationUTF16: Int
    public let lineIndex: Int
    public let lineRangeUTF16: NSRange
    public let caretRectInEditor: CGRect
    public let rowRectInEditor: CGRect
    public let textBandRectInEditor: CGRect
    public let currentWordAfterCaretRangeUTF16: NSRange
    public let lineSuffixRangeUTF16: NSRange
    public let lineSuffixText: String
    public let isAtLineStart: Bool
    public let isEmptyLine: Bool
    public let hasBackingParagraph: Bool

    public init(
        caretLocationUTF16: Int,
        lineIndex: Int,
        lineRangeUTF16: NSRange,
        caretRectInEditor: CGRect,
        rowRectInEditor: CGRect,
        textBandRectInEditor: CGRect,
        currentWordAfterCaretRangeUTF16: NSRange,
        lineSuffixRangeUTF16: NSRange,
        lineSuffixText: String,
        isAtLineStart: Bool,
        isEmptyLine: Bool,
        hasBackingParagraph: Bool
    ) {
        self.caretLocationUTF16 = caretLocationUTF16
        self.lineIndex = lineIndex
        self.lineRangeUTF16 = lineRangeUTF16
        self.caretRectInEditor = caretRectInEditor
        self.rowRectInEditor = rowRectInEditor
        self.textBandRectInEditor = textBandRectInEditor
        self.currentWordAfterCaretRangeUTF16 = currentWordAfterCaretRangeUTF16
        self.lineSuffixRangeUTF16 = lineSuffixRangeUTF16
        self.lineSuffixText = lineSuffixText
        self.isAtLineStart = isAtLineStart
        self.isEmptyLine = isEmptyLine
        self.hasBackingParagraph = hasBackingParagraph
    }
}
