import AppKit

public struct STLineGeometryConfiguration: Equatable, Sendable {
    public let rowHeight: CGFloat
    public let textBandHeight: CGFloat
    public let baselineOffset: CGFloat

    public init(rowHeight: CGFloat, textBandHeight: CGFloat, baselineOffset: CGFloat) {
        self.rowHeight = rowHeight
        self.textBandHeight = textBandHeight
        self.baselineOffset = baselineOffset
    }
}
