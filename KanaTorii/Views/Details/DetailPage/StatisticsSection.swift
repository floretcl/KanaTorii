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
    
    var widthDevice: CGFloat
    var heightDevice: CGFloat

    var sizeText: CGFloat
    var sizeTextCustomCircularProgressView: CGFloat
    var sizeCustomCircularProgressView: CGFloat
    
    var body: some View {
        HStack {
            CustomCircularProgressView(
                progress: percCorrectAnswers,
                progressColor: progressViewColor,
                size: sizeCustomCircularProgressView,
                sizeText: sizeTextCustomCircularProgressView)
            VStack {
                Text("\(Int(nbCorrectAnswers)) Corrects")
                Text("\(Int(nbTotalAnswers)) Answers")
            }.font(.system(size: sizeText))
        }
    }
}

struct StatisticsSection_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSection(kanaLabel: "あ", widthDevice: 380, heightDevice: 830, sizeText: 18, sizeTextCustomCircularProgressView: 12, sizeCustomCircularProgressView: 50)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewLayout(.sizeThatFits)
    }
}
