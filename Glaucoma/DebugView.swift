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
    
    @State var today = Today()
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var allObservations: [Observation] = StaticMemory.getObservations()
    @State var rangeObservations: [Observation] = []
    @State var data: [(String, Double)] = []
    func getRange(){
        for observation in allObservations{
            let date = observation.getDate()
            data.append((String(describing: (observation.getDate())), Double(observation.getValue())))
            if date.compare(startDate) == .orderedDescending && date.compare(startDate) == .orderedAscending {
                //rangeObservations.append(observation)
                print(observation.getValue());
                data.append((String(describing: (observation.getDate())), Double(observation.getValue())))
            }
        }
    }
    
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
                            Image(systemName: "info.circle").foregroundColor(.accentColor)
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
                            NavigationLink(destination: DebugListView(data: $data)){
                                Text("View Raw Data")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "iphone.radiowaves.left.and.right.circle").foregroundColor(.accentColor)
                            Text("Single Day Data")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Reconnect to Device")
                            }
                        }.headerProminence(.increased)
                        
                        Section(header:HStack{
                            Image(systemName: "figure.wave.circle").foregroundColor(.accentColor)
                            Text("Incoming BLE Data")
                            Spacer()
                        }){
                            NavigationLink(destination: SpencerView()){
                                Text("Live View")
                            }
                        }.headerProminence(.increased)
                        
                         Button(action:{
                                //do something
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
        DebugView()
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
    
    @Binding var data: [(String,Double)]
    
    var body: some View{
        
        List(data, id: \.0){ (data0, data1) in
            HStack{
                Text("\(data0)")
                Text("\(data1)")
            }
        }
            
    }
}
