//
//  AddExpensesViewModel.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 02/04/2025.
//

import SwiftUI
import CoreData

@Observable final class AddExpensesViewModel {
    private let context = CoreDataStack.shared.context
    
    var expenses: [Expense] = []
    
    init() {
        getExpenses()
    }
    
    func insertExpense(name: String, amount: Double, date: Date) {
        let newItem = Expense(context: context)
        newItem.name = name
        newItem.amount = amount
        newItem.createdOn = date
        context.performSave()
        getExpenses()
    }
    
    func deleteExpense(at index: IndexSet.Element) {
        context.delete(expenses[index])
    }
    
    private func getExpenses() {
        expenses = context.fetch(Expense.self) ?? []
    }
}
