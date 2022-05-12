//
//  Entry+CoreDataProperties.swift
//  daily-journal
//
//  Created by Patricia Jamriskova on 09.05.2022.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entry : Identifiable {

    
    func month() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        //nsdateformatter.com
        
        if let dateToBeFormatted = date {
            let month = dateFormatter.string(from: dateToBeFormatted)
                                             return month.uppercased()
        }
        return ""
    }
    
    
    
    func day() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        //nsdateformatter.com
        
        if let dateToBeFormatted = date {
            let day = dateFormatter.string(from: dateToBeFormatted)
                                             return day
        }
        return ""
    }
}
