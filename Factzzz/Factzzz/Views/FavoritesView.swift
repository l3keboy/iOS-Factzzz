//
//  FavoritesView.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import SwiftUI
import UIKit

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var savedFacts: FetchedResults<Fact>
    
    var body: some View {
        ZStack {
            List {
                Section {
                    ForEach(savedFacts) { fact in
                        HStack {
                            Text(fact.text ?? "Unknown fact")
                                .foregroundColor(Color("AccentColor"))
                        }.foregroundColor(Color("SecondaryColor"))
                    }
                    .onDelete { index in
                        removeFavorite(IndexSet: index)
                    }
                    .listRowBackground(Color("SecondaryColor").opacity(0.75).ignoresSafeArea())
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Favorites")
                        .foregroundColor(Color("SecondaryColor"))
                }
            }
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color("PrimaryColor"))
    }
    
    func removeFavorite(IndexSet: IndexSet) {
        for offset in IndexSet {
            let factToDelete = savedFacts[offset]
            PersistenceController.shared.container.viewContext.delete(factToDelete)
        }
        PersistenceController.shared.save()
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
