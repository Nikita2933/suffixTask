//
//  SecondView.swift
//  suffixTask
//
//  Created by Никита Иванов on 19.06.2022.
//

import SwiftUI

struct SecondView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $viewModel.ascending) {
                    ForEach(AscendingType.allCases, id: \.self) { type in
                        Text(type.title)
                    }
                } label: {
                    Text("")
                }
                
                List {
                    ForEach(viewModel.showingSuffixArray, id: \.self) { suffix in
                        HStack {
                            Text(suffix.title)
                            Spacer()
                            Text(suffix.count.description)
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .listStyle(.plain)
        .pickerStyle(.segmented)
        .searchable(text: $viewModel.searchText)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(viewModel: .init())
    }
}
