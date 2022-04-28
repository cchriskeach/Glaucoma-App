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
//
//  CGPointExtensionTests.swift
//  SwiftUIChartsTests
//
//  Created by Adrian Bolinger on 5/24/20.
//

@testable import SwiftUICharts
import XCTest

class CGPointExtensionTests: XCTestCase {
    static let twentyElementArray: [Double] = Array(repeating: Double.random(in: 1...100), count: 20)
    
    func testGetStepWithOneElementArray() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let oneElementArray: [Double] = [0.0]
        
        XCTAssertEqual(CGPoint.getStep(frame: frame, data: oneElementArray), .zero)
    }
    
    func testGetStepWithMultiElementArrayWithNegativeValues() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let multiElementArray: [Double] = [-5.0, 0.0, 5.0]
        XCTAssertEqual(CGPoint.getStep(frame: frame, data: multiElementArray), CGPoint(x: 150.0, y: 27.0))
    }
    
    func testGetStepWithMultiElementArrayWithPositiveValues() {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let multiElementArray: [Double] = [5.0, 10.0, 15.0]
        XCTAssertEqual(CGPoint.getStep(frame: frame, data: multiElementArray), CGPoint(x: 150.0, y: 13.5))
    }
}
