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

import SwiftUI
import SwiftUICharts

struct DataView2: View {
    
    @State var today = Today()
    
    var body: some View {
        ScrollView{
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(today.getCurrentTime()).foregroundColor(Color("Inverse").opacity(0.6)).bold().font(Font.footnote)
                    Text("View Your Data").foregroundColor(Color("Inverse")).font(Font.largeTitle).bold()
                }
                Spacer()
                Button(action: today.loadProfile, label: {
                    Image(systemName: "person.crop.circle").resizable().frame(width: 48, height: 48, alignment: .trailing)
                })
            }.padding()
            
            BarGraphView().frame(height: 300, alignment: .leading)
            LineGraphView().frame(height: 300, alignment: .leading)
            BarGraphView2().frame(height: 300, alignment: .leading)
        }
        }
        
    }
}

struct DataView2_Previews: PreviewProvider {
    static var previews: some View {
        DataView2()
            .preferredColorScheme(.dark)
            
    }
}

struct GraphView: View{
    var body: some View{
        VStack{
            ZStack{
                Color("Pop").edgesIgnoringSafeArea(.all)
                
                //Graph
                LinearGradient(gradient: Gradient(colors: [.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            }
        }.cornerRadius(30).padding(.horizontal).shadow(radius: 6)
    }
}

struct BarGraphView: View{
    
    @State var today = Today()
    
    //range: 10-25
    @State var demoData: [(String,Double)] = [("M",10), ("T",14), ("W",17), ("T",19), ("F",23), ("S",11), ("S",20)]
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            Color("Pop").ignoresSafeArea()
            
            Button(action: today.loadProfile, label: {
                Image(systemName: "clock.arrow.2.circlepath").resizable().frame(width: 30, height: 25, alignment: .topTrailing).padding()
            })
            
            CardView{
                ChartLabel("Tests Per Day", type: .custom(size: 28, padding: EdgeInsets(top: 5.0, leading: 5.0, bottom: 0.0, trailing: 5.0), color: Color(UIColor.label)))
                ChartLabel(today.getPastWeek(), type: .legend)
                BarChart()
            }.data(demoData).chartStyle(ChartStyle(backgroundColor: Color.clear, foregroundColor: ColorGradient(Color("Pop"), .accentColor))).padding(.all, 12)
        }.cornerRadius(30).padding(.horizontal).shadow(radius: 6)
    }
}

struct LineGraphView: View{
    
    @State var today = Today()
    
    //range: 10-25
    @State var demoData: [(String,Double)] = [("9",12), ("11",15), ("13",16), ("15",23), ("17",20), ("19",17), ("21",10)]
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            Color("Pop").ignoresSafeArea()
            
                Button(action: today.loadProfile, label: {
                    Image(systemName: "clock.arrow.2.circlepath").resizable().frame(width: 30, height: 25, alignment: .topTrailing).padding()
                })
            
            CardView{
                ChartLabel("IOP Level", type: .custom(size: 28, padding: EdgeInsets(top: 5.0, leading: 5.0, bottom: 0.0, trailing: 5.0), color: Color(UIColor.label)))
                ChartLabel(today.getCurrentTime(), type: .legend)
                HStack{
                    //y-axis
                    VStack{
                        if let maxItem = demoData.max(by: {$0.1 < $1.1}){
                            let maxi = maxItem.1
                            
                            Text("\(Int(maxi))")
                            Spacer()
                            Text("\(Int(maxi/2))")
                            Spacer()
                            Text("0")
                        }
                    }.foregroundColor(Color("Inverse"))
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color("Inverse")).opacity(0.4)
                            }
                            .frame(width: 1)
                    LineChart()
                }
                HStack{
                    ForEach(0..<demoData.count, id: \.self) { index in
                        Text("\(demoData[index].0)").frame(maxWidth: .infinity)
                    }
                }.padding(.leading, 25)
                Spacer()
            }.data(demoData).chartStyle(ChartStyle(backgroundColor: Color.clear, foregroundColor: ColorGradient(.accentColor, .accentColor))).padding(.all, 12)
        }.cornerRadius(30).padding().shadow(radius: 6)
    }
}

struct BarGraphView2: View{
    
    @State var today = Today()
    
    //range: 10-25
    @State var demoData: [Double] = (0..<29).map { _ in .random(in: 10.0...25.0)}
    
    var body: some View{
        ZStack(alignment: .topTrailing){
            Color("Pop").ignoresSafeArea()
            
            Button(action: today.loadProfile, label: {
                Image(systemName: "clock.arrow.2.circlepath").resizable().frame(width: 30, height: 25, alignment: .trailing).padding()
            })
            
            CardView{
                ChartLabel("Average IOP", type: .custom(size: 28, padding: EdgeInsets(top: 5.0, leading: 5.0, bottom: 0.0, trailing: 5.0), color: Color(UIColor.label)))
                ChartLabel(today.getNextMonth(), type: .legend)
                BarChart()
                
                HStack{
                    Text("4/7").frame(maxWidth: .infinity)
                    Text("4/14").frame(maxWidth: .infinity)
                    Text("4/21").frame(maxWidth: .infinity)
                    Text("4/28").frame(maxWidth: .infinity)
                }
                
                Button(action: {
                    self.demoData = (0..<29).map { _ in .random(in: 10.0...25.0)} as [Double]
                }){
                    Text("Shuffle Demo Data").padding(.top,5)
                }
            }.data(demoData).chartStyle(ChartStyle(backgroundColor: Color.clear, foregroundColor: ColorGradient(Color("Pop"), .accentColor))).padding(.all, 12)
        }.cornerRadius(30).padding(.horizontal).shadow(radius: 6)
    }
}
