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
        HStack(alignment: .top, spacing: 20) {
            Button("Initialize User") {
                //Example of test code:
                
                //1 Establish Server Connection can be established mulitple times
                StaticMemory.InitializeUser()
            }
            Button("Send Random Data") {
                let server = StaticMemory.getServer()
                //Example of test code:
                for i in 1...50 {
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
            Button("Get Observations") {
                StaticMemory.getPatientObservations()
            }
            Button("Print Observations")
            {
                StaticMemory.printObservations()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

//                //3 Generate observation and call the create function passing in the server, server must be lauched for the application to function properly, else it will crash
//                for i in 1...50 {
//                    print(i)
//                    let observation = Observation();
//                    observation.CreateIOPObservation(mmHg: i, patient: StaticMemory.getPatient())
//
//                    //print("\(observation.valueQuantity?.value)")
//                    observation.create(server, callback: { (error) in
//                        if error != nil {
//                            //print(error as Any)
//                        }
//                    })
//                }
