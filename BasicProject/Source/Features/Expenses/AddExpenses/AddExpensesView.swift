//
//  AddExpensesView.swift
//  BasicProject
//
//  Created by Linas Venclavičius on 03/04/2025.
//

import SwiftUI

enum ExpenseCategory: String, CaseIterable {
    case none
    case food
    case transportation
    case entertainment
    case health
}
struct AddExpensesView: View {
    @Environment(AddExpensesViewModel.self) private var viewModel
    
    @State private var name: String = .emptyString
    @State private var amount: Double = 0
    @State private var date = Date()
    @State private var selectedCategory: ExpenseCategory = .none
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("MainBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: geo.size.width, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Add Expense")
                        .font(.system(size: 50, weight: .bold))
                        .padding()
                    
                    Image("Wallet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    TextField("Expense name", text: $name)
                        .frame(maxWidth: geo.size.width - 40, maxHeight: 50)
                        .contentShape(Rectangle())
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                    
                    HStack(spacing: 20) {
                        Text("Amount")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("Amount", value: $amount, format: .currency(code: "EUR"))
                            .frame(width: 100)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    .frame(maxWidth: geo.size.width - 40, maxHeight: 50)
                    .contentShape(Rectangle())
                    .padding(.horizontal, 20)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                    
                    HStack(spacing: 20) {
                        Text("Category")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(ExpenseCategory.allCases, id: \.hashValue) { category in
                                Text(category.rawValue.capitalized)
                                    .tag(category)
                            }
                        }
                    }
                    .frame(maxWidth: geo.size.width - 40, maxHeight: 50)
                    .contentShape(Rectangle())
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .frame(maxWidth: geo.size.width - 40, maxHeight: 50)
                        .contentShape(Rectangle())
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                    
                    Button {
                        viewModel.insertExpense(name: name, amount: amount, date: date)
                    } label: {
                        Text("Add Expense")
                            .frame(maxWidth: geo.size.width - 40, maxHeight: 40)

                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AddExpensesView()
        .environment(AddExpensesViewModel())
}
