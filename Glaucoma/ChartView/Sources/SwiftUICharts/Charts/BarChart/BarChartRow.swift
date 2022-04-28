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

/// A single row of data, a view in a `BarChart`
public struct BarChartRow: View {
    @EnvironmentObject var chartValue: ChartValue
    @ObservedObject var chartData: ChartData
    @State private var touchLocation: CGFloat = -1.0

    enum Constant {
        static let spacing: CGFloat = 16.0
    }

    var style: ChartStyle
    
    var maxValue: Double {
        guard let max = chartData.points.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }

	/// The content and behavior of the `BarChartRow`.
	///
	/// Shows each `BarChartCell` in an `HStack`; may be scaled up if it's the one currently being touched.
	/// Not using a drawing group for optimizing animation.
	/// As touched (dragged) the `touchLocation` is updated and the current value is highlighted.
    public var body: some View {
        HStack{
            //y-axis
            VStack{
                Text("\(Int(maxValue))")
                Spacer()
                Text("\(Int(maxValue/2))")
                Spacer()
                Text("0")
            }.padding(.bottom,28).foregroundColor(Color("Inverse"))
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("Inverse")).opacity(0.4)
                    }
                    .frame(width: 1).padding(.bottom,28)
            
        GeometryReader { geometry in
            HStack(alignment: .bottom,
                   spacing: (geometry.frame(in: .local).width - Constant.spacing) / CGFloat(self.chartData.data.count * 3)) {
                
                    ForEach(0..<self.chartData.data.count, id: \.self) { index in
                        VStack{
                        BarChartCell(value: self.normalizedValue(index: index),
                                     label: self.chartData.values[index],
                                     index: index,
                                     width: Float(geometry.frame(in: .local).width - Constant.spacing),
                                     numberOfDataPoints: self.chartData.data.count,
                                     gradientColor: self.style.foregroundColor.rotate(for: index),
                                     touchLocation: self.touchLocation)
                            .scaleEffect(self.getScaleSize(touchLocation: self.touchLocation, index: index), anchor: .bottom)
                            .animation(Animation.easeIn(duration: 0.2))
                            
                            Text("\(self.chartData.values[index])")
                        }
                    }
//                   .drawingGroup()
            }
            .padding([.top, .leading, .trailing], 10)
            .gesture(DragGesture()
                .onChanged({ value in
                    let width = geometry.frame(in: .local).width
                    self.touchLocation = value.location.x/width
                    if let currentValue = self.getCurrentValue(width: width) {
                        self.chartValue.currentValue = currentValue
                        self.chartValue.interactionInProgress = true
                    }
                })
                .onEnded({ value in
                    self.chartValue.interactionInProgress = false
                    self.touchLocation = -1
                })
            )
        }
        }
    }

	/// Value relative to maximum value
	/// - Parameter index: index into array of data
	/// - Returns: data value at given index, divided by data maximum
    func normalizedValue(index: Int) -> Double {
        return Double(chartData.points[index])/Double(maxValue)
    }

	/// Size to scale the touch indicator
	/// - Parameters:
	///   - touchLocation: fraction of width where touch is happening
	///   - index: index into data array
	/// - Returns: a scale larger than 1.0 if in bounds; 1.0 (unscaled) if not in bounds
    func getScaleSize(touchLocation: CGFloat, index: Int) -> CGSize {
        if touchLocation > CGFloat(index)/CGFloat(chartData.data.count) &&
           touchLocation < CGFloat(index+1)/CGFloat(chartData.data.count) {
            return CGSize(width: 1.4, height: 1.1)
        }
        return CGSize(width: 1, height: 1)
    }

	/// Get data value where touch happened
	/// - Parameter width: width of chart
	/// - Returns: value as `Double` if chart has data
    func getCurrentValue(width: CGFloat) -> Double? {
        guard self.chartData.data.count > 0 else { return nil}
            let index = max(0,min(self.chartData.data.count-1,Int(floor((self.touchLocation*width)/(width/CGFloat(self.chartData.data.count))))))
            return self.chartData.points[index]
        }
}
