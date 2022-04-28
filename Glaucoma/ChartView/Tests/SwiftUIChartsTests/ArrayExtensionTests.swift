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
//
//  File.swift
//  
//
//  Created by Nicolas Savoini on 2020-05-25.
//

@testable import SwiftUICharts
import XCTest

class ArrayExtensionTests: XCTestCase {

    func testArrayRotatingIndexEmpty() {
        let colors = [ColorGradient]()
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.orangeBright)
    }
    
    func testArrayRotatingIndexOneValue() {
        let colors = [ColorGradient.greenRed]
        
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 1), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 2), ColorGradient.greenRed)
    }
    
    func testArrayRotatingIndexLessValues() {
        let colors = [ColorGradient.greenRed, ColorGradient.whiteBlack]
        
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 1), ColorGradient.whiteBlack)
        XCTAssertEqual(colors.rotate(for: 2), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 3), ColorGradient.whiteBlack)
        XCTAssertEqual(colors.rotate(for: 4), ColorGradient.greenRed)
    }
    
    func testArrayRotatingIndexMoreValues() {
        let colors = [ColorGradient.greenRed, ColorGradient.whiteBlack, ColorGradient.orangeBright]
        
        XCTAssertEqual(colors.rotate(for: 0), ColorGradient.greenRed)
        XCTAssertEqual(colors.rotate(for: 1), ColorGradient.whiteBlack)

    }
  
}
