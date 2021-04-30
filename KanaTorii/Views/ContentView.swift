//
//  ContentView.swift
//  Shared
//
//  Created by Clément FLORET on 24/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State var tabViewSelectedItem: Int = 1

    // For Segmented Control Colors
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("Green"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("Green"))], for: .normal)
    }

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
                    }.tag(1)
                ListsView(colorsInTables: _colorsInTables)
                    .tabItem {
                        Text("Lists")
                        Image(systemName: "list.triangle")
                    }.tag(2)
                LessonsView()
                    .tabItem {
                        Text("Lessons")
                        Image(systemName: "book")
                    }.tag(3)
                QuizsView(quickQuizNbQuestions: _quickQuizNbQuestions)
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
            ContentView()
                .environmentObject(StoreManager())
                .environmentObject(ModelData())
                .preferredColorScheme(.dark)
            ContentView()
                .environmentObject(StoreManager())
                .environmentObject(ModelData())
                .previewDevice("iPod touch (7th generation)")
            ContentView()
                .environmentObject(StoreManager())
                .environmentObject(ModelData())
                .preferredColorScheme(.light)
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
    }
}
