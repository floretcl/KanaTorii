//
//  AboutView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 08/03/2021.
//

import SwiftUI

struct AboutView: View {
    var secondarySystemBackgroundColor: Color {
        return Color(UIColor.secondarySystemBackground)
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            VStack {
                SheetHeaderAbout(systemImage: "questionmark.circle.fill", paddingLeading: 5)
                ScrollView {
                    Group {
                        Text("About text")
                    }
                    .frame(width: widthDevice/1.2, alignment: .center)
                    .padding(.vertical, 20)
                    .font(.body)
                    .lineSpacing(5)
                    .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .background(secondarySystemBackgroundColor)
            .edgesIgnoringSafeArea(.bottom)
        })
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
