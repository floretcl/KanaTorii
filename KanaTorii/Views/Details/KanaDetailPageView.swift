//
//  KanaDetailPageView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/01/2021.
//

import SwiftUI

struct KanaDetailPageView<Page: View>: View {
    @State var currentPage: Int
    var pages: [Page]
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            PageViewController(currentPage: $currentPage, pages: pages)
                .edgesIgnoringSafeArea(.all)
            PageControl(currentPage: $currentPage, numberOfPages: pages.count)
            ChevronButton(currentPage: $currentPage)
        }
    }
}

struct KanaDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        KanaDetailPageView(
            currentPage: 4,
            pages: ModelData().kanas.map {
                DetailPage(kana: $0, kanaType: .hiragana)
            }
        )
    }
}
