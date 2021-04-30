//
//  StatisticsSection.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct StatisticsSection: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.romaji, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>

    var kanaLabel: String
    private var nbCorrectAnswers: Float {
        for stat in statKana {
            if self.kanaLabel == stat.kana {
                return stat.nbCorrectAnswers
            }
        }
        return 0
    }
    private var nbTotalAnswers: Float {
        for stat in statKana {
            if self.kanaLabel == stat.kana {
                return stat.nbTotalAnswers
            }
        }
        return 0
    }
    private var percCorrectAnswers: Float {
        if nbCorrectAnswers == 0 && nbTotalAnswers == 0 {
            return 0
        } else {
            return (nbCorrectAnswers / nbTotalAnswers) * 100.0
        }
    }
    private var progressViewColor: Color {
        switch percCorrectAnswers {
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
    var sizeText: CGFloat
    var widthDevice: CGFloat
    var heightDevice: CGFloat

    var body: some View {
        VStack {
            ProgressView(
                value: percCorrectAnswers,
                total: 100.0) {
                    HStack {
                        Text("Corrects answers: ").font(.subheadline)
                        Text("\(Int(percCorrectAnswers)) %")
                    }
                }
                .font(.system(size: sizeText))
                .progressViewStyle(LinearProgressViewStyle(tint: progressViewColor))
            Text("\(Int(nbCorrectAnswers)) Corrects / \(Int(nbTotalAnswers)) Answers")
                .font(.system(size: sizeText))
        }
        .padding(.horizontal, widthDevice/40)
        .padding(.vertical, 5)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(7)
        .shadow(color: Color.black.opacity(0.1), radius: 29, x: 0.0, y: 0.0)
    }
}

struct StatisticsSection_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSection(kanaLabel: "あ", sizeText: 20, widthDevice: 350, heightDevice: 800)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewLayout(.sizeThatFits)
    }
}
