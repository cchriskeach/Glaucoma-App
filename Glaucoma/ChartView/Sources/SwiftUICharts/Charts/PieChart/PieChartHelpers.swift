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
import SwiftUI

func isPointInCircle(point: CGPoint, circleRect: CGRect) -> Bool {
    let r = min(circleRect.width, circleRect.height) / 2
    let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
    let dx = point.x - center.x
    let dy = point.y - center.y
    let distance = sqrt(dx * dx + dy * dy)
    return distance <= r
}

func degree(for point: CGPoint, inCircleRect circleRect: CGRect) -> Double {
    let center = CGPoint(x: circleRect.midX, y: circleRect.midY)
    let dx = point.x - center.x
    let dy = point.y - center.y
    let acuteDegree = Double(atan(dy / dx)) * (180 / .pi)
    
    let isInBottomRight = dx >= 0 && dy >= 0
    let isInBottomLeft = dx <= 0 && dy >= 0
    let isInTopLeft = dx <= 0 && dy <= 0
    let isInTopRight = dx >= 0 && dy <= 0
    
    if isInBottomRight {
        return acuteDegree
    } else if isInBottomLeft {
        return 180 - abs(acuteDegree)
    } else if isInTopLeft {
        return 180 + abs(acuteDegree)
    } else if isInTopRight {
        return 360 - abs(acuteDegree)
    }
    
    return 0
}
