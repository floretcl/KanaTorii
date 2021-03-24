//
//  SheetHeaderSettings.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct SheetHeaderSettings: View {
    @Environment(\.presentationMode) var presentation
    
    var paddingLeading: CGFloat
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: "gearshape")
                    .font(.title)
                    .padding(.leading, paddingLeading)
                    .padding(.horizontal, 7)
                Text("Settings")
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
                    .font(.body)
                    .imageScale(.large)
            })
            .padding(10)
        }
        .background(Color("Green"))
        .foregroundColor(.white)
    }
}

struct SheetHeaderSettings_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderSettings(paddingLeading: 20)
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
