//
//  FirstView.swift
//  suffixTask
//
//  Created by Никита Иванов on 19.06.2022.
//

import SwiftUI

struct FirstView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        
        VStack {
            HStack(spacing: 100){
                Button {
                    viewModel.inputText = ""
                } label: {
                    Text("Clear")
                }
                Button {
                    viewModel.inputText = Constants.defaultText
                } label: {
                    Text("Set default text")
                }

            }
            TextEditor(text: $viewModel.inputText)
                .border(.brown)
        }

   
        .padding()
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(viewModel: .init())
    }
}
