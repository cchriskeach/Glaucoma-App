//
//  AppView.swift
//  Glaucoma
//
//  Created by Christopher Keach on 12/11/20.
//

import SwiftUI

struct AppView: View {
    
    init(){
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(Color(red: 23/255, green: 26/255, blue: 30/255))

    }
    
    var body: some View {
        
        
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            DataView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Data")
                }
        }
        .accentColor(Color(red: 59/255, green: 222/255, blue: 210/255))
        
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
