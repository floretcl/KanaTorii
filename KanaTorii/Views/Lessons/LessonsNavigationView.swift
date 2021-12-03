//
//  LessonsNavigationView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI
import StoreKit

struct LessonsNavigationView: View {
    @StateObject var storeManager: StoreManager
    @EnvironmentObject var modelData: ModelData
    var freeLessons: [LessonForList] {
        return modelData.freeLessons
    }
    var lessons: [LessonForList] {
        return modelData.lessons  
    }
    @State var showReminder: Bool = false

    fileprivate func ListOfLessons(lessons: [LessonForList]) -> some View {
        return List(lessons) { lesson in
            NavigationLink(
                destination: LessonInfoView(lesson: lesson),
                label: {
                    LessonRow(lesson: lesson)
                })
        }
        .navigationBarTitle("Lessons")
        .navigationBarItems(
            leading: Button(action: {
                storeManager.restoreProducts()
            }, label: {
                Image(systemName: "cart")
                    .foregroundColor(Color.accentColor)
                    .font(.title3)
                    .padding(.bottom, 10.0)
                Text("Restore")
                    .foregroundColor(Color.accentColor)
            }),
            trailing: Button(
                action: {
                    hapticFeedback(style: .soft)
                    showReminder.toggle()
            }, label: {
                 Text("Reminder")
                     .foregroundColor(Color.accentColor)
                 Image(systemName: "clock.arrow.circlepath")
                     .foregroundColor(Color.accentColor)
                     .font(.title3)
                     .padding(.bottom, 10.0)
                }
            ).sheet(isPresented: $showReminder, content: {
                ReminderView()
            })
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(storeManager.products, id: \.self) { product in
                    if UserDefaults.standard.bool(forKey: product.productIdentifier) {
                        ListOfLessons(lessons: lessons)
                    } else {
                        Button(action: {
                            storeManager.purchaseProduct(product: product)
                        }, label: {
                            Text("\(product.localizedTitle) \(product.price)")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.accentColor)
                                .clipShape(Capsule())
                        })
                        ListOfLessons(lessons: freeLessons)
                    }
                }
            }
            if UIDevice.current.localizedModel == "iPad" {
                VStack {
                    Image("ema")
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                        .clipShape(Circle())
                    Text("Start a lesson right now by clicking on 'lessons' at the top left")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.bottom, 100)
                        .padding(.horizontal, 100)
                }
            }
        }
    }
}

struct LessonsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsNavigationView(storeManager: StoreManager())
            .environmentObject(ModelData())
    }
}
