//
//  CoredataHelper.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/07/27.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {
    
    // MARK: -- addtask: 프로젝트 참조 저장함수 --
    func addTask(_ projectReference: String, context: NSManagedObjectContext) {
        
        let newTask = Task(context: context)
        
        newTask.id = UUID()
        newTask.projref = projectReference
        newTask.insertedDate = Date()
        
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
}
