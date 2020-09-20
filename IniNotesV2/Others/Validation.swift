//
//  Validation.swift
//  IniNotesV2
//
//  Created by IndratS on 20/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//

import Foundation

class Validation {
    
    func validateTitle(title: String) -> Bool{
        // mininum 3 char, max: 50
        let titleRegex = "\\w{3,50}$"
        let trimmedString = title.trimmingCharacters(in: .whitespaces)
        let validateTitle = NSPredicate(format: "SELF MATCHES %@", titleRegex)
        let isValidate = validateTitle.evaluate(with: trimmedString)
        return isValidate
    }
    
    func validateDescription(descriiption: String) -> Bool {
        // minumum 3 char, max: 100000
        let descriptionRegex = "\\w{3,1000000}$"
        let trimmedString = descriiption.trimmingCharacters(in: .whitespaces)
        let validateDescription = NSPredicate(format: "SELF MATCHES %@", descriptionRegex)
        let isValidate = validateDescription.evaluate(with: trimmedString)
        return isValidate
    }
    
}
