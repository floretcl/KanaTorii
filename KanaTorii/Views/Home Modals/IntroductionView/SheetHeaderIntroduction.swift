//
//  SheetHeaderIntroduction.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct SheetHeaderIntroduction: View {
    @Environment(\.presentationMode) var presentation
    
    var paddingLeading: CGFloat
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: "questionmark.circle.fill")
                    .font(.title)
                    .padding(.leading, paddingLeading)
                    .padding(.horizontal, 7)
                Text("Introduction to Kana")
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

struct SheetHeaderIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderIntroduction(paddingLeading: 5)
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
