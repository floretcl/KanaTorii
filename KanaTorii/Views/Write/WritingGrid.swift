//
//  WritingGrid.swift
//  Kana Torii
//
//  Created by Clément FLORET on 26/01/2021.
//

import SwiftUI

struct WritingGrid: View {
    var body: some View {
        ZStack {
            VerticalDottedLine()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
            HorizontalDottedLine()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
        }.foregroundColor(Color("Gray"))
    }
}

struct WritingGrid_Previews: PreviewProvider {
    static var previews: some View {
        WritingGrid()
            .preferredColorScheme(.dark)
    }
}
