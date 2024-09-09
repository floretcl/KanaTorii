//
//  ContentView.swift
//  Shared
//
//  Created by Clément FLORET on 24/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State var tabViewSelectedItem: Int = 0

    // User Defaults
    @AppStorage("colors-in-tables") var colorsInTables: Bool = true
    @AppStorage("quick-quiz-nb-questions") var quickQuizNbQuestions: Double = 10.0

    var body: some View {
        TabView(selection: $tabViewSelectedItem,
            content: {
                HomeView(colorsInTables: _colorsInTables, quickQuizNbQuestions: _quickQuizNbQuestions)
                    .tabItem {
                        Text("Home")
                        Image(systemName: "house")
                    }.tag(0)
                ListsView(colorsInTables: _colorsInTables)
                    .tabItem {
                        Text("Lists")
                            .foregroundColor(Color.black)
                        Image(systemName: "list.triangle")
                    }.tag(1)
                LessonsView()
                    .tabItem {
                        Text("Lessons")
                        Image(systemName: "book")
                    }.tag(2)
                QuizsView(quickQuizNbQuestions: _quickQuizNbQuestions)
                    .tabItem {
                        Text("Quiz")
                        Image(systemName: "questionmark.circle")
                    }.tag(3)
                StatisticsView()
                    .tabItem {
                        Text("Statistics")
                        Image(systemName: "chart.bar.xaxis")
                    }.tag(4)
            }
        ).onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
