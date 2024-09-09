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
    var widthSpace: CGFloat

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
                kana = previousKana
            }, label: {
                Label("Previous", systemImage: "chevron.left")
                    .font(.system(size: sizeText))
                    .foregroundColor(.white)
                    .frame(width: width, height: height, alignment: .center)
                    .background(Color.orange)
                    .cornerRadius(50.0)
            })
            .padding(.vertical, 10)
            HStack{}
                .frame(width: widthSpace)
            Button(action: {
                hapticFeedback(style: .soft)
                drawings = [Drawing]()
                kana = nextKana
            }, label: {
                Label("Next", systemImage: "chevron.right")
                    .labelStyle(InversedLabel())
                    .font(.system(size: sizeText))
                    .foregroundColor(.white)
                    .frame(width: width, height: height, alignment: .center)
                    .background(Color.orange)
                    .cornerRadius(50.0)
            })
            .padding(.vertical, 10)
            Spacer()
        }
    }
}

struct DrawingNavigationButtons_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        DrawingNavigationButtons(kana: .constant(modelData.kanas[100]), drawings: .constant([Drawing]()), sizeText: 20, width: 130, height: 60, widthSpace: 50)
            .previewLayout(.sizeThatFits)
    }
}
