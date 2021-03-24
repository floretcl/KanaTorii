//
//  StatRow.swift
//  KanaTorii
//
//  Created by Clément FLORET on 23/03/2021.
//

import SwiftUI

struct StatRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    
    var kana: StatKana
    
    var body: some View {
        HStack {
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    Text("\(kana.kana!)")
                        .font(.title)
                    Text("\(kana.romaji!)")
                }.frame(width: 100, alignment: .center)
            } else {
                VStack {
                    Text("\(kana.kana!)")
                        .font(.title)
                    Text("\(kana.romaji!)")
                        .font(.title2)
                }.frame(width: 70, alignment: .center)
            }
            VStack {
                ProgressView(value: getPercentage(nbCorrectAnswers: kana.nbCorrectAnswers, nbTotalAnswers: kana.nbTotalAnswers), total: 100.0) {
                    HStack {
                        Text("Corrects answers: ")
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

struct StatRow_Previews: PreviewProvider {
    static var previews: some View {
        StatRow(kana: StatKana())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
