//
//  DrawingButtons.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct DrawingButtons: View {
    @Binding var drawings: [Drawing]
    @Binding var showGuide: Bool
    var sizeText: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                showGuide.toggle()
            }, label: {
                ShowGuideButtonLabel(sizeText: sizeText, width: width, height: height)
            })
            Spacer()
            Button(action: {
                drawings = [Drawing]()
            }, label: {
                DeleteButtonLabel(sizeText: sizeText, width: width, height: height)
            })
            .padding(.all, 10)
            Spacer()
        }
    }
}

struct DrawingButtons_Previews: PreviewProvider {
    static var previews: some View {
        DrawingButtons(drawings: .constant([Drawing]()), showGuide: .constant(true), sizeText: 20, width: 130, height: 60)
            
    }
}
