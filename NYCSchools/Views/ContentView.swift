//
//  ContentView.swift
//  NYCSchools
//
//  Created by Syed Raza on 7/29/23.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel = SchoolViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.allSchools, id: \.id) { school in
                Text(school.school_name)
            }
        }
        .task(){
           await viewModel.getSchools()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
