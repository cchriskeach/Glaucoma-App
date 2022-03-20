//
//  SettingView.swift
//  Glaucoma
//
//  Created by SpencerSullivan on 2/5/22.
//

import SwiftUI
import Models

struct SettingView: View {
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
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
