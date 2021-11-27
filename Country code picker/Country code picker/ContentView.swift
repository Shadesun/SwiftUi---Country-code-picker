//
//  ContentView.swift
//  Country code picker
//
//  Created by Shadesun on 27/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State var currentCode = String()
    @State var phoneNumber = String()
    var body: some View {
        HStack {
            PhoneNumberSelector(currentCode: $currentCode)
                .foregroundColor(Color.gray)
            Divider()
            TextField("Phone number", text: $phoneNumber, onEditingChanged: {_ in
                // remove the first character is 0 for phone number format compliance
                if phoneNumber.first == "0" {
                    self.phoneNumber = String(phoneNumber.dropFirst())
                }
                }, onCommit: {
                    if phoneNumber.first == "0" {
                        self.phoneNumber = String(phoneNumber.dropFirst())
                    }
                })
            .keyboardType(.numberPad)
            Image(systemName: "phone.fill").foregroundColor(Color.gray)
        }.padding(.all, 20)
        .frame(width: 300.0, height: 60.0)
        .font(.system(size: 16, weight: .regular, design: .default))
        .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: 4)
            )
        }
}
