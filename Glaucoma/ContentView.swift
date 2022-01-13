//
//  ContentView.swift
//  Glaucoma
//
//  Created by Christopher Keach on 12/6/20.
//

import SwiftUI

struct MasterView: View {
    @State var nextScreen = false
    
    var body: some View {
        VStack{
            if nextScreen{
                AppView()
                    .animation(.spring())
                    .transition(.slide)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(nextScreen: Binding.constant(false))
        }
    }
}

struct AppView1: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Home")
                }
            
            DataView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Data")
                }
        }
    }
}
