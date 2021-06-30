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

    var body: some View {
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
                        Form {
                            List {
                                ForEach(statKana) { kana in
                                    StatRow(kana: kana)
                                }
                                .onDelete(perform: deleteItems)
                            }
                        }.navigationBarTitle("Statistics")
                    }
                    .padding(.horizontal, 100)
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
                            StatRow(kana: kana)
                        }
                        .onDelete(perform: deleteItems)
                    }.navigationBarTitle("Statistics")
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { statKana[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print(error)
                // let nsError = error as NSError
                // fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
