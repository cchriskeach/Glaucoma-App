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
        ZStack(alignment: .top) {
            Button("Send test data to server") {
                //Example of test code:
                
                //1 Establish Server Connection can be established mulitple times
                let server: GlaucomaFHIRServer = GlaucomaFHIRServer(baseURL: URL(string: "http://localhost:32783/fhir/r4/")!)
                
                //2 Get the patient, this should be created when the application is 
                let patient = Patient()
                
                //note: this createPatient function needs to be renamed
                patient.createPatient(firstName: "John", lastName: "Doe", dateOfBirth: Date(), gender: "Male")
                
                
                //note: fix error handling at some point
                patient.create(server, callback: { (error) in
                    if error != nil {
                        print(error as Any)
                    }
                })
                //3 Generate observation and call the create function passing in the server, server must be lauched for the application to function properly, else it will crash
                for i in 1...50 {
                    print(i)
                    let observation = Observation();
                    observation.CreateIOPObservation(mmHg: i, patient: patient)
                    
                    print("\(observation.valueQuantity?.value)")
                    observation.create(server, callback: { (error) in
                        if error != nil {
                            print(error as Any)
                        }
                    })
                }
                
            }
            //end giant button :O
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
