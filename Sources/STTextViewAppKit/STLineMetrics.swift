import AppKit

public struct STLineMetrics {
    public let lineIndex: Int
    public let rowRect: CGRect
    public let textBandRect: CGRect
    public let baselineY: CGFloat
    public let hasBackingParagraph: Bool
    /// `true` when this metrics entry describes a visual row that is a wrapped
    /// continuation of a paragraph (i.e. not the paragraph's first line fragment
    /// and not an extra line fragment). Default `false` for source-compat.
    public let isContinuation: Bool

    public init(
        lineIndex: Int,
        rowRect: CGRect,
        textBandRect: CGRect,
        baselineY: CGFloat,
        hasBackingParagraph: Bool,
        isContinuation: Bool = false
    ) {
        self.lineIndex = lineIndex
        self.rowRect = rowRect
        self.textBandRect = textBandRect
        self.baselineY = baselineY
        self.hasBackingParagraph = hasBackingParagraph
        self.isContinuation = isContinuation
    }
}
