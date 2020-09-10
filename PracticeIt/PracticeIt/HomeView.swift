//
//  ContentView.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var Data = practiceData()
    @State private var newPattern: String = ""
    @State private var newDetail: String = ""
    @State private var newBPM : Double = 0
    @State private var newLength : String = ""
    
    // Contains all the view elements
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(self.Data.data) { pattern in
                       patternView(pattern: pattern)
                    }
                }
            }.navigationBarTitle("PracticeIt")
            .navigationBarItems(trailing: addPracticeButton)
        }
    }
    
    @State private var showAddPracticePage = false
    
    var addPracticeButton: some View {
        Button("Add practice") {
            self.showAddPracticePage = true
        }.sheet(isPresented: $showAddPracticePage) {
            self.addNewPatternInputForm()
        }
    }
    
    var cancelButton: some View {
       Button("Cancel") {
           self.showAddPracticePage = false
           self.newPattern = ""
           self.newDetail = ""
           self.newLength = ""
       }
    }
    
    // Elements for HomeView

    // create a new pattern and append it to the pattern array
    func addPattern() {
        Data.data.append(
            pattern(id: Data.data.count + 1, name: newPattern, BPM: newBPM, detail: newDetail, sessionLength: newLength)
        )
        self.newPattern = ""
        self.newDetail = ""
        self.newLength = ""
        // MARK: need to reset newLength as well. will figure it out later
    }
    
    // Return the view section for adding new pattern. Looks like a blue card 
    func addNewPatternInputForm() -> some View {
        NavigationView {
            Form {
                Picker("Select Practice Type:", selection: $newPattern) {
                    ForEach(self.Data.practiceType, id: \.self) { type in
                        Text("\(type)").tag(type)
                    }
                }.padding(.top, 20).padding(.bottom, 20)
                Text("Enter Details:")
                TextField("(Optional)", text: $newDetail).textFieldStyle(RoundedBorderTextFieldStyle())
                Picker("Choose Session Length", selection: $newLength) {
                    ForEach(self.Data.practiceLengthOptions, id: \.self) { option in
                        Text("\(option)").tag(option)
                       }
                    }.padding(.top, 20).padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text("Slide to set BPM").padding(.bottom, 20)
                    setBPMSlider()
                }
            }
        .navigationBarTitle("Add New Record")
        .navigationBarItems(leading: cancelButton, trailing: finishAddPracticeButton)
        }
    }
    
    // button for adding new pattern
    var finishAddPracticeButton : some View {
        Button("Done") {
            self.addPattern()
            self.showAddPracticePage = false
        }
        
    }
    
    // Slider view for setting BPM
    func setBPMSlider() -> some View {
        VStack {
            Slider(value: $newBPM, in: 40...250, step: 1)
                .padding(.leading, 20).padding(.trailing, 20)
            Text(String(newBPM))
        }.padding(.bottom, 40)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().addNewPatternInputForm()
    }
}
