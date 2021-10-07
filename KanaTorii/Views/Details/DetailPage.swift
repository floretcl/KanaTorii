//
//  DetailPage.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/01/2021.
//

import SwiftUI

struct DetailPage: View {
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
    @State var showDrawingView = false

    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    FlashCard(
                        type: type,
                        label: kanaLabel,
                        otherLabel: otherLabel,
                        romaji: kana.romaji,
                        heightDevice: heightDevice)
                        .padding(.top, heightDevice/20)
                        .padding(.bottom, heightDevice/40)
                    DetailButtons(
                        kana: kana,
                        kanaLabel: kanaLabel,
                        sizeText: heightDevice/45,
                        showDrawingView: $showDrawingView)
                        .padding(.all, heightDevice/80)
                        .fullScreenCover(isPresented: $showDrawingView, content: {
                            DrawView(kana: kana, kanaType: type)
                        })
                    StatisticsSection(
                        kanaLabel: kanaLabel,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice,
                        sizeText: heightDevice/47,
                        sizeTextCustomCircularProgressView: 14,
                        sizeCustomCircularProgressView: 55)
                        .padding(.horizontal, widthDevice/40)
                        .padding(.vertical, 5)
                        .frame(minWidth: 300, idealWidth: 360, maxWidth: 450)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color("Shadow"), radius: 7, x: 0.0, y: 0.0)
                        .padding(.all, heightDevice/80)
                    LinesImagesSection(
                        linesOrderImage: self.linesOrderImage,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice, sizeText: heightDevice/35)
                        .padding(.horizontal, widthDevice/30)
                        .padding(.vertical)
                        .frame(minWidth: 200, idealWidth: 360, maxWidth: 450, minHeight: heightDevice/2.9, idealHeight: heightDevice/2.9, maxHeight: heightDevice/2.9)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color("Shadow"), radius: 7, x: 0.0, y: 0.0)
                        .padding(.all, heightDevice/80)
                }
            } else {
                VStack {
                    FlashCard(
                        type: type,
                        label: kanaLabel,
                        otherLabel: otherLabel,
                        romaji: kana.romaji,
                        heightDevice: heightDevice)
                        .padding(.top, heightDevice/20)
                        .padding(.bottom, heightDevice/40)
                    DetailButtons(
                        kana: kana,
                        kanaLabel: kanaLabel,
                        sizeText: heightDevice/35,
                        showDrawingView: $showDrawingView)
                        .padding(.all, heightDevice/80)
                        .fullScreenCover(isPresented: $showDrawingView, content: {
                            DrawView(kana: kana, kanaType: type)
                        })
                    StatisticsSection(
                        kanaLabel: kanaLabel,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice,
                        sizeText: widthDevice/20,
                        sizeTextCustomCircularProgressView: 12,
                        sizeCustomCircularProgressView: 50)
                        .padding(.horizontal, widthDevice/40)
                        .padding(.vertical, 5)
                        .frame(width: widthDevice/1.4, alignment: .center)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color("Shadow"), radius: 7, x: 0.0, y: 0.0)
                        .padding(.all, heightDevice/80)
                    LinesImagesSection(
                        linesOrderImage: self.linesOrderImage,
                        widthDevice: widthDevice,
                        heightDevice: heightDevice, sizeText: heightDevice/34)
                        .padding(.horizontal, widthDevice/10)
                        .padding(.vertical)
                        .frame(width: widthDevice/1.4, height: heightDevice/3.5, alignment: .center)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color("Shadow"), radius: 7, x: 0.0, y: 0.0)
                        .padding(.all, heightDevice/80)
                }
            }
        }).background(Color(UIColor.secondarySystemBackground))
    }

    private func getLinesOrderImage(kana: Kana) -> String {
        return ifHiragana(get: kana.fileNameHiraganaWithLineOrder, elseGet: kana.fileNameKatakanaWithLineOrder)
    }

    private func getKanaLabel(kana: Kana) -> String {
        return ifHiragana(get: kana.hiragana, elseGet: kana.katakana)
    }

    private func ifHiragana(get: String, elseGet: String) -> String {
        if kanaType == .hiragana {
            return get
        } else {
            return elseGet
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        Group {
            DetailPage(kana: modelData.kanas[0], kanaType: .hiragana)
        }
    }
}
