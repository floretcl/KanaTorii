//
//  KanaCell.swift
//  Kana Torii
//
//  Created by Clément FLORET on 01/01/2021.
//

import SwiftUI

struct KanaCell: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.kana, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>

    // User Defaults
    @AppStorage var colorsInTables: Bool

    var kanaForList: KanaForList
    var kanaType: Kana.KanaType
    private var label: String {
        if kanaType == .hiragana {
            return self.kanaForList.hiragana
        } else {
            return self.kanaForList.katakana
        }
    }
    private var color: Color {
        if colorsInTables {
            for stat in statKana {
                if self.label == stat.kana {
                    return getProgressViewColor(nbCorrectAnswers: stat.nbCorrectAnswers, nbTotalAnswers: stat.nbTotalAnswers)
                }
            }
        }
        return .primary
    }
    var widthDevice: CGFloat

    var body: some View {
        NavigationLink(
            destination: DetailsView(
                pages: ModelData().kanas.map {
                    DetailPage(kana: $0, kanaType: kanaType)
                }, currentPage: getId()
            ),
            label: {
                if kanaForList.isKana {
                    VStack {
                        Text(self.label)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(color)
                        Text(self.kanaForList.romaji)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, widthDevice/60)
                    .padding(.horizontal, widthDevice/40)
                    .cornerRadius(widthDevice/50)
                    .overlay(RoundedRectangle(cornerRadius: widthDevice/50)
                                .stroke(Color.primary, lineWidth: 0.5))
                } else {
                    VStack {
                        Text(self.label)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(color)
                        Text(self.kanaForList.romaji)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, widthDevice/60)
                    .padding(.horizontal, widthDevice/40)
                }
            }
        )
    }

    func getId() -> Int {
        if kanaForList.isKana {
            return Kana.getIdKana(name: kanaForList.name)
        }
        return 0
    }

    private func getProgressViewColor(nbCorrectAnswers: Float, nbTotalAnswers: Float) -> Color {
        switch (nbCorrectAnswers / nbTotalAnswers) * 100.0 {
        case 0..<20:
            return .primary
        case 20..<40:
            return .red
        case 40..<60:
            return .orange
        case 60..<80:
            return .yellow
        case 80...100:
            return .green
        default:
            return .primary
        }
    }
}

struct KanaCell_Previews: PreviewProvider {
    static var kanasForList = ModelData().kanasForList
    static var previews: some View {
        Group {
            KanaCell(colorsInTables: .init(wrappedValue: true, "colors-in-tables"), kanaForList: kanasForList[10], kanaType: .hiragana, widthDevice: 320)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .previewLayout(.sizeThatFits)
            KanaCell(colorsInTables: .init(wrappedValue: false, "colors-in-tables"), kanaForList: kanasForList[13], kanaType: .katakana, widthDevice: 320)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
