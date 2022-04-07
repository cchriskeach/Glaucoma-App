//
//  BLEConnectView.swift
//  Glaucoma
//
//  Created by Christopher Keach on 3/16/22.
//

import SwiftUI

struct BLEMasterView: View {
    @State var nextScreen = false
    
    var body: some View {
        VStack{
            if nextScreen{
                AppView()
            } else {
                BLEConnectView(nextScreen: $nextScreen)
            }
        }
    }
}

struct BLEConnectView: View {
    
    @Binding var nextScreen:Bool
    
    @State private var animationAmount = 1.0
    @State private var BLEon = false
    
    @EnvironmentObject var bleViewModel: BLEViewModel
    
    var body: some View {
        ZStack{
            
            VStack{
                
                Text("\(String(describing: self.bleViewModel.BLEStatus))")      .font(.system(size:35))
                    .fontWeight(.ultraLight)
                    .foregroundColor(Color("Inverse"))
                    .multilineTextAlignment(.center)
                    .shadow(radius: 30)
                    .padding(.top, 150)
                    .padding(.horizontal, 20)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.bleViewModel.startScan()
                        }
                    }
                
                Spacer()
                Spacer()
                
                Image("Bluetooth-symbol").resizable().renderingMode(.template).foregroundColor(Color("AccentColor")).scaledToFit()
                    .frame(height:200)
                    .overlay(
                        Circle()
                            .stroke(Color("AccentColor"))
                            .scaleEffect(animationAmount)
                            .opacity(2-animationAmount)
                            .frame(width:200, height:200)
                    )
                    .animateForever{
                        animationAmount = 2
                    }
                
                Spacer()
                Spacer()
                Spacer()
            }.onTapGesture {
                self.nextScreen.toggle()
        }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().background(Color("Normal"))
    }
}

struct BLEConnectView_Previews: PreviewProvider {
    static var previews: some View {
        BLEConnectView(nextScreen: Binding.constant(false))
    }
}
