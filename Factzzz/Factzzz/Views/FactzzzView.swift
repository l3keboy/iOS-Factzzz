//
//  ContentView.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import SwiftUI
import CoreData

struct FactzzzView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @ObservedObject private var factzzzViewModel = FactzzzViewModel()
    @State var showingShareSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                
                VStack {
                    Spacer()

                    Text("\(factzzzViewModel.retrievedFact?.text ?? "Press the 'Factzzz' button to generate your fact!")")
                        .multilineTextAlignment(.center)
                        .font(.custom("Fredoka-VariableFont_wdth,wght.ttf", size: 20))
                        .padding(.horizontal, 50)
                        .padding(.bottom, 16)
                                        
                    HStack {
                        Button("Factzzz") {
                            factzzzViewModel.getNewFact()
                        }
                            .frame(width: 125, height: 50, alignment: .center)
                            .background(Color("SecondaryColor"))
                            .opacity(0.75)
                            .cornerRadius(15)
                            .foregroundColor(Color("AccentColor"))
                            .font(.custom("Fredoka-VariableFont_wdth,wght.ttf", size: 20))

                        Button("\(Image(systemName: "square.and.arrow.up"))") {
                            if factzzzViewModel.retrievedFact?.text != nil {
                                showingShareSheet = true
                            }
                        }
                            .frame(width: 50, height: 50, alignment: .center)
                            .background(Color("SecondaryColor"))
                            .opacity(0.75)
                            .cornerRadius(15)
                            .foregroundColor(Color("AccentColor"))
                            .font(.custom("Fredoka-VariableFont_wdth,wght.ttf", size: 20))
                        
                        Button("\(Image(systemName: "star"))") {
                            if factzzzViewModel.retrievedFact?.text != nil {
                                factzzzViewModel.favoriteCurrentFact()
                            }
                        }
                            .frame(width: 50, height: 50, alignment: .center)
                            .background(Color("SecondaryColor"))
                            .opacity(0.75)
                            .cornerRadius(15)
                            .foregroundColor(Color("AccentColor"))
                            .font(.custom("Fredoka-VariableFont_wdth,wght.ttf", size: 20))
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showingShareSheet, content: { ShareViewController(itemsToShare: [factzzzViewModel.retrievedFact?.text]) })
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: FavoritesView()) {
                        Text(Image(systemName: "star"))
                    }
                }
            }
            .onAppear {
                if factzzzViewModel.retrievedFact?.text == nil {
                    factzzzViewModel.getNewFact()
                }
            }
        }
        .accentColor(Color("SecondaryColor"))
        .foregroundColor(Color("SecondaryColor"))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FactzzzView_Previews: PreviewProvider {
    static var previews: some View {
        FactzzzView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
