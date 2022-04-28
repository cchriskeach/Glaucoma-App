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
import SwiftUICharts
import FHIR

struct DebugView: View{
    
    @Binding var nextScreen: Bool
    
    @State var today = Today()
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var allObservations: [Observation] = StaticMemory.getObservations()
    @State var rangeObservations: [Observation] = []
    @State var data: [(String, Double)] = []
    func getRange(){
        data.removeAll()
        for observation in allObservations{
            let date = observation.getDate()
//            rangeObservations.append(observation)
//            data.append((String(describing: (observation.getDate())), observation.getValue()))
            print("Start: ", startDate)
            print("Observed: ", observation.getDate())
            if date > startDate && date < endDate{
                rangeObservations.append(observation)
                print(observation.getValue());
                data.append((String(describing: (observation.getDate())), observation.getValue()))
            }
        }
    }
    
    func delete(at offsets: IndexSet){
        //rangeObservations
    }
    
    @State var confirmationOk: Bool = false
    
    var body: some View{
        ZStack{
            Color("Normal").ignoresSafeArea()
            
            NavigationView{
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text(today.getCurrentTime()).foregroundColor(Color("Inverse").opacity(0.6)).bold().font(Font.footnote)
                            Text("Debug Mode").foregroundColor(Color("Inverse")).font(Font.largeTitle).bold()
                        }
                        Spacer()
                        Button(action: today.loadProfile, label: {
                            Image(systemName: "person.crop.circle").resizable().frame(width: 48, height: 48, alignment: .trailing)
                        })
                    }.padding()
                
                    List{
                        Section(header:HStack{
                            Image(systemName: "calendar").foregroundColor(.accentColor)
                            Text("Multi-Day Data")
                            Spacer()
                        }){
                            NavigationLink(destination:
                                            TimeView(startDate: $startDate, endDate: $endDate)){
                                Text("Enter Time Range")
                            }.simultaneousGesture(TapGesture().onEnded{
                                getRange()})
                            NavigationLink(destination: DebugGraphView(data: $data)){
                                Text("View Graphs")
                            }
                            NavigationLink(destination: DebugListView(rangeObservations: $rangeObservations)){
                                Text("View Raw Data")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "sun.min").foregroundColor(.accentColor)
                            Text("Single Day Data")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Enter Date")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "record.circle").foregroundColor(.accentColor)
                            Text("BLE Real Time Read")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Live View")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "xserve").foregroundColor(.accentColor)
                            Text("Server Commands")
                            Spacer()
                        }){
                            Button("Send Random Data") {
                                let server = StaticMemory.getServer()
                                //Example of test code:
                                for i in 1...100 {
                                    print(i)
                                    let observation = Observation();
                                    observation.CreateIOPObservation(mmHg: Decimal(i), patient: StaticMemory.getPatient())

                                    //print("\(observation.valueQuantity?.value)")
                                    observation.create(server, callback: { (error) in
                                        if error != nil {
                                            //print(error as Any)
                                        }
                                    })
                                }
                            }
                            Button("Print Observations")
                            {
                                StaticMemory.printObservations()
                            }
                            Button("Get All Observations")
                            {
                                _ = StaticMemory.getPatientObservations();
                            }
                            Button("Delete Patient") {
                                self.confirmationOk.toggle()
                            }.foregroundColor(Color.red).confirmationDialog(
                                Text("Are you sure you want to delete the patient?"),
                                isPresented: $confirmationOk,
                                titleVisibility: .visible,
                                actions:{
                                    Button("Yes", role: .destructive){_ = StaticMemory.deletePatientForever()}
                                    Button("No", role: .cancel){}
                                }
                            )
                            Button("Delete All Observations")
                            {
                                self.confirmationOk.toggle()
                            }.foregroundColor(Color.red).confirmationDialog(
                                Text("Are you sure you want to delete ALL observations?"),
                                isPresented: $confirmationOk,
                                titleVisibility: .visible,
                                actions:{
                                    Button("Yes", role: .destructive){ _ = StaticMemory.deleteAllLocalObservations();}
                                    Button("No", role: .cancel){}
                                }
                            )
                        }.headerProminence(.increased)
                        
                         Button(action:{
                                self.nextScreen.toggle()
                            }) {
                                Text("Exit Debug Mode")
                            }.foregroundColor(.red)
                        
                    }.shadow(radius: 4).refreshable {
                        allObservations = StaticMemory.getObservations()
                        getRange()
                    }
    
                    }.navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(nextScreen: Binding.constant(false))
    }
}

struct TimeView: View{
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View{
        Form{
            DatePicker(
                "Start",
                selection: $startDate
            )
            DatePicker(
                "End",
                selection: $endDate
            )
        }.shadow(radius: 4)
    }
}

struct DebugGraphView: View{
    
    @State var today = Today()
    @Binding var data: [(String,Double)]
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            Color("Pop").ignoresSafeArea()
            
            CardView{
                ChartLabel("Tests Per Day", type: .custom(size: 28, padding: EdgeInsets(top: 5.0, leading: 5.0, bottom: 0.0, trailing: 5.0), color: Color(UIColor.label)))
                ChartLabel(today.getPastWeek(), type: .legend)
                BarChart()
            }.data(data).chartStyle(ChartStyle(backgroundColor: Color.clear, foregroundColor: ColorGradient(Color("Pop"), .accentColor))).padding(.all, 12)
        }.cornerRadius(30).padding(.horizontal).shadow(radius: 6)
    }
}

struct DebugListView: View{
    
    @Binding var rangeObservations: [Observation]
    
    var body: some View{
        List{
            ForEach(rangeObservations, id: \.self){ item in
                HStack{
                    Text("\(String(describing: item.getDate()))")
                    Text("\(item.getValue())")
                }
            }.onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet){
        rangeObservations.remove(atOffsets: offsets)
        for indexes in offsets{
            StaticMemory.deleteSingleObservation(date: rangeObservations[indexes].getDate(), value: rangeObservations[indexes].getValue())
        }
    }
}
