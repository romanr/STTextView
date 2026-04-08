import AppKit

public struct STEditorContextSnapshot {
    public let caretLocationUTF16: Int
    public let lineIndex: Int
    public let lineRangeUTF16: NSRange
    public let caretRectInEditor: CGRect
    public let rowRectInEditor: CGRect
    public let currentWordAfterCaretRangeUTF16: NSRange
    public let lineSuffixRangeUTF16: NSRange
    public let lineSuffixText: String
    public let isAtLineStart: Bool
    public let isEmptyLine: Bool
    public let hasBackingParagraph: Bool
}
