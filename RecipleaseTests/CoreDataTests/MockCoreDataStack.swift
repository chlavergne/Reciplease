//
//  MockCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 21/10/2021.
//

import Foundation
import CoreData
@testable import Reciplease

class MockCoreDataStack: CoreDataStack {
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        
        let desc = NSPersistentStoreDescription()
        desc.type = NSInMemoryStoreType
        self.persistentContainer.persistentStoreDescriptions = [desc]
    }
}
