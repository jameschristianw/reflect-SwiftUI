//
//  ContentView.swift
//  Shared
//
//  Created by James Christian Wira on 26/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var reflectionVM: ReflectionViewModel
    
    var body: some View {
        
        if reflectionVM.dbLink == nil {
            OnBoadingView()
        } else {
            ReflectionView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ReflectionViewModel())
    }
}
