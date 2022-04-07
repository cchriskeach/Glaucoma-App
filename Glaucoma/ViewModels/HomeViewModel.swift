//
//  HomeViewModel.swift
//  Glaucoma
//
//  Created by Christopher Keach on 4/7/22.
//

import SwiftUI
import Foundation

class HomeViewModel: ObservableObject{
    @Published var testON: Bool = false
    
    func toggleTest(){
        testON.toggle()
    }
}
