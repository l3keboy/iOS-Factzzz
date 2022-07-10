//
//  FactzzzViewModel.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import Foundation
import UIKit


class FactzzzViewModel: ObservableObject {
    @Published var retrievedFact: FactModel? = nil
    
    private let randomFactURL = URL(string: "https://uselessfacts.jsph.pl/random.json?language=en")
    private let session = URLSession.shared
    
    func getNewFact() {
        session.dataTask(with: randomFactURL!) { data, response, error in
            DispatchQueue.main.async {
                do {
                    self.retrievedFact = try JSONDecoder().decode(FactModel.self, from: data!)
                } catch {
                    print("Something went wrong!")
                }
            }
        }.resume()
    }
    
    func favoriteCurrentFact() {
        let context = PersistenceController.shared.container.viewContext

        let factToSave = Fact(context: context)
        factToSave.id = retrievedFact?.id
        factToSave.text = retrievedFact?.text
        
        PersistenceController.shared.save()
    }
}
