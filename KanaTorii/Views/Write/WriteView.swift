//
//  WriteView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct WriteView: View {
    @EnvironmentObject var modelData: ModelData
    @State var kana: Kana
    @State var showGuide: Bool = true
    @State var currentDrawing: Drawing = Drawing()
    @State var drawings: [Drawing] = [Drawing]()
    var kanas: [Kana] {
        return modelData.kanas
    }
    var kanaType: String
    var secondaryBackgroundColor: Color = Color(UIColor.secondarySystemBackground)
    let emptyKana: Kana = Kana.default
    private var previousKana: Kana {
        var index = kana.id
        if index != 0 {
            index -= 1
        }
        return kanas[index]
    }
    private var nextKana: Kana {
        var index = kana.id
        if index != 103 {
            index += 1
        }
        return kanas[index]
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            let widthDevice = geometry.size.width
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    SheetHeader(title: "Writing", systemImage: "hand.draw", paddingLeading: 20)
                    TitleWrite(kanaType: kanaType, kana: kana, sizeText: heightDevice/30)
                        .padding(.top, heightDevice/20)
                    Spacer()
                    ZStack {
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 0)
                        WritingArea(
                            currentDrawing: $currentDrawing,
                            drawings: $drawings,
                            color: .primary,
                            lineWidth: widthDevice/60)
                        if showGuide {
                            Guide(kana: kana, kanaType: kanaType)
                        }
                        WritingGrid()
                    }
                    .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                    .padding(.all, heightDevice/40)
                    HStack {
                        Spacer()
                        Button(action: {
                            showGuide.toggle()
                        }, label: {
                            ShowGuideButtonLabel(sizeText: widthDevice/35, width: widthDevice/6, height: heightDevice/22)
                        })
                        Spacer()
                        Button(action: {
                            drawings = [Drawing]()
                        }, label: {
                            DeleteButtonLabel(sizeText: widthDevice/35, width: widthDevice/6, height: heightDevice/22)
                        })
                        .padding(.all, 10)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            drawings = [Drawing]()
                            kana = previousKana
                        }, label: {
                            NavigationButton(text: "Previous", systemImage: "chevron.left", sizeText: widthDevice/33, inversed: false, width: widthDevice/4, height: heightDevice/20)
                        }).padding(.horizontal, 10)
                        Spacer()
                        Button(action: {
                            drawings = [Drawing]()
                            kana = nextKana
                        }, label: {
                            NavigationButton(text: "Next", systemImage: "chevron.right", sizeText: widthDevice/33, inversed: false, width: widthDevice/4, height: heightDevice/20)
                        }).padding(.horizontal, 10)
                        Spacer()
                    }.padding(.all, heightDevice/60)
                }
                .background(secondaryBackgroundColor)
                .edgesIgnoringSafeArea(.bottom)
                Spacer()
            } else {
                VStack {
                    SheetHeader(title: "Writing", systemImage: "hand.draw", paddingLeading: 20)
                    TitleWrite(kanaType: kanaType, kana: kana, sizeText: heightDevice/30)
                        .padding(.top, heightDevice/20)
                    Spacer()
                    ZStack {
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .shadow(color: Color("Shadow"), radius: 10, x: 0, y: 0)
                        WritingArea(
                            currentDrawing: $currentDrawing,
                            drawings: $drawings,
                            color: .primary,
                            lineWidth: widthDevice/35)
                        if showGuide {
                            Guide(kana: kana, kanaType: kanaType)
                        }
                        WritingGrid()
                    }
                    .frame(minWidth: 250, idealWidth: 300, maxWidth: 600, minHeight: 250, idealHeight: 300, maxHeight: 400, alignment: .center)
                    .padding(.all, heightDevice/40)
                    HStack {
                        Spacer()
                        Button(action: {
                            showGuide.toggle()
                        }, label: {
                            ShowGuideButtonLabel(sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                        })
                        Spacer()
                        Button(action: {
                            drawings = [Drawing]()
                        }, label: {
                            DeleteButtonLabel(sizeText: widthDevice/22, width: widthDevice/3.3, height: heightDevice/22)
                        })
                        .padding(.all, 10)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            drawings = [Drawing]()
                            kana = previousKana
                        }, label: {
                            NavigationButton(text: "Previous", systemImage: "chevron.left", sizeText: widthDevice/20, inversed: false, width: widthDevice/2.5, height: heightDevice/16)
                        }).padding(.horizontal, 10)
                        Spacer()
                        Button(action: {
                            drawings = [Drawing]()
                            kana = nextKana
                        }, label: {
                            NavigationButton(text: "Next", systemImage: "chevron.right", sizeText: widthDevice/20, inversed: false, width: widthDevice/2.5, height: heightDevice/16)
                        }).padding(.horizontal, 10)
                        Spacer()
                    }.padding(.all, heightDevice/60)
                    Spacer()
                }
                .background(secondaryBackgroundColor)
                .edgesIgnoringSafeArea(.bottom)
            }
        })
    }
}

struct WriteView_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        Group {
            WriteView(kana: modelData.kanas[100], kanaType: "hiragana")
        }
    }
}
