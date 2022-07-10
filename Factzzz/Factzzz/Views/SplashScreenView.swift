//
//  SplashScreenView.swift
//  Factzzz
//
//  Created by Luke Hendriks on 10/07/2022.
//

import SwiftUI

struct SplashScreenView: View {
    @State var showingSplashScreen = true
    
    var body: some View {
        ZStack {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                
                Text("Factzzz")
                    .font(.custom("FredokaOne-Regular", size: 64))
            }.task {
                await splashScreenDelay()
            }
             
            if showingSplashScreen != true {
                FactzzzView()
            }
        }
        .foregroundColor(Color("SecondaryColor"))

    }
    
    private func splashScreenDelay() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        withAnimation {
            showingSplashScreen = false
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
