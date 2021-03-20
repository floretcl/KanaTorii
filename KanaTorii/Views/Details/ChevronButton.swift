//
//  ChevronButton.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/01/2021.
//

import SwiftUI

struct ChevronButton: View {
    @EnvironmentObject var modelData: ModelData
    var kanas: [Kana] {
        return modelData.kanas
    }
    
    @Binding var currentPage: Int
    
    var body: some View {
        GeometryReader(content: { geometry in
            let heightDevice = geometry.size.height
            VStack(alignment: .center, spacing: 0, content: {
                Spacer()
                HStack {
                    Button(action: {
                        hapticFeedback(style: .soft)
                        if currentPage == 0 {
                            currentPage = (kanas.count - 1)
                        } else {
                            currentPage  -= 1
                        }
                    }, label: {
                        Chevron(label: "chevron.left", heightDevice: heightDevice)
                    })
                    Spacer()
                    Button(action: {
                        hapticFeedback(style: .soft)
                        if currentPage == (kanas.count - 1) {
                            currentPage = 0
                        } else {
                            currentPage += 1
                        }
                    }, label: {
                        Chevron(label: "chevron.right", heightDevice: heightDevice)
                    })
                }
                Spacer()
            })
        })
    }
}

struct ChevronButton_Previews: PreviewProvider {
    static var previews: some View {
        ChevronButton(currentPage: .constant(0))
    }
}
