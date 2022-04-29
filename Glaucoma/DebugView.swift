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
    @State var dataValue: [Double] = []
    func getRange(){
        data.removeAll()
        for observation in allObservations{
            let date = observation.getDate()
            if date > startDate && date < endDate{
                rangeObservations.append(observation)
                print(observation.getValue());
                data.append((String(describing: (observation.getDate())), observation.getValue()))
                dataValue.append(observation.getValue())
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
                            }
                            NavigationLink(destination: DebugGraphView(data: $dataValue)){
                                Text("View Graphs")
                            }
                            NavigationLink(destination: DebugListView(rangeObservations: $rangeObservations)){
                                Text("View Raw Data")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "d.circle").foregroundColor(.accentColor)
                            Text("Data Analysis")
                            Spacer()
                        }){
                            NavigationLink(destination: MaxView(data: $data)){
                                Text("Max of current time range")
                            }
                            NavigationLink(destination: MinView(data: $data)){
                                Text("Min of current time range")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "record.circle").foregroundColor(.accentColor)
                            Text("BLE Real Time Read")
                            Spacer()
                        }){
                            NavigationLink(destination: LiveView()){
                                Text("Live View")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "xserve").foregroundColor(.accentColor)
                            Text("Server Commands")
                            Spacer()
                        }){
                            Button("Send Random Data") {
                                StaticMemory.sendRandomData()
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
                        
                    }.shadow(radius: 4).onAppear{
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
    @Binding var data: [Double]
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            Color("Pop").ignoresSafeArea()
            
            CardView{
                ChartLabel("IOP Observations", type: .custom(size: 28, padding: EdgeInsets(top: 5.0, leading: 5.0, bottom: 0.0, trailing: 5.0), color: Color(UIColor.label)))
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

struct LiveView: View{
    
    @EnvironmentObject var bleViewModel: BLEViewModel
    
    var body: some View{
        VStack{
            Text("Incoming Data:").font(.largeTitle).bold().multilineTextAlignment(.center).foregroundColor(Color("Inverse")).padding()
            if bleViewModel.data != nil{
                Text(String(bleViewModel.data!.data))
            }else{
                Text("Nothing Being Read from Device")
            }
        }
    }
}

struct MaxView: View{
    @Binding var data: [(String, Double)]
    @State var max: (String, Double) = ("No Time Range", 0)
    
    func findMax(){
        if let maxItem = data.max(by: {$0.1 < $1.1 }){
            max = (maxItem.0, maxItem.1)
        }
    }
    
    var body: some View{
        HStack{
            Text(max.0)
            Spacer()
            Text(String(max.1))
        }.padding(.horizontal,50).onAppear(perform: findMax)
    }
}

struct MinView: View{
    @Binding var data: [(String, Double)]
    @State var max: (String, Double) = ("No Time Range", 0)
    
    func findMax(){
        if let maxItem = data.min(by: {$0.1 < $1.1 }){
            max = (maxItem.0, maxItem.1)
        }
    }
    
    var body: some View{
        HStack{
            Text(max.0)
            Spacer()
            Text(String(max.1))
        }.padding(.horizontal,50).onAppear(perform: findMax)
    }
}
