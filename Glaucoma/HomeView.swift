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
///


import SwiftUI

struct HomeView: View {
    @State private var mainButton = true
    @State private var spinnyspinny = false
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 10){
                Button(action: {
                    //todo
                }) {
                    VStack{
                        Text("Welcome")
                            .fontWeight(.light)
                            .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                        Text("Home Screen")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .frame(minWidth: 0, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                
                HStack(spacing: 10){
                    Button(action: {
                        //todo
                    }) {
                        VStack(spacing: 12){
                            Spacer()
                            Image(systemName: "dot.radiowaves.left.and.right")
                                .scaleEffect(1.75)
                                //.padding(.top, 35)
                                .frame(alignment: .center)
                            Text("Reconnect")
                                .font(.caption)
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            //.padding(.top, 65)
                            Spacer()
                        }
                        .frame(maxWidth: 80, maxHeight: 80, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                        .cornerRadius(15)
                    }.buttonStyle(PlainButtonStyle())
                    .shadow(radius: 30)
                    
                    if mainButton{
                        Spacer()
                    } else {
                        Button(action: {
                            withAnimation{
                                self.mainButton.toggle()
                                self.spinnyspinny.toggle()
                            }
                        }) {
                            Text("STOP TEST")
                                .font(.title2)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 10.0)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .frame(maxWidth: .infinity, maxHeight: 80, alignment: .center)
                                //.border(Color(red: 59/255, green: 222/255, blue: 210/255))
                                .foregroundColor(.white)
                                .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 59/255, green: 222/255, blue: 210/255), lineWidth: 2)
                                )
                        }.buttonStyle(PlainButtonStyle())
                        .shadow(radius: 30)
                    }
                    
                    Button(action: {
                        //todo
                    }) {
                        VStack(spacing: 12){
                            Spacer()
                            Image(systemName: "gear")
                                .scaleEffect(1.75)
                                //.padding(.top, 35)
                                .frame(alignment: .center)
                            Text("Settings")
                                .font(.caption)
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Spacer()
                        }
                        .frame(maxWidth: 80, maxHeight: 80, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                        .cornerRadius(15)
                    }.buttonStyle(PlainButtonStyle())
                    .shadow(radius: 30)
                }
                
                Spacer()
                
                //MAIN BUTTON
                Button(action: {
                    withAnimation{
                        self.mainButton.toggle()
                        self.spinnyspinny.toggle()
                    }
                }) {
                    if mainButton{
                        Text("START TEST")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 10.0)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            .frame(maxWidth: 200, maxHeight: 200, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                            .border(Color(red: 59/255, green: 222/255, blue: 210/255))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color(red: 59/255, green: 222/255, blue: 210/255), lineWidth: 4)
                            )
                    } else {
                        
                    }
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 40)
                
                if !mainButton{
                VStack(spacing: 20.0){
                    
                    Text("INSTRUCTIONS**:")
                        .font(.largeTitle)
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
                    
                    
                    
                }.foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                .font(.body)
                .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            
        }
        .background(Color(red: 45/255, green: 49/255, blue: 53/255).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

