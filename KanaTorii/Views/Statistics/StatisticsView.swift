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
            List {
                ForEach(statKana) { kana in
                    StatRow(kana: kana)
                }
                .onDelete(perform: deleteItems)
            }.padding(.horizontal, 150)
        } else {
            List {
                ForEach(statKana) { kana in
                    StatRow(kana: kana)
                }
                .onDelete(perform: deleteItems)
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
                //let nsError = error as NSError
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
