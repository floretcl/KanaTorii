//
//  StatisticsView.swift
//  Kana Torii (iOS)
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI
import CoreData

struct StatisticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    let itemIpad = GridItem(.flexible(minimum: 280, maximum: 400))

    var body: some View {
        GeometryReader { geometry in
            let widthDevice = geometry.size.width
            if UIDevice.current.localizedModel == "iPad" {
                if statKanaIsEmpty() == true {
                    NavigationView {
                        EmptyStatisticView()
                            .navigationBarTitle("Statistics")
                    }
                    .padding(.horizontal, 100)
                    .navigationViewStyle(StackNavigationViewStyle())
                } else {
                    VStack {
                        NavigationView {
                            List {
                                LazyVGrid(
                                    columns: [itemIpad,itemIpad],
                                    alignment: .center,
                                    spacing: 20,
                                    content: {
                                    ForEach(statKana) { kana in
                                        StatRow(
                                            kana: kana,
                                            spacing: 0,
                                            spacingStats: 5,
                                            sizeCustomCircularProgessView: 60,
                                            sizeText: 16)
                                    }
                                })
                            }.navigationBarTitle("Statistics")
                        }
                        .padding(.horizontal, 50)
                        .navigationViewStyle(StackNavigationViewStyle())
                    }
                    .background(Color(UIColor.secondarySystemBackground))
                    .edgesIgnoringSafeArea(.all)
                }
            } else {
                NavigationView {
                    if statKanaIsEmpty() == true {
                        EmptyStatisticView()
                            .navigationBarTitle("Statistics")
                    } else {
                        List {
                            ForEach(statKana) { kana in
                                StatRow(
                                    kana: kana,
                                    spacing: widthDevice/14,
                                    spacingStats: 10,
                                    sizeCustomCircularProgessView: 50,
                                    sizeText: 12)
                            }
                        }.navigationBarTitle("Statistics")
                    }
                }
            }
        }
    }

    private func statKanaIsEmpty() -> Bool {
        var empty: Bool = true
        for stat in statKana {
            if stat.nbTotalAnswers != 0 {
                empty = false
            }
        }
        return empty
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
