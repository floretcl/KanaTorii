//
//  IntroductionView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/12/2020.
//

import SwiftUI

struct IntroductionView: View {
    var secondarySystemBackgroundColor: Color {
        return Color(UIColor.secondarySystemBackground)
    }
    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            VStack {
                SheetHeaderIntroduction(systemImage: "questionmark.circle.fill", paddingLeading: 5)
                ScrollView {
                    Text("Introduction text")
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

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
