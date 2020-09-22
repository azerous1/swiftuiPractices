//
//  practiceInputForm.swift
//  practice3
//
//  Created by Yichi Zhang  on 9/16/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI
import Foundation

struct practiceInputForm: View {
    
    @ObservedObject var Data = userOptionData()
    
    var addButton : AnyView
    var cancelButton : AnyView
    var isAdding : Bool
    
    var body: some View {
           return NavigationView {
               Form {
                   Picker("Select Practice Type:", selection: $Data.newType) {
                       ForEach(self.Data.practiceType, id: \.self) { type in
                           Text("\(type)").tag(type)
                       }
                   }.padding(.top, 20).padding(.bottom, 20)
                   
                   Picker("Choose Session Length", selection: $Data.newLength) {
                       ForEach(self.Data.practiceLengthOptions, id: \.self) { option in
                           Text("\(option)").tag(option)
                          }
                       }.padding(.top, 20).padding(.bottom, 20)
                   
                   VStack(alignment: .leading) {
                       Text("Slide to set BPM").padding(.bottom, 20).padding(.top, 20)
                       setBPMSlider()
                   }
                   
                   VStack(alignment: .leading) {
                       Text("Enter Details:").padding(.top, 20)
                       TextField("(Optional)", text: $Data.newDetail).textFieldStyle(RoundedBorderTextFieldStyle())
                             .padding(.top, 10)
                             .padding(.bottom, 20)
                       //DynamicHeightTextField(text: $newDetail, height: $textHeight)
                   }
               }
               .navigationBarTitle(self.isAdding ? "Add New Record" : "Update Record")
           .navigationBarItems(leading: cancelButton, trailing: addButton)
           }
    }
    
    
    init(isAddingPractice : Bool, cancelButton : AnyView, addButton : AnyView) {
        self.addButton = addButton
        self.cancelButton = cancelButton
        self.isAdding = isAddingPractice
    }
    
    func setBPMSlider() -> some View {
        VStack {
            Slider(value: $Data.newBPM, in: 40...250, step: 1)
                .padding(.leading, 20).padding(.trailing, 20)
            Text(String(Data.newBPM))
        }.padding(.bottom, 20)
    }  
}


