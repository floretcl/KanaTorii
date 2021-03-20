//
//  HomeBackground.swift
//  Shared
//
//  Created by Clément FLORET on 23/12/2020.
//

import SwiftUI

struct HomeBackground: View {
    var transparentColor: Color = Color.black.opacity(0)
    
    var body: some View {
        VStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("ShadowTopHome"), transparentColor]),
                startPoint: .top, endPoint: .center
            ).edgesIgnoringSafeArea(.all)
        }.background(
            Image("HomeBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .frame(alignment: .center)
        )
    }
}

struct HomeBackground_Previews: PreviewProvider {
    static var previews: some View {
        HomeBackground()
    }
}
