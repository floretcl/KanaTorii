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
                if UIDevice.current.localizedModel == "iPad" {
                    SheetHeaderAbout(paddingLeading: 65)
                } else {
                    SheetHeaderAbout(paddingLeading: 5)
                }
                ScrollView {
                    Text("About text")
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
