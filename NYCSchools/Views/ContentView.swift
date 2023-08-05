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
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.allSchools, id: \.self) { school in
                        let satsForSchool = viewModel.allSAT.filter { $0.dbn == school.dbn }
                        NavigationLink(destination: SchoolDetails(school: school, sats: satsForSchool)) {
                            VStack{
                                Text(school.name)
                            } .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            }
            .navigationTitle("NYC School List")
            .task {
               self.viewModel.getSchools()
               self.viewModel.getSAT() // Fetch SAT data
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
