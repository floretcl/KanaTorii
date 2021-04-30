//
//  HomeView.swift
//  Shared
//
//  Created by Clément FLORET on 22/12/2020.
//

import SwiftUI

struct HomeView: View {
    @State var showShare = false
    @State var showSettings = false
    @State var showIntroduction = false
    @State var showAbout = false

    var body: some View {
        GeometryReader(content: { geometry in
            let widthDevice = geometry.size.width
            let heightDevice = geometry.size.height
            NavigationView {
                ZStack {
                    HomeBackground()
                    VStack {
                        HomeTitle(sizeText: heightDevice/15)
                        HomeJapaneseTitle(sizeText: heightDevice/20)
                        SubtitleHome()
                        Spacer()
                        Spacer()
                        Spacer()
                        Button(action: {
                            showIntroduction.toggle()
                        }, label: {
                            HomeButton(
                                textButton: "Introduction",
                                width: widthDevice/2.3,
                                heightPadding: heightDevice/55,
                                sizeText: 20)
                        }).sheet(isPresented: $showIntroduction) {
                            IntroductionView()
                        }
                        Button(action: {
                            showAbout.toggle()
                        }, label: {
                            HomeButton(
                                textButton: "About Kana",
                                width: widthDevice/2.3,
                                heightPadding: heightDevice/55,
                                sizeText: 20)
                        }).sheet(isPresented: $showAbout) {
                            AboutView()
                        }
                        Spacer()
                    }
                }
                .navigationBarItems(
                    leading:
                        ButtonShare(showShare: $showShare)
                            .sheet(isPresented: $showShare,
                                   content: {
                                    ActivityView(
                                        activityItems: [NSURL(string: "https://apps.apple.com/us/app/kana-torii/id1542369272")!] as [Any],
                                    applicationActivities: nil) }),
                    trailing:
                        ButtonSettings(showSettings: $showSettings)
                            .fullScreenCover(isPresented: $showSettings, content: {
                                SettingsView(
                                    dislayStatisticsColorIsOn: true,
                                    pickerDisplayMode: 1,
                                    stepperNbQuestions: 10)
                            })
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
        }
    }
}
