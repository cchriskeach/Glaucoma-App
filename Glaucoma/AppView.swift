//
//  AppView.swift
//  Glaucoma
//
//  Created by Christopher Keach on 12/11/20.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView{
            HomeView2()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            DataView2()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Data")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }.accentColor(Color("AccentColor")).padding()
    }
}
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
