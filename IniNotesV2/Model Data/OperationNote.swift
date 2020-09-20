//
//  OperationNote.swift
//  IniNotesV2
//
//  Created by IndratS on 19/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//

import UIKit
import CoreData

struct OperationNote {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    public func loadData() -> [Notes]? {
        let data: [Notes]?
        do {
            data = try context.fetch(Notes.fetchRequest())
            return data
        }catch let err{
            print(err)
            return nil
        }
    }
    
    
}
