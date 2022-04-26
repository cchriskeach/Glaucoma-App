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
/////

import SwiftUI
import Combine

struct DataView: View {
    @ObservedObject var dataSource = DataSource()
    
    var body: some View {
        ZStack{
            VStack(spacing: 10.0){
                Button(action: {
                    //todo
                }) {
                    VStack{
                        Text("Welcome")
                            .fontWeight(.light)
                            .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                        Text("Data Screen")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                
                HStack{
                    VStack{
                        Image(systemName: "circle.fill")
                            .scaleEffect(2)
                            .foregroundColor(Color(red: 59/255, green: 222/255, blue: 210/255))
                            .padding(.leading, 10)
                        Spacer()
                        Text("Normal IOP")
                            .foregroundColor(.white)
                        Text("10-15 mm HG")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: "circle.fill")
                            .scaleEffect(2)
                            .foregroundColor(.yellow)
                        Spacer()
                        Text("High IOP")
                            .foregroundColor(.white)
                        Text("16-21 mm HG")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: "circle.fill")
                            .scaleEffect(2)
                            .foregroundColor(.red)
                        Spacer()
                        Text("Hypertension IOP")
                            .foregroundColor(.white)
                        Text("22+ mm HG")
                            .foregroundColor(.white)
                    }
                }.frame(width: .infinity, height: 75)
                
                //ONE
                Button(action: {
                    //todo
                }) {
                    HStack(spacing: 20.0){
                        Image(systemName: "circle.fill")
                            .scaleEffect(2.5)
                            .foregroundColor(Color(red: 59/255, green: 222/255, blue: 210/255))
                            .padding(.leading, 10)
                        Divider()
                        VStack{
                            Text("IOP:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("10 mm HG")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Date:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("12/01/20")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Time:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("4:01 PM")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                    }.padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                
                //TWO
                Button(action: {
                    //todo
                }) {
                    HStack(spacing: 20.0){

                        Image(systemName: "circle.fill")
                            .scaleEffect(2.5)
                            .foregroundColor(Color(red: 59/255, green: 222/255, blue: 210/255))
                            .padding(.leading, 10)
                        Divider()
                        VStack{
                            Text("IOP:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("12 mm HG")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Date:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("12/02/20")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Time:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("9:50 PM")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                    }.padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                
                Button(action: {
                    //todo
                }) {
                    HStack(spacing: 20.0){
                      
                        Image(systemName: "circle.fill")
                            .scaleEffect(2.5)
                            .foregroundColor(.yellow)
                            .padding(.leading, 10)
                        Divider()
                        VStack{
                            Text("IOP:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("16 mm HG")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Date:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("12/03/20")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Time:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("8:12 AM")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                    }.padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                
                Button(action: {
                    //todo
                }) {
                    HStack(spacing: 20.0){
                       
                        Image(systemName: "circle.fill")
                            .scaleEffect(2.5)
                            .foregroundColor(.red)
                            .padding(.leading, 10)
                        Divider()
                        VStack{
                            Text("IOP:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("23 mm HG")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Date:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("12/03/20")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Time:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("3:39 PM")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                    }.padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                
                Button(action: {
                    //todo
                }) {
                    HStack(spacing: 20.0){
                        
                        Image(systemName: "circle.fill")
                            .scaleEffect(2.5)
                            .foregroundColor(.yellow)
                            .padding(.leading, 10)
                        Divider()
                        VStack{
                            Text("IOP:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("20 mm HG")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Date:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("12/04/20")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        VStack{
                            Text("Time:")
                                .foregroundColor(Color(red: 195/255, green: 195/255, blue: 195/255))
                            Text("1:21 AM")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                    }.padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10.0)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 100, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 23/255, green: 26/255, blue: 30/255))
                    .cornerRadius(20)
                }.buttonStyle(PlainButtonStyle())
                .shadow(radius: 30)
                //list stuff gl
                /*List(dataSource.dataArray.identified(by: \<#Root#>.self)){ data in
                 //Text(d)
                 }*/
                
                Spacer()
            }.padding(.horizontal, 10)
        }.background(Color(red: 45/255, green: 49/255, blue: 53/255).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        
        
        
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}

class DataSource: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var dataArray = [DataOne]()
    
    //initialize some stuff here
}
