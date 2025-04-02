//
//  AddExpensesView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 02/04/2025.
//

import SwiftUI

struct AddExpensesView: View {
    @Environment(\.managedObjectContext) private var context
    
    @State private var viewModel = AddExpensesViewModel()
    @State private var name: String = .emptyString
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    

    
    var body: some View {
        VStack {
            TextField("Title", text: $name)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if isFormValid {
                        viewModel.insertExpense(name: name)
                        name = .emptyString
                    }
                }
                .padding()
            
            List {
                Section("Expenses") {
                    ForEach(viewModel.expenses) { expense in
                        Text(expense.name ?? "No Name")
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let item = viewModel.expenses[index]
                            CoreDataStack.shared.delete(item: item)
//                            viewModel.deleteExpense(at: index)
                        }
                    }
                }
            }
        }
        .navigationTitle("Add Expenses")

    }
}

#Preview {
    NavigationStack {
        AddExpensesView()
            .environment(\.managedObjectContext, CoreDataStack.shared.context)
    }
}
