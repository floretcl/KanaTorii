//
//  StatisticsSection.swift
//  Kana Torii
//
//  Created by Clément FLORET on 09/01/2021.
//

import SwiftUI

struct StatisticsSection: View {
    var nbCorrectAnswers: Float
    var nbTotalAnswers: Float
    var heightDevice: CGFloat
    var sizeText: CGFloat
    private var percCorrectAnswers: Float {
        return (nbCorrectAnswers / nbTotalAnswers) * 100.0
    }
    private var progressViewColor: Color {
        switch percCorrectAnswers {
        case 0..<20:
            return .black
        case 20..<40:
            return .red
        case 40..<60:
            return .orange
        case 60..<80:
            return .yellow
        case 80...100:
            return .green
        default:
            return .gray
        }
    }
    
    var body: some View {
        VStack {
            ProgressView("Correct Answers : \(Int(percCorrectAnswers))%", value: percCorrectAnswers, total: 100.0)
                .font(.system(size: sizeText))
                .progressViewStyle(LinearProgressViewStyle(tint: progressViewColor))
            Text("\(Int(nbCorrectAnswers)) / \(Int(nbTotalAnswers))")
                .font(.system(size: sizeText))
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(7)
        .shadow(color: Color.black.opacity(0.1), radius: 29, x: 0.0, y: 0.0)
    }
}

struct StatisticsSection_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSection(nbCorrectAnswers: 10.0, nbTotalAnswers: 50.0, heightDevice: 800, sizeText: 20)
            .previewLayout(.sizeThatFits)
    }
}
