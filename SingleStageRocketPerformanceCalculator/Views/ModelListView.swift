//
//  ModelListView.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/22/21.
//

import SwiftUI

struct ModelListView: View {
    
    @StateObject private var modelListVM = ModelListViewModel()
    
    @StateObject var editModelVM = ExistingModelViewModel()
    
    @State private var isPresented: Bool = false
    
    
    private func deleteModel(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let model = modelListVM.models[index]
            
            // delete the model
            modelListVM.deleteModel(model: model)
            // get all models
            modelListVM.getAllModels()
        }
    }
    var body: some View {
        NavigationView {
        List {
            
            ForEach(modelListVM.models, id: \.id) {model in
 
                
//                Text(model.name)
                
//                NavigationLink("Show View",destination: TestView(model: model))
                
                NavigationLink(destination: ExistingModelDetailView(model: model )){
                    Text(model.name)
                }
                
            }.onDelete(perform: deleteModel)
        }// List
        .listStyle(PlainListStyle())
        .navigationTitle("Rocket Models")
        .navigationBarItems(leading: Button("Add Model") {
            isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            modelListVM.getAllModels()
        }, content: {
            AddModelDetailView()
            
        })
//        .embedInNavigationView()
        
        .onAppear(perform: {
            modelListVM.getAllModels()
        })
    }
    }
}

struct ModelListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModelListView()
        }
    }
}
