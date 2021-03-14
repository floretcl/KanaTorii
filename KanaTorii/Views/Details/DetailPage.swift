//
//  DetailPage.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/01/2021.
//

import SwiftUI

struct DetailPage: View {
    @State var showDrawingView = false
    @State var kana: Kana
    var kanaType: Kana.KanaType
    var type: String {
        if kanaType == .hiragana {
            return "hiragana"
        } else {
            return "katakana"
        }
    }
    private var kanaLabel: String {
        return getKanaLabel(kana: kana)
    }
    private var otherLabel: String {
        return ifHiragana(get: kana.katakana, elseGet: kana.hiragana)
    }
    private var linesOrderImage: String {
        return getLinesOrderImage(kana: kana)
    }
    var nbCorrectAnswers: Float = 20.0
    var nbTotalAnswers: Float = 80.0
    
    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    FlashCard(
                        kanaType: type,
                        label: kanaLabel,
                        otherLabel: otherLabel,
                        romaji: kana.romaji,
                        heightDevice: heightDevice)
                        .padding(.top, heightDevice/30)
                        .padding(.bottom, heightDevice/40)
                    DetailButtons(showDrawingView: $showDrawingView, kana: kana, kanaLabel: kanaLabel, sizeText: heightDevice/45)
                        .padding(.all, heightDevice/80)
                        .fullScreenCover(isPresented: $showDrawingView, content: {
                            DrawView(kana: kana, kanaType: type)
                        })
                    StatisticsSection(
                        nbCorrectAnswers: self.nbCorrectAnswers,
                        nbTotalAnswers: self.nbTotalAnswers, widthDevice: widthDevice,
                        heightDevice: heightDevice,
                        sizeText: heightDevice/40)
                        .padding(.all, heightDevice/80)
                        .frame(width: widthDevice/1.7, alignment: .center)
                    LinesImagesSection(
                        linesOrderImage: self.linesOrderImage,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice, sizeText: heightDevice/35)
                        .padding(.all, heightDevice/80)
                        .frame(width: widthDevice/1.45, height: heightDevice / 2.5, alignment: .center)
                    Spacer()
                }
                .padding(.top, heightDevice/7)
                .background(Color(UIColor.secondarySystemBackground))
                .edgesIgnoringSafeArea(.top)
            } else {
                VStack {
                    FlashCard(
                        kanaType: type,
                        label: kanaLabel,
                        otherLabel: otherLabel,
                        romaji: kana.romaji,
                        heightDevice: heightDevice)
                        .padding(.top, heightDevice/30)
                        .padding(.bottom, heightDevice/40)
                    DetailButtons(showDrawingView: $showDrawingView, kana: kana, kanaLabel: kanaLabel, sizeText: heightDevice/35)
                        .padding(.all, heightDevice/80)
                        .fullScreenCover(isPresented: $showDrawingView, content: {
                            DrawView(kana: kana, kanaType: type)
                        })
                    StatisticsSection(
                        nbCorrectAnswers: self.nbCorrectAnswers,
                        nbTotalAnswers: self.nbTotalAnswers, widthDevice: widthDevice,
                        heightDevice: heightDevice,
                        sizeText: heightDevice/34)
                        .padding(.all, heightDevice/80)
                        .frame(width: widthDevice/1.4, alignment: .center)
                    LinesImagesSection(
                        linesOrderImage: self.linesOrderImage,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice, sizeText: heightDevice/34)
                        .padding(.all, heightDevice/80)
                        .frame(width: widthDevice, height: heightDevice / 2.5, alignment: .center)
                    Spacer()
                }
                .padding(.top, heightDevice/7)
                .background(Color(UIColor.secondarySystemBackground))
                .edgesIgnoringSafeArea(.top)
            }
        })
    }
    
    private func ifHiragana(get: String, elseGet: String) -> String {
        if kanaType == .hiragana {
            return get
        } else {
            return elseGet
        }
    }
    
    private func getLinesOrderImage(kana: Kana) -> String {
        return ifHiragana(get: kana.fileNameHiraganaWithLineOrder, elseGet: kana.fileNameKatakanaWithLineOrder)
    }
    
    private func getKanaLabel(kana: Kana) -> String {
        return ifHiragana(get: kana.hiragana, elseGet: kana.katakana)
    }
}

struct DetailPage_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DetailPage(kana: modelData.kanas[0], kanaType: .hiragana)
    }
}
