//
//  ContentView.swift
//  Glaucoma
//
//  Created by Christopher Keach on 12/6/20.
//

import UIKit
import SwiftUI
import AuthenticationServices


struct MasterView: View {
    @State var nextScreen = false
    
    init(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color("Normal").opacity(0.9))
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        //UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
        
    }
    
    var body: some View {
        VStack{
            if nextScreen{
                BLEMasterView().environmentObject(HomeViewModel())
                    .environmentObject(BLEViewModel())
                //AppView().environmentObject(HomeViewModel())
                    //.environmentObject(BLEViewModel())
            } else {
                withAnimation{
                    ContentView(nextScreen: $nextScreen)
                }.animation(.none)
            }
        }
    }
}

struct ContentView: View {
    
    @Binding var nextScreen:Bool
    @Environment(\.window) var window: UIWindow?
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
    
    var body: some View {
        ZStack{
                
            VStack{
            
                VStack(spacing: 1.0){
                    Text("Glauc -")
                        .font(.system(size:30))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 30)
                    .padding(.top, 100)
                    
                    Text("AT HOME")
                        .font(.system(size:50))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 30)
                    
                    Text("- a")
                        .font(.system(size:30))
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 30)
                    SignInWithApple()
                      .frame(width: 280, height: 60)
                      .onTapGesture(perform: showAppleLogin)
                }
                
                Spacer()
                
                HStack{
                    Spacer()
                Button(action: {
                    self.nextScreen = true
                }) {
                    Text("Connect my Tonometer")
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10.0)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                        .cornerRadius(20)
                }.padding(.bottom, 25.0).buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                    Spacer()
                }
            }
        }
        .background(Image("eye")
                        .resizable()
                        .padding(.leading, 20.0)
                        .scaledToFill()
                        .opacity(0.6))
        .background(Color(red: 61/255, green: 61/255, blue: 65/255))
        //.background(Color(red: 30/255, green: 34/255, blue: 38/255))
        .edgesIgnoringSafeArea(.all)
        
        }
    
    
    /// Everything below this line subject to the folloiwng copywrite agreement
    
    /// Copyright (c) 2019 Razeware LLC
    ///
    /// Permission is hereby granted, free of charge, to any person obtaining a copy
    /// of this software and associated documentation files (the "Software"), to deal
    /// in the Software without restriction, including without limitation the rights
    /// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    /// copies of the Software, and to permit persons to whom the Software is
    /// furnished to do so, subject to the following conditions:
    ///
    /// The above copyright notice and this permission notice shall be included in
    /// all copies or substantial portions of the Software.
    ///
    /// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
    /// distribute, sublicense, create a derivative work, and/or sell copies of the
    /// Software in any work that is designed, intended, or marketed for pedagogical or
    /// instructional purposes related to programming, coding, application development,
    /// or information technology.  Permission for such use, copying, modification,
    /// merger, publication, distribution, sublicensing, creation of derivative works,
    /// or sale is expressly withheld.
    ///
    /// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    /// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    /// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    /// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    /// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    /// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    /// THE SOFTWARE.
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView(nextScreen: Binding.constant(false))
            }
        }
    }

    private func showAppleLogin() {
      let request = ASAuthorizationAppleIDProvider().createRequest()
      request.requestedScopes = [.fullName, .email]

      performSignIn(using: [request])
    }

    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    private func performExistingAccountSetupFlows() {
      #if !targetEnvironment(simulator)
      // Note that this won't do anything in the simulator.  You need to
      // be on a real device or you'll just get a failure from the call.
      let requests = [
        ASAuthorizationAppleIDProvider().createRequest(),
        ASAuthorizationPasswordProvider().createRequest()
      ]

      performSignIn(using: requests)
      #endif
    }

    private func performSignIn(using requests: [ASAuthorizationRequest]) {
      appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
        if success {
          // update UI
        } else {
          // show the user an error
        }
      }

      let controller = ASAuthorizationController(authorizationRequests: requests)
      controller.delegate = appleSignInDelegates
      controller.presentationContextProvider = appleSignInDelegates

      controller.performRequests()
    }
}
