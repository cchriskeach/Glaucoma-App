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
import Models

struct SpencerView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Button("Send Random Data") {
                let server = StaticMemory.getServer()
                //Example of test code:
                for i in 1...200 {
                    print(i)
                    let observation = Observation();
                    observation.CreateIOPObservation(mmHg: i, patient: StaticMemory.getPatient())

                    //print("\(observation.valueQuantity?.value)")
                    observation.create(server, callback: { (error) in
                        if error != nil {
                            //print(error as Any)
                        }
                    })
                }
            }
            Button("Delete") {
                _ = StaticMemory.deletePatientForever()
            }
            Button("Print Observations")
            {
                StaticMemory.printObservations()
            }
            Button("Delete All Observatios")
            {
                _ = StaticMemory.deleteAllLocalObservations();
            }
            Button("Get All Observatios")
            {
                _ = StaticMemory.getPatientObservations();
            }
        }
    }
}

struct MasterSettingsView: View {
    @State var nextScreen = false
    
    var body: some View {
        VStack{
            if nextScreen{
                DebugView()
            } else {
                SettingView(nextScreen: $nextScreen)
            }
        }
    }
}

struct SettingView: View{
    
    @Binding var nextScreen: Bool
    
    var body: some View{
        ZStack{
            Color("Normal").ignoresSafeArea()
            
            NavigationView{
                VStack{
                    Button(action:{
                        //do something
                    }) {
                        Image(systemName: "person.crop.circle").resizable().frame(width: 90, height: 90, alignment: .center).padding(.top, 20)
                    }
                    
                    Text("Name").font(.title).bold().padding(.all,10)
                
                    List{
                        Section(header:HStack{
                            Image(systemName: "info.circle").foregroundColor(.accentColor)
                            Text("Medical Details")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Health Profile")
                            }
                            NavigationLink(destination: SpencerView()){
                                Text("Health Records")
                            }
                            NavigationLink(destination: SpencerView()){
                                Text("Doctor Contact")
                            }
                            NavigationLink(destination: SpencerView()){
                                Text("Emergency Contact")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "iphone.radiowaves.left.and.right.circle").foregroundColor(.accentColor)
                            Text("Bluetooth")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Reconnect to Device")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "figure.wave.circle").foregroundColor(.accentColor)
                            Text("Accessibility")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Input IOP Range")
                            }
                            NavigationLink(destination: SpencerView()){
                                Text("Change Accent Color")
                            }
                            NavigationLink(destination: SpencerView()){
                                Text("Notificaitions")
                            }
                        }.headerProminence(.increased)
                
                            Button(action:{
                                //do something
                            }) {
                                Text("Export Health Data")
                            }.foregroundColor(.accentColor)
                            
                            Button(action:{
                                //do something
                            }) {
                                Text("Log Out")
                            }.foregroundColor(.accentColor)
                        
                         Button(action:{
                             self.nextScreen.toggle()
                            }) {
                                Text("Enter Debug Mode")
                            }.foregroundColor(.red)
                        
                    }.shadow(radius: 4)
    
                    }.navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(nextScreen: Binding.constant(false))
    }
}
