//
//  ScoreView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 27/02/2021.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var score = Score()
    
    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            VStack {
                Image(systemName: "chevron.down")
                    .font(.system(size: 50))
                    .padding(.top, heightDevice/25)
                Spacer()
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .foregroundColor(Color("ShadowTopHome"))
                            .frame(width: widthDevice/1.5, height: widthDevice/1.5, alignment: .center)
                        VStack {
                            Text("Your score : ")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("\(score.nbCorrectAnswers) / \(score.nbTotalQuestions)")
                                .font(.system(size: widthDevice/6))
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }.background(
                Image("Score")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
        }).edgesIgnoringSafeArea(.all)
        
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScoreView()
        }
    }
}
