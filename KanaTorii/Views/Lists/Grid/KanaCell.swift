//
//  KanaCell.swift
//  Kana Torii
//
//  Created by Clément FLORET on 01/01/2021.
//

import SwiftUI

struct KanaCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \StatKana.kana, ascending: true)],
        animation: .default) var statKana: FetchedResults<StatKana>
    @ObservedObject var userSettings = UserSettings()
    @State var kana: Kana = Kana.default
    var kanaType: Kana.KanaType
    var kanaForList: KanaForList
    var widthDevice: CGFloat
    private var label: String {
        if kanaType == .hiragana {
            return self.kanaForList.hiragana
        } else {
            return self.kanaForList.katakana
        }
    }
    private var color: Color {
        if userSettings.colorsInTables {
            for stat in statKana {
                if self.label == stat.kana {
                    return getProgressViewColor(nbCorrectAnswers: stat.nbCorrectAnswers, nbTotalAnswers: stat.nbTotalAnswers)
                }
            }
        }
        return .primary
    }
    
    var body: some View {
        NavigationLink(
            destination: DetailsView(
                currentPage: getId(),
                pages: ModelData().kanas.map {
                    DetailPage(kana: $0, kanaType: kanaType)
                }
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
        .onAppear(perform: {
            userSettings.colorsInTables = UserDefaults.standard.object(forKey: "colors-in-tables") as? Bool ?? true
        })
    }
    
    func getId() -> Int {
        if kanaForList.name != "" {
            return kana.getIdKana(name: kanaForList.name)
        }
        return 0
    }
    private func getPercentage(nbCorrectAnswers: Float, nbTotalAnswers: Float) -> Float {
        return (nbCorrectAnswers / nbTotalAnswers) * 100.0
    }
    private func getProgressViewColor(nbCorrectAnswers: Float, nbTotalAnswers: Float) -> Color {
        switch getPercentage(nbCorrectAnswers: nbCorrectAnswers, nbTotalAnswers: nbTotalAnswers) {
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
            KanaCell(kanaType: .hiragana, kanaForList: kanasForList[10], widthDevice: 320)
                .previewLayout(.sizeThatFits)
            KanaCell(kanaType: .katakana, kanaForList: kanasForList[13], widthDevice: 320)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
