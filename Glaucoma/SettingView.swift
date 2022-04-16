//
//  SettingView.swift
//  Glaucoma
//
//  Created by SpencerSullivan on 2/5/22.
//

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
                StaticMemory.deletePatientForever()
            }
            Button("Print Observations")
            {
                StaticMemory.printObservations()
            }
            Button("Delete All Observatios")
            {
                StaticMemory.deleteAllLocalObservations();
            }
        }
    }
}

struct SettingView: View{
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
                            Text("Bleutooth")
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
                                //do something
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
        SettingView()
    }
}
