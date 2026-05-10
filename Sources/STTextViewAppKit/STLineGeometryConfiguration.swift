import AppKit

public struct STLineGeometryConfiguration: Equatable, Sendable {
    public let rowHeight: CGFloat
    public let textBandHeight: CGFloat
    public let baselineOffset: CGFloat
    /// When `true`, every text layout fragment strokes a horizontal separator
    /// at the bottom of each visual row it contains — drawn in the same
    /// draw pass as the glyphs, in the same view, in the same coordinate
    /// system. Text and separator are a single paint operation per row and
    /// cannot move relative to each other.
    public let drawsRowSeparator: Bool

    public init(
        rowHeight: CGFloat,
        textBandHeight: CGFloat,
        baselineOffset: CGFloat,
        drawsRowSeparator: Bool = false
    ) {
        self.rowHeight = rowHeight
        self.textBandHeight = textBandHeight
        self.baselineOffset = baselineOffset
        self.drawsRowSeparator = drawsRowSeparator
    }
}
