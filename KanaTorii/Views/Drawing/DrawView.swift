//
//  DrawView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct DrawView: View {
    @State var kana: Kana
    var kanaType: String
    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()
    var secondaryBackgroundColor: Color = Color(UIColor.secondarySystemBackground)
    @State var showGuide: Bool = true

    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
                VStack {
                    if UIDevice.current.localizedModel == "iPad" {
                        SheetHeaderDraw(paddingLeading: 80)
                    } else {
                        SheetHeaderDraw(paddingLeading: 20)
                    }
                    TitleDraw(kana: kana, kanaType: kanaType, sizeText: heightDevice/30)
                        .padding(.top, heightDevice/20)
                    Spacer()
                    if UIDevice.current.localizedModel == "iPad" {
                        DrawingPad(kana: kana, kanaType: kanaType, drawing: $drawing, drawings: $drawings, image: $image, lineWidth: 15, showGuide: showGuide)
                            .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                            .padding(.all, heightDevice/40)
                        DrawingButtons(drawings: $drawings, showGuide: $showGuide, sizeText: heightDevice/40, width: heightDevice/5, height: heightDevice/22, widthSpace: widthDevice/44)
                        Spacer()
                        DrawingNavigationButtons(kana: $kana, drawings: $drawings, sizeText: heightDevice/42, width: heightDevice/6, height: heightDevice/20, widthSpace: widthDevice/6)
                            .padding(.all, heightDevice/60)
                            .padding(.bottom, heightDevice/40)
                    } else {
                        DrawingPad(kana: kana, kanaType: kanaType, drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/40, showGuide: showGuide)
                            .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                            .padding(.all, heightDevice/40)
                        DrawingButtons(drawings: $drawings, showGuide: $showGuide, sizeText: widthDevice/22, width: heightDevice/5, height: heightDevice/22, widthSpace: widthDevice/40)
                        Spacer()
                        DrawingNavigationButtons(kana: $kana, drawings: $drawings, sizeText: widthDevice/24, width: heightDevice/6, height: heightDevice/18, widthSpace: widthDevice/6)
                            .padding(.all, heightDevice/60)
                        Spacer()
                    }
                }
                .background(secondaryBackgroundColor)
                .edgesIgnoringSafeArea(.bottom)
            if UIDevice.current.localizedModel == "iPad" {
                Spacer()
            }
        })
    }
}

struct DrawView_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        Group {
            DrawView(kana: modelData.kanas[100], kanaType: "hiragana")
        }
    }
}
