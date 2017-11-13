//
//  Chat.swift
//  Clerkie Project
//
//  Created by Jing on 2017/11/11.
//  Copyright © 2017年 Jing. All rights reserved.
//

import UIKit
import CoreData

class Chat: NSManagedObject {    
    static func findOrCreateChat(matching userId: String, with robotId: String, in context: NSManagedObjectContext) throws -> Chat {
        let request: NSFetchRequest<Chat> = Chat.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %@ and robotId = %@", userId, robotId)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Chat.findOrCreateChat data inconsistency!")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let chat = Chat(context: context)
        chat.userId = userId
        chat.robotId = robotId
        return chat
    }
}
