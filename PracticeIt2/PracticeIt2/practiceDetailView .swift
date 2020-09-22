//
//  practiceDetailView .swift
//  PracticeIt2
//
//  Created by Yichi Zhang  on 9/11/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI
import CoreData

// Return view for display details when user clicks a practice entry in home page
// Navigate user to a new page and display an extra piece of data -- details-- in conjuction
// with all the data from practiceView.

struct practiceDetailView: View {
    
    @State var showUpdateSheet = false
    
    var practice : NSManagedObject

    var body: some View {
        
        // Saving each attribute from the Practice OBject as variables.
        // MARK: Not sure about the syntax below. Will revisit later. 
        var type = (practice as? Practice)?.type ?? "data error"
        var bpm = (practice as? Practice)?.bpm.removeZerosFromEnd() ?? "data error"
        var length = (practice as? Practice)?.sessionLength ?? "data error"
        let detail = (practice as? Practice)?.detail ?? "data error"
        let id = (practice as? Practice)?.id
        
           if(bpm == "0") {
                 bpm = "--"
             }
             
             if(length == "") {
                 length = "--"
             }
             
             if(type == "") {
                 type = "--"
             }
        
        return VStack(alignment: .leading) {
            Text("Practice type:      \(type)").padding(.bottom, 30).padding(.trailing, 30)
            Text("BPM:                         \(bpm)").padding(.bottom, 30)
            Text("Session length:   \(length) minutes").padding(.bottom, 30)
            Text("Details:").padding(.bottom, 20)
            Text(detail).padding(.bottom, 30).font(.system(size: 20)).multilineTextAlignment(.leading)
            // height affect the padding between the detail indicator and the detail text. will fix it later.
            .navigationBarTitle("Practice Detail")
        }.font(.system(size: 25, weight: .bold, design: .rounded)).padding(.top, -300)
            //.cardify().foregroundColor(Color.white).frame(width: 350)

        .navigationBarItems(trailing: updateButton)
    }
    
    
    var updateButton : some View {
        Button("Update") {
            self.showUpdateSheet = true
        }.sheet(isPresented: $showUpdateSheet) {
            practiceInputForm(isAddingPractice: false, cancelButton: AnyView(self.cancelButton), addButton: AnyView(self.finishUpdateButton))
          
        }
    }
    
    // button for adding new practice data to the database
      // takes user back to home page
      var finishUpdateButton : some View {
          Button("Done") {
              
              self.showUpdateSheet = false
          }
      }
      
      // button for canceling the action of adding practice record and return to home page
      // takes user back to home page
      // calls teh resetKeyStateVar functions
      var cancelButton: some View {
         Button("Cancel") {
             self.showUpdateSheet = false
         }
      }
    
}
