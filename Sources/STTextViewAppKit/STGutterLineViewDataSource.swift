//  Created by Marcin Krzyzanowski
//  https://github.com/krzyzanowskim/STTextView/blob/main/LICENSE.md

import AppKit

/// A data source that provides custom views for the gutter area of a text view.
///
/// Implement this protocol to supply one `NSView` per visible line in the
/// custom gutter. The data source is queried during layout for each line
/// that is currently in the viewport.
///
/// Use together with ``STTextView/customGutterWidth`` to reserve horizontal
/// space for the gutter area.
public protocol STGutterLineViewDataSource: AnyObject {

    /// Returns the view to display in the custom gutter for the given line.
    ///
    /// - Parameters:
    ///   - textView: The text view requesting the view.
    ///   - lineNumber: The 1-based line number.
    ///   - content: The plain-text content of the line (trailing newline stripped).
    /// - Returns: An `NSView` to be positioned in the gutter alongside the line.
    func textView(_ textView: STTextView, viewForGutterLine lineNumber: Int, content: String) -> NSView

    /// Returns the view to display in the custom gutter for the given visual row.
    ///
    /// Called once per visual row (including wrapped continuation rows). When a
    /// paragraph wraps to multiple visual rows, the first row has
    /// `isContinuation=false`, and every subsequent wrapped row has
    /// `isContinuation=true`. Conforming types can use this to hide
    /// paragraph-level badges (syllable counts, rhyme labels, line numbers) on
    /// continuation rows while still drawing row-level accents.
    ///
    /// The default implementation forwards to
    /// ``textView(_:viewForGutterLine:content:)`` for source compatibility —
    /// existing conformers keep working.
    func textView(
        _ textView: STTextView,
        viewForGutterLine lineNumber: Int,
        content: String,
        isContinuation: Bool
    ) -> NSView

    /// Attempts to update an existing gutter line view in-place rather than recreating it.
    ///
    /// Implement this method to update the content of an already-visible gutter view without
    /// destroying and recreating it (which is expensive for NSHostingView). If the view cannot
    /// be updated in-place, return `false` — the caller will fall back to creating a new view.
    ///
    /// The default implementation returns `false` (no in-place update).
    ///
    /// - Parameters:
    ///   - textView: The text view requesting the update.
    ///   - existingView: The view currently displayed for this line.
    ///   - lineNumber: The 1-based line number.
    ///   - content: The current plain-text content of the line.
    /// - Returns: `true` if the view was updated successfully; `false` to trigger recreation.
    func textView(_ textView: STTextView, updateView existingView: NSView, forGutterLine lineNumber: Int, content: String) -> Bool

    /// Attempts to update an existing gutter line view in-place for a specific visual row.
    ///
    /// The default implementation forwards to
    /// ``textView(_:updateView:forGutterLine:content:)`` for source compatibility.
    func textView(
        _ textView: STTextView,
        updateView existingView: NSView,
        forGutterLine lineNumber: Int,
        content: String,
        isContinuation: Bool
    ) -> Bool
}

public extension STGutterLineViewDataSource {
    /// Default: forwards to the paragraph-level builder for source compatibility.
    /// Conformers that care about continuation rows can override this overload.
    func textView(
        _ textView: STTextView,
        viewForGutterLine lineNumber: Int,
        content: String,
        isContinuation: Bool
    ) -> NSView {
        self.textView(textView, viewForGutterLine: lineNumber, content: content)
    }

    /// Default: no in-place update — caller recreates the view.
    func textView(_ textView: STTextView, updateView existingView: NSView, forGutterLine lineNumber: Int, content: String) -> Bool {
        false
    }

    /// Default: forwards to the paragraph-level updater for source compatibility.
    func textView(
        _ textView: STTextView,
        updateView existingView: NSView,
        forGutterLine lineNumber: Int,
        content: String,
        isContinuation: Bool
    ) -> Bool {
        self.textView(textView, updateView: existingView, forGutterLine: lineNumber, content: content)
    }
}
