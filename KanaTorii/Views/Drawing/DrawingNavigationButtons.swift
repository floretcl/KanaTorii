//
//  DrawingNavigationButtons.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DrawingNavigationButtons: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var drawings: [Drawing]
    @Binding var kana: Kana
    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat
    var kanas: [Kana] {
        return modelData.kanas
    }
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
        HStack {
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
                kana = previousKana
            }, label: {
                NavigationButton(text: "Previous", systemImage: "chevron.left", sizeText: sizeText, inversed: false, width: width, height: height)
            }).padding(.horizontal, 10)
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
                kana = nextKana
            }, label: {
                NavigationButton(text: "Next", systemImage: "chevron.right", sizeText: sizeText, inversed: false, width: width, height: height)
            }).padding(.horizontal, 10)
            Spacer()
        }
    }
}

struct DrawingNavigationButtons_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DrawingNavigationButtons(drawings: .constant([Drawing]()), kana: .constant(modelData.kanas[100]), sizeText: 20, width: 130, height: 60)
    }
}
