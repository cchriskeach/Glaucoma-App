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

/// A single "row" (slice) of data, a view in a `PieChart`
public struct PieChartRow: View {
    @ObservedObject var chartData: ChartData
    @EnvironmentObject var chartValue: ChartValue

    var style: ChartStyle

    var slices: [PieSlice] {
        var tempSlices: [PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue: Double = chartData.points.reduce(0, +)
        
        for slice in chartData.points {
            let normalized: Double = Double(slice) / (maxValue == 0 ? 1 : maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice))
        }
        
        return tempSlices
    }

    @State private var currentTouchedIndex = -1 {
        didSet {
            if oldValue != currentTouchedIndex {
                chartValue.interactionInProgress = currentTouchedIndex != -1
                guard currentTouchedIndex != -1 else { return }
                chartValue.currentValue = slices[currentTouchedIndex].value
            }
        }
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.slices.count) { index in
                    PieChartCell(
                        rect: geometry.frame(in: .local),
                        startDeg: self.slices[index].startDeg,
                        endDeg: self.slices[index].endDeg,
                        index: index,
                        backgroundColor: self.style.backgroundColor.startColor,
                        accentColor: self.style.foregroundColor.rotate(for: index)
                    )
                    .scaleEffect(currentTouchedIndex == index ? 1.1 : 1)
                    .animation(Animation.spring())
                }
            }
            .gesture(DragGesture()
                        .onChanged({ value in
                            let rect = geometry.frame(in: .local)
                            let isTouchInPie = isPointInCircle(point: value.location, circleRect: rect)
                            if isTouchInPie {
                                let touchDegree = degree(for: value.location, inCircleRect: rect)
                                currentTouchedIndex = slices.firstIndex(where: { $0.startDeg < touchDegree && $0.endDeg > touchDegree }) ?? -1
                            } else {
                                currentTouchedIndex = -1
                            }
                        })
                        .onEnded({ value in
                            currentTouchedIndex = -1
                        })
            )
        }
    }
}
