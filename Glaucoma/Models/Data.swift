//
//  Data.swift
//  Glaucoma
//
//  Created by Christopher Keach on 4/28/22.
//

import Foundation
import SwiftUI

struct TonometerData{
    let data: Double
}

protocol Payload{
    init?(_ value: Data)
}

extension TonometerData: Payload{
    init?(_ value: Data){
        //use this guard for an expected number of bytes
//        guard value.count == 1 else{
//            print(value.count)
//            print("ERROR Unexpected number of bytes")
//            return nil
//        }
        data = Double(String(decoding: value, as: UTF8.self))!
    }
}
