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
    
    let spacing: CGFloat
    let spacingStats: CGFloat
    let sizeCustomCircularProgessView: CGFloat
    let sizeText: CGFloat
    
    var body: some View {
        HStack(spacing: spacing) {
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
            HStack(spacing: spacingStats) {
                CustomCircularProgressView(
                    progress: getPercentage(),
                    progressColor: getProgressViewColor(),
                    size: sizeCustomCircularProgessView,
                    sizeText: sizeText)
                VStack {
                    Text("\(Int(kana.nbCorrectAnswers)) Corrects")
                    Text("\(Int(kana.nbTotalAnswers)) Answers")
                }
            }
        }
    }

    private func getPercentage() -> Float {
        return (kana.nbCorrectAnswers / kana.nbTotalAnswers) * 100.0
    }

    private func getProgressViewColor() -> Color {
        switch getPercentage() {
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
