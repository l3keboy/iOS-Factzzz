//
//  Persistence.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        for _ in 0..<10 {
            let fact = Fact(context: controller.container.viewContext)
            fact.id = UUID()
            fact.text = "Preview fact"
        }

        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Factzzz")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
