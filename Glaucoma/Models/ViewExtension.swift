//
//  ViewExtension.swift
//  Glaucoma
//
//  Created by Christopher Keach on 4/1/22.
//

import Foundation
import SwiftUI

extension View{
    func animate(duration: Double = 1, delay: Double = 0,_ action: @escaping () -> Void) -> some View{
        let animation = Animation.easeInOut(duration: duration).delay(delay)

        return onAppear{
            withAnimation(animation){
                action()
            }
        }
    }

    func animateForever(duration: Double = 1, delay: Double = 0, autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View{
        let animations = Animation.easeInOut(duration: duration).delay(delay)
        let repeated = animations.repeatForever(autoreverses: autoreverses)

        return onAppear{
            withAnimation(repeated){
                action()
            }
        }
    }
    
//    func animateForever(using animation: Animation = .easeInOut(duration: 10), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View{
//        let repeated = animation.repeatForever(autoreverses: autoreverses)
//
//        return onAppear{
//            withAnimation(repeated){
//                action()
//            }
//        }
//    }
}

