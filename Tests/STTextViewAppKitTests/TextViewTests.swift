#if os(macOS)
    import XCTest
    @testable import STTextViewAppKit

    @MainActor
    class TextViewTests: XCTestCase {

        private func makeEditorWindow(text: String = "") -> (NSWindow, NSScrollView, STTextView) {
            let scrollView = STTextView.scrollableTextView()
            let textView = scrollView.documentView as! STTextView
            scrollView.automaticallyAdjustsContentInsets = false
            textView.frame = CGRect(x: 0, y: 0, width: 500, height: 320)
            textView.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
            textView.text = text

            let window = NSWindow(
                contentRect: NSRect(x: 100, y: 100, width: 500, height: 320),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            window.contentView = scrollView
            window.makeKeyAndOrderFront(nil)
            scrollView.layoutSubtreeIfNeeded()
            textView.layoutSubtreeIfNeeded()
            window.displayIfNeeded()

            return (window, scrollView, textView)
        }

        func testInitialSelection() {
            let nstv = NSTextView()
            let sttv = STTextView()

            XCTAssertEqual(nstv.selectedRange(), sttv.textSelection)
        }

        func testCurrentEditorContextWithoutLineGeometryOnEmptyDocument() throws {
            let (window, _, textView) = makeEditorWindow()
            defer { window.close() }

            let context = try XCTUnwrap(textView.currentEditorContext())

            XCTAssertTrue(context.isEmptyLine)
            XCTAssertEqual(context.lineIndex, 0)
            XCTAssertGreaterThan(context.rowRectInEditor.width, context.caretRectInEditor.width)
            XCTAssertEqual(context.caretRectInEditor.minY, context.rowRectInEditor.minY, accuracy: 0.5)
            XCTAssertEqual(context.caretRectInEditor.height, context.rowRectInEditor.height, accuracy: 0.5)
        }

        func testCurrentEditorContextUsesVisibleMetricsWithoutLineGeometry() throws {
            let (window, _, textView) = makeEditorWindow(text: "Alpha\n\nGamma")
            defer { window.close() }

            textView.setSelectedRange(NSRange(location: 6, length: 0))
            textView.layoutSubtreeIfNeeded()
            window.displayIfNeeded()

            let context = try XCTUnwrap(textView.currentEditorContext())
            let visibleMetric = try XCTUnwrap(
                textView.visibleLineMetrics().first { metric in
                    metric.lineIndex == context.lineIndex &&
                        metric.hasBackingParagraph == context.hasBackingParagraph &&
                        abs(metric.rowRect.minY - context.rowRectInEditor.minY) < 0.5
                }
            )

            XCTAssertTrue(context.isEmptyLine)
            XCTAssertEqual(context.rowRectInEditor.minY, visibleMetric.rowRect.minY, accuracy: 0.5)
            XCTAssertEqual(context.rowRectInEditor.height, visibleMetric.rowRect.height, accuracy: 0.5)
            XCTAssertEqual(context.caretRectInEditor.minY, visibleMetric.textBandRect.minY, accuracy: 0.5)
            XCTAssertEqual(context.caretRectInEditor.height, visibleMetric.textBandRect.height, accuracy: 0.5)
            XCTAssertGreaterThan(visibleMetric.textBandRect.width, 0)
            XCTAssertGreaterThanOrEqual(visibleMetric.textBandRect.width, context.rowRectInEditor.width - 0.5)
        }

        func testVisibleLineMetricsExposeFullTextBandWithLineGeometry() throws {
            let (window, _, textView) = makeEditorWindow(text: "Alpha")
            defer { window.close() }

            textView.lineGeometryConfiguration = STLineGeometryConfiguration(rowHeight: 32, textBandHeight: 18, baselineOffset: 5)
            textView.setSelectedRange(NSRange(location: 0, length: 0))
            textView.layoutSubtreeIfNeeded()
            window.displayIfNeeded()

            let context = try XCTUnwrap(textView.currentEditorContext())
            let visibleMetric = try XCTUnwrap(textView.visibleLineMetrics().first)
            let segmentFrame = try XCTUnwrap(
                textView.textLayoutManager.textSegmentFrame(at: textView.textLayoutManager.documentRange.location, type: .standard)
            )

            XCTAssertEqual(context.rowRectInEditor.minY, visibleMetric.rowRect.minY, accuracy: 0.5)
            XCTAssertEqual(context.caretRectInEditor.minY, visibleMetric.textBandRect.minY, accuracy: 0.5)
            XCTAssertEqual(context.caretRectInEditor.height, visibleMetric.textBandRect.height, accuracy: 0.5)
            XCTAssertGreaterThan(visibleMetric.textBandRect.width, segmentFrame.width)
            XCTAssertEqual(visibleMetric.textBandRect.width, visibleMetric.rowRect.width, accuracy: 0.5)
        }

    }

#endif
