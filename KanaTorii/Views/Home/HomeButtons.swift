//
//  HomeButtons.swift
//  KanaTorii
//
//  Created by Clément FLORET on 14/02/2021.
//

import SwiftUI

struct HomeButtons: View {
    @Binding var showIntroduction: Bool
    @Binding var showAbout: Bool
    var width: CGFloat
    var heightPadding: CGFloat
    var sizeText: CGFloat

    var body: some View {
        VStack {
            Button(action: {
                hapticFeedback(style: .soft)
                showIntroduction.toggle()
            }, label: {
                HomeButtonIntroduction(width: width, heightPadding: heightPadding, sizeText: sizeText)
            }).sheet(isPresented: $showIntroduction) {
                IntroductionView()
            }
            Button(action: {
                hapticFeedback(style: .soft)
                showAbout.toggle()
            }, label: {
                HomeButtonAbout(width: width, heightPadding: heightPadding, sizeText: sizeText)
            }).sheet(isPresented: $showAbout) {
                AboutView()
            }
        }
    }
}

struct HomeButtons_Previews: PreviewProvider {
    static var previews: some View {
        HomeButtons(showIntroduction: .constant(false), showAbout: .constant(false), width: 200, heightPadding: 20, sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}
