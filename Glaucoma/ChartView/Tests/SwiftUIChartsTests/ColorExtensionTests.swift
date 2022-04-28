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
//  ColorExtensionTests.swift
//  SwiftUIChartsTests
//
//  Created by Adrian Bolinger on 5/24/20.
//

@testable import SwiftUICharts
import SwiftUI
import XCTest

class ColorExtensionTests: XCTestCase {
    func testTwentyFourBitRGBColors() {
        let actualWhite = Color(hexString: "FFFFFF")
        let expectedWhite = Color(red: 1, green: 1, blue: 1)
        XCTAssertEqual(actualWhite, expectedWhite)
        
        let actualBlack = Color(hexString: "000000")
        let expectedBlack = Color(red: 0, green: 0, blue: 0)
        XCTAssertEqual(actualBlack, expectedBlack)
        
        let actualRed = Color(hexString: "FF0000")
        let expectedRed = Color(red: 255/255, green: 0, blue: 0)
        XCTAssertEqual(actualRed, expectedRed)
        
        let actualGreen = Color(hexString: "00FF00")
        let expectedGreen = Color(red: 0, green: 1, blue: 0)
        XCTAssertEqual(actualGreen, expectedGreen)
        
        let actualBlue = Color(hexString: "0000FF")
        let expectedBlue = Color(red: 0, green: 0, blue: 1)
        XCTAssertEqual(actualBlue, expectedBlue)
    }
    
    func testTwelveBitRGBColors() {
        let actualWhite = Color(hexString: "FFF")
        let expectedWhite = Color(red: 1, green: 1, blue: 1)
        XCTAssertEqual(actualWhite, expectedWhite)
        
        let actualBlack = Color(hexString: "000")
        let expectedBlack = Color(red: 0, green: 0, blue: 0)
        XCTAssertEqual(actualBlack, expectedBlack)
        
        let actualRed = Color(hexString: "F00")
        let expectedRed = Color(red: 255/255, green: 0, blue: 0)
        XCTAssertEqual(actualRed, expectedRed)
        
        let actualGreen = Color(hexString: "0F0")
        let expectedGreen = Color(red: 0, green: 1, blue: 0)
        XCTAssertEqual(actualGreen, expectedGreen)
        
        let actualBlue = Color(hexString: "00F")
        let expectedBlue = Color(red: 0, green: 0, blue: 1)
        XCTAssertEqual(actualBlue, expectedBlue)
    }
}
