//
//  SheetHeaderDraw.swift
//  KanaTorii
//
//  Created by Clément FLORET on 10/03/2021.
//

import SwiftUI

struct SheetHeaderDraw: View {
    @Environment(\.presentationMode) var presentation
    var systemImage: String
    var paddingLeading: CGFloat
    
    var body: some View {
        if UIDevice.current.localizedModel == "iPad" {
            HStack {
                Group {
                    Image(systemName: systemImage)
                        .font(.title)
                        .padding(.leading, 60)
                        .padding(.leading, paddingLeading)
                        .padding(.horizontal, 7)
                    Text("Writing")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                .shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
                Spacer()
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                        .imageScale(.large)
                })
                .padding()
            }
            .background(Color("Green"))
            .foregroundColor(.white)
        } else {
            HStack {
                Group {
                    Image(systemName: systemImage)
                        .font(.title)
                        .padding(.leading, paddingLeading)
                        .padding(.horizontal, 7)
                    Text("Writing")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }.shadow(color: Color.black, radius: 4, x: 0.0, y: 2.0)
                Spacer()
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Label("Close", systemImage: "xmark.circle.fill")
                        .imageScale(.large)
                })
                .padding()
            }
            .background(Color("Green"))
            .foregroundColor(.white)
        }
    }
}

struct SheetHeaderDraw_Previews: PreviewProvider {
    static var previews: some View {
        SheetHeaderDraw(systemImage: "sun.min", paddingLeading: 20)
            .previewDevice("iPad Pro (12.9-inch) (4th generation)")
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
