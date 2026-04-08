import AppKit

public struct STLineMetrics {
    public let lineIndex: Int
    public let rowRect: CGRect
    public let textBandRect: CGRect
    public let baselineY: CGFloat
    public let hasBackingParagraph: Bool
}
