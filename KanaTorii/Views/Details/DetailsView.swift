//
//  DetailsView.swift
//  Kana Torii
//
//  Created by Clément FLORET on 15/01/2021.
//

import SwiftUI

struct DetailsView<Page: View>: View {
    var pages: [Page]
    @State var currentPage: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            PageViewController(pages: pages, currentPage: $currentPage)
                .edgesIgnoringSafeArea(.all)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
            ChevronButton(currentPage: $currentPage)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(
            pages: ModelData().kanas.map {
                DetailPage(kana: $0, kanaType: .hiragana)},
            currentPage: 4
        )
    }
}
