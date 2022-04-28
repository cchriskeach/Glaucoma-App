///MIT License
///
///Copyright (c) 2021 Will Dale
///
///Permission is hereby granted, free of charge, to any person obtaining a copy
///of this software and associated documentation files (the "Software"), to deal
///in the Software without restriction, including without limitation the rights
///to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
///copies of the Software, and to permit persons to whom the Software is
///furnished to do so, subject to the following conditions:
///
///The above copyright notice and this permission notice shall be included in all
///copies or substantial portions of the Software.
///
///THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
///IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
///FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
///LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
///SOFTWARE.
///
import SwiftUI

extension CGPoint {
	
	/// Calculate X and Y delta for each data point, based on data min/max and enclosing frame.
	/// - Parameters:
	///   - frame: Rectangle of enclosing frame
	///   - data: array of `Double`
	/// - Returns: X and Y delta as a `CGPoint`
    static func getStep(frame: CGRect, data: [Double]) -> CGPoint {
        let padding: CGFloat = 30.0

        // stepWidth
        var stepWidth: CGFloat = 0.0
        if data.count < 2 {
            stepWidth = 0.0
        }
        stepWidth = frame.size.width / CGFloat(data.count - 1)

        // stepHeight
        var stepHeight: CGFloat = 0.0

        var min: Double?
        var max: Double?
        if let minPoint = data.min(), let maxPoint = data.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        } else {
            return .zero
        }
        if let min = min, let max = max, min != max {
            if min <= 0 {
                stepHeight = (frame.size.height - padding) / (0.42 * CGFloat(max - min))
            } else {
                stepHeight = (frame.size.height - padding) / (0.42 * CGFloat(max + min))
            }
        }

        return CGPoint(x: stepWidth, y: stepHeight)
    }
}
