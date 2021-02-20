//
//  DrawView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct DrawView: View {
    @State var kana: Kana
    @State var showGuide: Bool = true
    @State var drawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    @State var image: UIImage = UIImage()
    var kanaType: String
    var secondaryBackgroundColor: Color = Color(UIColor.secondarySystemBackground)
    let emptyKana: Kana = Kana.default
    
    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    SheetHeader(title: "Writing", systemImage: "hand.draw", paddingLeading: 20)
                    TitleDraw(kanaType: kanaType, kana: kana, sizeText: heightDevice/30)
                        .padding(.top, heightDevice/20)
                    Spacer()
                    DrawingPad(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/60, kana: kana, kanaType: kanaType, showGuide: showGuide)
                        .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                        .padding(.all, heightDevice/40)
                    DrawingButtons(drawings: $drawings, showGuide: $showGuide, sizeText: widthDevice/35, width: widthDevice/6, height: heightDevice/22)
                    Spacer()
                    DrawingNavigationButtons(drawings: $drawings, kana: $kana, sizeText: widthDevice/33, width: widthDevice/4, height: heightDevice/20)
                        .padding(.all, heightDevice/60)
                        .padding(.bottom, heightDevice/40)
                }
                .background(secondaryBackgroundColor)
                .edgesIgnoringSafeArea(.bottom)
                Spacer()
            } else {
                VStack {
                    SheetHeader(title: "Writing", systemImage: "hand.draw", paddingLeading: 20)
                    TitleDraw(kanaType: kanaType, kana: kana, sizeText: heightDevice/30)
                        .padding(.top, heightDevice/20)
                    Spacer()
                    DrawingPad(drawing: $drawing, drawings: $drawings, image: $image, lineWidth: widthDevice/35, kana: kana, kanaType: kanaType, showGuide: showGuide)
                        .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                        .padding(.all, heightDevice/40)
                    DrawingButtons(drawings: $drawings, showGuide: $showGuide, sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                    Spacer()
                    DrawingNavigationButtons(drawings: $drawings, kana: $kana, sizeText: widthDevice/20, width: widthDevice/2.5, height: heightDevice/16)
                        .padding(.all, heightDevice/60)
                    Spacer()
                }
                .background(secondaryBackgroundColor)
                .edgesIgnoringSafeArea(.bottom)
            }
        })
    }
}

struct DrawView_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        Group {
            DrawView(kana: modelData.kanas[100], kanaType: "hiragana")
                .previewDevice("iPad Pro (12.9-inch) (4th generation)")
        }
    }
}
