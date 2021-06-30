//
//  EmptyStatisticView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 30/06/2021.
//

import SwiftUI

struct EmptyStatisticView: View {
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Image("Stats")
                            .resizable()
                            .frame(width: 300, height: 300, alignment: .center)
                            .clipShape(Circle())
                        Text("No statistics to display")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.bottom, 100)
                            .padding(.horizontal, 50)
                    }
                    Spacer()
                }
                Spacer()
            }
        } else {
            GeometryReader(content: { geometry in
                let widthDevice = geometry.size.width
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Image("Stats")
                                .resizable()
                                .frame(width: widthDevice/2, height: widthDevice/2, alignment: .center)
                                .clipShape(Circle())
                            Text("No statistics to display")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding(.bottom, 100)
                                .padding(.horizontal, 50)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            })
        }

    }
}

struct EmptyStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStatisticView()
    }
}
