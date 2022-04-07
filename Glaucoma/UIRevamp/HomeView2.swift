//
//  HomeView2.swift
//  Glaucoma
//
//  Created by Christopher Keach on 3/28/22.
//

import SwiftUI

struct HomeView2: View {
    
      @State var today = Today()
    
//    init() {
//        //UINavigationBar.appearance().backgroundColor = .label
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(Color("Inverse"))
//
//        let attrs: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor(Color("Normal"))
//        ]
//
//        appearance.largeTitleTextAttributes = attrs
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
//    }
    
    var body: some View {
    
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(today.getCurrentTime()).foregroundColor(Color("Inverse").opacity(0.6)).bold().font(Font.footnote)
                    Text("Welcome Home").foregroundColor(Color("Inverse")).font(Font.largeTitle).bold()
                }
                Spacer()
                Button(action: today.loadProfile, label: {
                    Image(systemName: "person.crop.circle").resizable().frame(width: 48, height: 48, alignment: .trailing)
                })
            }.padding()
            
            TestView()
        }
        
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
            .preferredColorScheme(.dark)
    }
}

struct TestView: View {
    
    @EnvironmentObject var hVM: HomeViewModel
    
    var body: some View {
            ZStack{
                Color("Normal").edgesIgnoringSafeArea(.all)
                
                VStack{
                    if !hVM.testON{
                        Button(action:{
                            hVM.toggleTest()
                        }){
                        Text("START\n TEST")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 10.0)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            .frame(maxWidth: 250, maxHeight: 250, alignment: .center)
                            .foregroundColor(Color("Inverse"))
                            .background(Color("Pop"))
                            .border(Color("Inverse"))
                            .clipShape(Circle())
                            .shadow(radius: 6)
                            .overlay(
                                Circle()
                                    .stroke(Color.accentColor, lineWidth: 6)
                            )

                            }
                    }
                    if hVM.testON{
                        VStack{
                            VStack(spacing: 20.0){
                                
                                Text("INSTRUCTIONS**:")
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                
                                Text("1. Place Tonometer to RIGHT eye, with lens facing towards the eye.")
                                Text("2. With your eye remaining open the entire, press and hold the button for about 10 seconds, until you hear a beeping sound.")
                                Text("3. Remove tonometer from RIGHT eye, and repeat these steps with the LEFT eye.")
                                Text("4. After hearing the beep from the LEFT eye procedure, wait one minute before turning device off.")
                                
                                Spacer()
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .opacity(1)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("**DISCLAIMER: These instructions are mockups and do not accurately reflect the final product or procedure in any way, shape, or form.")
                                    .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                                    .font(.caption2)
                                
                                
                                
                            }.fixedSize(horizontal: false, vertical: true).font(.body)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Button(action:{
                                hVM.testON.toggle()
                            }){
                                Text("STOP TEST")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical, 10.0)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                                    .foregroundColor(Color("Inverse"))
                                    .background(Color("Pop"))
                                    .border(Color("Inverse"))
                                    .clipShape(Capsule())
                                    .shadow(radius: 6)
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.accentColor, lineWidth: 6)
                                    )
                                
                            }.padding()
                        }
                    }
                }.animation(.default, value: hVM.testON)
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct TestView2: View {
    
    @EnvironmentObject var hVM: HomeViewModel
    
    var body: some View {
        
            ZStack{
                Color("Normal").edgesIgnoringSafeArea(.all)
            }
        
    }
}

