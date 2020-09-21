//
//  NotesVC.swift
//  IniNotesV2
//
//  Created by IndratS on 19/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//

import UIKit
import CoreData

protocol NotesVCDelegate {
    func reloadData()
}


class NotesVC: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    let context = OperationNote().context
    let op = OperationNote()
    var validate = Validation()
    //    var objectID: String?
    var items: [Notes]?
    var selectedItem: [String:Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
        isEditedNote(data: selectedItem)
    }
    
    func isEditedNote(data: [String:Any]){
        if data.isEmpty {
            print("add new")
            updateButton.isHidden = true
            
        }else{
            noteButton.isHidden = true
            
            titleTF.text = data["title"] as? String
            descriptionTV.text = data["descriptionNote"] as? String
        }
    }
    
    
    //    func loadDataToTF(data: String?){
    //        //balikin objectid to
    //        if let objectIDURL = URL(string: data!) {
    //            let coordinator: NSPersistentStoreCoordinator = op.context.persistentStoreCoordinator!
    //            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL)!
    //
    //            //load data
    //
    //            do {
    //
    //                let data = try op.context.existingObject(with: managedObjectID)
    //                print(data.entity.properties)
    //
    //            }catch{
    //                print("Error Load Data from edit")
    //            }
    //
    //
    //        }
    //    }
    
    private func customUI(){
        descriptionTV.layer.borderWidth = 1
        descriptionTV.layer.cornerRadius = 10
        noteButton.layer.borderWidth = 1
        noteButton.layer.cornerRadius = 10
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    func checkData(){
        guard let title = titleTF.text, let descr = descriptionTV.text else {return}
        if (title.isEmpty || descr.isEmpty) {
            print("kosong")
            let alert = myAlert(title: "Error", message: "TextField Cannot Empty OR Text Too long")
            self.present(alert, animated: true)
            //            print("incorect title OR Description")
            return
            
        }else{
            print("isi")
            //
            saveData()
            
        }
        
        
        //        print(title.trimmingCharacters(in: .whitespaces))
        //        let isValidateTitle = self.validate.validateTitle(title: title)
        //        let isValidateDescription = self.validate.validateDescription(descriiption: descr)
        //
        //        if (isValidateTitle == false ){ //|| isValidateDescription == false
        //            let alert = myAlert(title: "Error", message: "TextField Cannot Empty OR Text Too long")
        //            self.present(alert, animated: true)
        //            print("incorect title OR Description")
        //            return
        //        }
        //
        //        // kalo semuanya bener
        //        if (isValidateTitle == true ){ // && isValidateDescription == true
        //            print("save")
        ////            saveData()
        //        }
        
    }
    
    @IBAction func buttonProssed(_ sender: UIButton) {
        checkData()
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        if let title = titleTF.text, let des = descriptionTV.text {
            let objectID = selectedItem["id"] as? NSManagedObjectID
            do {
                var note = try op.context.existingObject(with: objectID!)
                
                
                
            }catch{
                print("Errr")
            }
        }
    }
    
    
    
    func saveData(){
        if let title = titleTF.text, let descriptionM = descriptionTV.text {
            // make object Note
            let note = Notes(context: context)
            note.title = title
            note.descriptionNote = descriptionM
            note.addDate = Date()
            
            do {
                try context.save()
                print("save ok")
                // push notif to main menu
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            }catch{
                print("error save")
            }
        }
        
        // back to menu
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func myAlert(title: String, message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
    
}
