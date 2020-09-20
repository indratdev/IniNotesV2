//
//  NotesVC.swift
//  IniNotesV2
//
//  Created by IndratS on 19/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//

import UIKit

protocol NotesVCDelegate {
    func reloadData()
}

class NotesVC: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    
    let context = OperationNote().context
    var delegate: NotesVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
        
    }
    
    private func customUI(){
        descriptionTV.layer.borderWidth = 1
        descriptionTV.layer.cornerRadius = 10
        noteButton.layer.borderWidth = 1
        noteButton.layer.cornerRadius = 10
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    @IBAction func buttonProssed(_ sender: UIButton) {
        if let title = titleTF.text, let descriptionM = descriptionTV.text {
            // make object Note
            let note = Notes(context: context)
            note.title = title
            note.descriptionNote = descriptionM
            note.addDate = Date()

            do {
                try context.save()
                print("save ok")
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            }catch{
                print("error save")
            }
        }

        // back
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
