//
//  UITextField.swift
//  KanaTorii
//
//  Created by Clément FLORET on 06/03/2021.
//
import UIKit
import SwiftUI

struct MyTextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Binding var becomeFirstResponder: Bool
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        if self.becomeFirstResponder {
            DispatchQueue.main.async {
                textField.becomeFirstResponder()
                self.becomeFirstResponder = false
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: MyTextField
        
        init(parent: MyTextField) {
            self.parent = parent
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        }
    }
}
