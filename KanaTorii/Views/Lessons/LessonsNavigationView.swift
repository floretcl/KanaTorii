//
//  LessonsNavigationView.swift
//  KanaTorii
//
//  Created by Clément FLORET on 22/03/2021.
//

import SwiftUI
import StoreKit
import SwiftKeychainWrapper

struct LessonsNavigationView: View {
    @StateObject var storeManager: StoreManager
    var lessonProduct: SKProduct {
        return storeManager.products[0]
    }
    let productID = "fr.clementfloret.kanatorii.IAP.lessons"
    let formatter = NumberFormatter()
    var price: String {
        formatter.locale = lessonProduct.priceLocale
        formatter.numberStyle = .currency
        if let localPrice = formatter.string(from: lessonProduct.price) {
            return localPrice
        } else {
            return "\(lessonProduct.price)"
        }
    }
    @EnvironmentObject var modelData: ModelData
    var freeLessons: [LessonForList] {
        return modelData.freeLessons
    }
    var lessons: [LessonForList] {
        return modelData.lessons  
    }
    @State var showReminder: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if getProduct() {
                    List(lessons) { lesson in
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
                        trailing: Button(action: {
                            hapticFeedback(style: .soft)
                            showReminder.toggle()
                        },
                        label: {
                            Text("Reminder")
                                .foregroundColor(Color.accentColor)
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(Color.accentColor)
                                .font(.title3)
                                .padding(.bottom, 10.0)
                        }).sheet(isPresented: $showReminder, content: {
                            ReminderView()
                        })
                    )
                } else {
                    Button(action: {
                        storeManager.purchaseProduct(product: lessonProduct)
                    }, label: {
                        Text("Buy 84 extra lessons \(price)")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                    })
                    List(freeLessons) { lesson in
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
                        trailing: Button(action: {
                            hapticFeedback(style: .soft)
                            showReminder.toggle()
                        },
                        label: {
                            Text("Reminder")
                                .foregroundColor(Color.accentColor)
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(Color.accentColor)
                                .font(.title3)
                                .padding(.bottom, 10.0)
                        }).sheet(isPresented: $showReminder, content: {
                            ReminderView()
                    }))
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
    private func getProduct() -> Bool {
        guard let alreadyPurchased = KeychainWrapper.standard.bool(forKey: productID) else {
            return false
        }
        return alreadyPurchased
    }
}

struct LessonsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        let storeManager = StoreManager(products: ["fr.clementfloret.kanatorii.IAP.lessons"])
        LessonsNavigationView(storeManager: storeManager)
            .environmentObject(storeManager)
            .environmentObject(ModelData())
    }
}
