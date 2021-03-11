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
                    HStack {
                        Text("\(kana.kana!)")
                            .font(.title)
                        Text("\(kana.romaji!)")
                        VStack {
                            ProgressView(value: getPercentage(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers), total: 100.0) {
                                HStack {
                                    Text("Correct(s) answer(s): ")
                                    Text("\(Int(getPercentage(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers))) %")
                                }
                            }
                                .progressViewStyle(
                                    LinearProgressViewStyle(
                                        tint: getProgressViewColor(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers)
                                    )
                                )
                            Text("\(Int(kana.nbCorrectAnswers)) Corrects / \(Int(kana.nbTotalAnswers)) Answers")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }.padding(.horizontal, 150)
        } else {
            List {
                ForEach(statKana) { kana in
                    HStack {
                        Text("\(kana.kana!)")
                            .font(.title)
                        Text("\(kana.romaji!)")
                            .font(.title2)
                        VStack {
                            ProgressView(value: getPercentage(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers), total: 100.0) {
                                HStack {
                                    Text("Correct(s) answer(s): ")
                                    Text("\(Int(getPercentage(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers))) %")
                                }
                            }
                                .progressViewStyle(
                                    LinearProgressViewStyle(
                                        tint: getProgressViewColor(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers)
                                    )
                                )
                            Text("\(Int(kana.nbCorrectAnswers)) Corrects / \(Int(kana.nbTotalAnswers)) Answers")
                        }
                    }
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
    private func getPercentage(nbCorrectAnswers: Float, nbTotalAnswers: Float) -> Float {
        return (nbCorrectAnswers / nbTotalAnswers) * 100.0
    }
    private func getProgressViewColor(nbCorrectAnswers: Float, nbTotalAnswers: Float) -> Color {
        switch getPercentage(nbCorrectAnswers: nbCorrectAnswers, nbTotalAnswers: nbTotalAnswers) {
        case 0..<20:
            return .black
        case 20..<40:
            return .red
        case 40..<60:
            return .orange
        case 60..<80:
            return .yellow
        case 80...100:
            return .green
        default:
            return .gray
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
