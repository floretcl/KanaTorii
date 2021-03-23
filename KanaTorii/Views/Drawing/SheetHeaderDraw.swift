//
//  SheetHeaderDraw.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct SheetHeaderDraw: View {
    @Environment(\.presentationMode) var presentation
    var paddingLeading: CGFloat
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: "hand.draw")
                    .font(.title)
                    .padding(.leading, paddingLeading)
                    .padding(.horizontal, 7)
                Text("Writing")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
            }
            .shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
            Spacer()
            Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                Label("Close", systemImage: "xmark.circle.fill")
                    .imageScale(.large)
            })
            .padding()
        }
        .background(Color("Green"))
        .foregroundColor(.white)
    }
}

struct SheetHeaderDraw_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderDraw(paddingLeading: 20)
            .previewLayout(.sizeThatFits)
    }
}
