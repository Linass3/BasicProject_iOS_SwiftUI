//
//  AddExpensesView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 02/04/2025.
//

import SwiftUI

struct ExpensesStatusView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(AddExpensesViewModel.self) private var viewModel

    @State private var name: String = .emptyString
    
    private var isFormValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        List {
            Section("Expenses") {
                ForEach(viewModel.expenses) { expense in
                    Text(expense.name ?? "No Name")
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteExpense(at: index)
                    }
                }
            }
        }
        
        //        TextField("Title", text: $name)
        //            .textFieldStyle(.roundedBorder)
        //            .onSubmit {
        //                if isFormValid {
        //                    viewModel.insertExpense(name: name)
        //                    name = .emptyString
        //                }
        //            }
        //            .padding()
    }
}

#Preview {
    NavigationStack {
        ExpensesStatusView()
            .environment(\.managedObjectContext, CoreDataStack.shared.context)
    }
}
