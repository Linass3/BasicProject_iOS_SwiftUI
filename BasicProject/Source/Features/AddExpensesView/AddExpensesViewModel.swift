//
//  AddExpensesViewModel.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 02/04/2025.
//

import SwiftUI

@Observable final class AddExpensesViewModel {
    private let expensesCoreData = CoreDataStack.shared
    private let context = CoreDataStack.shared.context
    
    var expenses: [Expense] = []
    
    init() {
        getExpenses()
    }
    
    func insertExpense(name: String) {
        let newItem = Expense(context: context)
        newItem.name = name
        context.performSave()
        getExpenses()
    }
    
    func deleteExpense(at index: IndexPath) {
        
    }
    
    private func getExpenses() {
        expenses = expensesCoreData.fetchExpenses()
    }
}
