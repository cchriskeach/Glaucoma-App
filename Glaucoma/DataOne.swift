//
//  DataOne.swift
//  Glaucoma
//
//  Created by Christopher Keach on 12/11/20.
//

import SwiftUI

struct DataOne: View {
    @Binding var floatData:Float
    var imgName = ""

    mutating func update(){
        if floatData >= 67 && floatData <= 100 {
            self.imgName = "\(floatData).circle.fill"
        } else if floatData >= 33 && floatData <= 66 {
            self.imgName = "\(floatData).circle.fill"
        } else if floatData >= 0 && floatData < 33 {
            self.imgName = "\(floatData).circle.fill"
        } else {
            print("Not a valid number")
        }
    }
    
    var body: some View{
        HStack{
            Image(imgName)
        }
    }
}
