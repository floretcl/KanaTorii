//
//  DrawingNavigationButtons.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DrawingNavigationButtons: View {
    @EnvironmentObject var modelData: ModelData
    var kanas: [Kana] {
        return modelData.kanas
    }
    
    @Binding var kana: Kana
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
    
    @Binding var drawings: [Drawing]
    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
                kana = previousKana
            }, label: {
                NavigationButtonPrevious(systemImage: "chevron.left", sizeText: sizeText, inversed: false, width: width, height: height)
            }).padding(.horizontal, 10)
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
                kana = nextKana
            }, label: {
                NavigationButtonNext(systemImage: "chevron.right", sizeText: sizeText, inversed: true, width: width, height: height)
            }).padding(.horizontal, 10)
            Spacer()
        }
    }
}

struct DrawingNavigationButtons_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DrawingNavigationButtons(kana: .constant(modelData.kanas[100]), drawings: .constant([Drawing]()), sizeText: 20, width: 130, height: 60)
    }
}
