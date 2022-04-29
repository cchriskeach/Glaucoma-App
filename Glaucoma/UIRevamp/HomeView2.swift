///BSD 3-Clause License
///
///Copyright (c) 2022, University of Pittsburgh
///All rights reserved.
///
///Redistribution and use in source and binary forms, with or without
///modification, are permitted provided that the following conditions are met:
///
///1. Redistributions of source code must retain the above copyright notice, this
///   list of conditions and the following disclaimer.
///
///2. Redistributions in binary form must reproduce the above copyright notice,
///   this list of conditions and the following disclaimer in the documentation
///   and/or other materials provided with the distribution.
///
///3. Neither the name of the copyright holder nor the names of its
///   contributors may be used to endorse or promote products derived from
///   this software without specific prior written permission.
///
///THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
///AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
///IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
///DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
///FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
///DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
///SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
///CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
///OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
///OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import SwiftUI
import FHIR

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
    @EnvironmentObject var bleViewModel: BLEViewModel
    @State var observation = Observation()
    
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
                                observation.CreateIOPObservation(mmHg: Decimal(bleViewModel.data!.data), patient: StaticMemory.getPatient())
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

