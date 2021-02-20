//
//  ContentView.swift
//  Shared
//
//  Created by Clément FLORET on 24/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State var tabViewSelectedItem: Int = 1
    
    var body: some View {
        TabView(selection: $tabViewSelectedItem,
            content: {
                HomeView()
                    .tabItem {
                        Text("Home")
                        Image(systemName: "house")
                    }.tag(1)
                ListsView()
                    .tabItem {
                        Text("Lists")
                        Image(systemName: "list.triangle")
                    }.tag(2)
                LessonsView()
                    .tabItem {
                        Text("Lessons")
                        Image(systemName: "book")
                    }.tag(3)
                QuizsView()
                    .tabItem {
                        Text("Quiz")
                        Image(systemName: "questionmark.circle")
                    }.tag(4)
                StatisticsView()
                    .tabItem {
                        Text("Statistics")
                        Image(systemName: "chart.bar.xaxis")
                    }.tag(5)
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(tabViewSelectedItem: 1)
                .environmentObject(ModelData())
                .preferredColorScheme(.dark)
            ContentView(tabViewSelectedItem: 1)
                .environmentObject(ModelData())
                .previewDevice("iPod touch (7th generation)")
            ContentView(tabViewSelectedItem: 1)
                .environmentObject(ModelData())
                .preferredColorScheme(.light)
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
    }
}