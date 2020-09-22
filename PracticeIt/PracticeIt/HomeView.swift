//
//  ContentView.swift
//  PracticeIt
//
//  Created by Yichi Zhang  on 9/4/20.
//  Copyright © 2020 Yichi Zhang . All rights reserved.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    // Stores data for user option in picker. 
    @ObservedObject var Data = userOptionData()
    
    // Storing data fetched from database.
    @State var practices : [NSManagedObject] = []
    
    // Key @State vars that record data for new practice entry before
    // being added to the database. Reset when they are added to DB or user
    // cancel adding practice entry
    
    // For implement DynamicTextBox
    @State var textHeight: CGFloat = 0
    
    // For implement DynamicTextBox
    // Dynamically adjust the textField height based on the text height
    var textFieldHeight: CGFloat {
      let minHeight: CGFloat = 30
      let maxHeight: CGFloat = 70
      
      if textHeight < minHeight {
          return minHeight
      }
      
      if textHeight > maxHeight {
          return maxHeight
      }
      
      return textHeight
    }
    
    // Contains all the view elements
    var body: some View {
        Group {
            NavigationView {
                VStack(alignment: .leading) {
                    List {
                        // .reversed() reorders the data array to the desired order
                        ForEach(practices.reversed(), id: \.self) { practice in
                            NavigationLink(destination: practiceDetailView(practice: practice)) {
                                practiceView(practice: practice)
                            }
                        }.onDelete(perform: self.deletePracticeRecord)
                    }
                    .navigationBarTitle("PracticeIt")
                    .navigationBarItems(leading: EditButton(), trailing: addPracticeButton)
                }.onAppear() {
                    // whenever this VStacks show up on the Home page, loads / reload data
                    self.loadPracticeData()
                }
            }
        }
    }
    
    // Bool vars for monitoring the pop-up status of the sheet used in
    // the addPracticeButton function
    @State private var showAddPracticePage = false
    
    // Button for adding a new practice record
    // Will pop a sheet showing a bunch of stuff that user needs to enter
    var addPracticeButton: some View {
        Button("Add practice") {
            self.showAddPracticePage = true
        }.sheet(isPresented: $showAddPracticePage) {
            self.practiceRecordInputForm(isAddingPractice: true, cancelButton: AnyView(self.cancelButton), addButton: AnyView(self.finishAddPracticeButton))
        }
    }
    
    // MARK: Elements for HomeView
    
    //show a form for creating a new practice record
    func practiceRecordInputForm(isAddingPractice : Bool, cancelButton : AnyView, addButton : AnyView) -> some View {
        return Group {
        
         NavigationView {
            Form {
                Picker("Select Practice Type:", selection: $Data.newType) {
                    ForEach(self.Data.practiceType, id: \.self) { type in
                        Text("\(type)").tag(type)
                    }
                }.padding(.top, 20).padding(.bottom, 20)
                
                Picker("Choose Session Length (in minutes)", selection: $Data.newLength) {
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
        .navigationBarTitle(isAddingPractice ? "Add New Record" : "Update Record")
        .navigationBarItems(leading: cancelButton, trailing: addButton)
        }
        }
    }
    
    // button for adding new practice data to the database
    // takes user back to home page
    var finishAddPracticeButton : some View {
        Button("Done") {
            self.addNewPracticeData()
            self.showAddPracticePage = false
        }
    }
    
    // button for canceling the action of adding practice record and return to home page
    // takes user back to home page
    // calls teh resetKeyStateVar functions
    var cancelButton: some View {
       Button("Cancel") {
           self.showAddPracticePage = false
           self.resetKeyStateVariables()
       }
    }
    
    func isDisabled() -> Bool {
        return Data.newType.count == 0
    }
    
    // Slider view for setting BPM
    func setBPMSlider() -> some View {
        VStack {
            Slider(value: $Data.newBPM, in: 40...250, step: 1)
                .padding(.leading, 20).padding(.trailing, 20)
            Text(Data.newBPM.removeZerosFromEnd())
            .font(.system(size: 20, weight: .heavy, design: .default))
        }.padding(.bottom, 20)
    }
    
    // add New Pattern to the Database
    func addNewPracticeData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Practice", in: managedContext)!
        
        let newPractice = NSManagedObject(entity: entity, insertInto: managedContext)
                
        newPractice.setValue($Data.newBPM.wrappedValue, forKey: "bpm")
        newPractice.setValue($Data.newDetail.wrappedValue, forKey: "detail")
        newPractice.setValue($Data.newLength.wrappedValue, forKey: "sessionLength")
        newPractice.setValue($Data.newType.wrappedValue, forKey: "type")
        
        do {
            try managedContext.save()
            print("Saved successfully -- \($Data.newType.wrappedValue)")
            self.loadPracticeData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        // reset @state variables so user don't add them repeatly
        self.resetKeyStateVariables()
    }
    
    // load practices data from dataBase.
    // Data is stored in the @State var practices at the top of the file.
    func loadPracticeData() {
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
           return
       }
       
       let managedContext = appDelegate.persistentContainer.viewContext
       
       let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Practice")
        
       do {
        practices = try managedContext.fetch(fetchRequest)
       } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
       }
    }
    
    func updatePracticeEntry(id: UUID) {
        //  get the id of practice record
        //  set Key state vars to the data of practice record
        // prompt a form in which allow user to enter new data
        // update the record by id with key state vars
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Practice")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        // MARK: what is predicate????
        
        do {
            let targetedPractice = try managedContext.fetch(fetchRequest)
            
            let practiceUpdate = targetedPractice[0] as! NSManagedObject
            practiceUpdate.setValue(Data.newType, forKey: "type")
            practiceUpdate.setValue(Data.newBPM, forKey: "bpm")
            practiceUpdate.setValue(Data.newDetail, forKey: "detail")
            practiceUpdate.setValue(Data.newLength, forKey: "sessionLength")
            do {
                try managedContext.save()
                print("Saved Successfully")
            } catch let error as NSError {
                print("Could not update. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deletePracticeRecord(at offsets: IndexSet) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
       
        let managedContext = appDelegate.persistentContainer.viewContext     
     
       // MARK: what is predicate????
       do {
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Practice")
          var practicesData = try managedContext.fetch(fetchRequest)
          practicesData.reverse()
          for index in offsets {
             let objectDelete = practicesData[index]
             managedContext.delete(objectDelete)
          }
        
          do {
               try managedContext.save()
               print("Deleted Successfully")
           } catch let error as NSError {
               print("Could not delete. \(error), \(error.userInfo)")
           }
       } catch let error as NSError {
           print("Could not fetch. \(error), \(error.userInfo)")
       }
        loadPracticeData()
        print(practices.count)
    }
    
    // reset important String @State variables that are about to being added to database 
    func resetKeyStateVariables() {
        Data.newType = ""
        Data.newDetail = ""
        Data.newLength = ""
        Data.newBPM = 0
    }
}


