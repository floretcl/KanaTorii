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
    var heightPadding: CGFloat
    var sizeText: CGFloat

    var body: some View {
        VStack {
            Button(action: {
                hapticFeedback(style: .soft)
                showIntroduction.toggle()
            }, label: {
                HomeButtonIntroduction(heightPadding: heightPadding, sizeText: sizeText)
            }).sheet(isPresented: $showIntroduction) {
                IntroductionView()
            }
            Button(action: {
                hapticFeedback(style: .soft)
                showAbout.toggle()
            }, label: {
                HomeButtonAbout(heightPadding: heightPadding, sizeText: sizeText)
            }).sheet(isPresented: $showAbout) {
                AboutView()
            }
        }
    }
}

struct HomeButtons_Previews: PreviewProvider {
    static var previews: some View {
        HomeButtons(showIntroduction: .constant(false), showAbout: .constant(false), heightPadding: 10, sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}
