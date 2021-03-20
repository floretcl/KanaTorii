//
//  PageControl.swift
//  Kana Torii
//
//  Created by Clément FLORET on 14/01/2021.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.pageIndicatorTintColor = UIColor(.primary)
        control.currentPageIndicatorTintColor = UIColor(named: "AccentColor")
        control.allowsContinuousInteraction = false // If true -> crash
        control.numberOfPages = numberOfPages
        control.addTarget(
                    context.coordinator,
                    action: #selector(Coordinator.updateCurrentPage(sender:)),
                    for: .valueChanged)
        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
