//
//  RootTabView.swift
//  suffixTask
//
//  Created by Никита Иванов on 19.06.2022.
//

import SwiftUI

struct RootTabView: View {
    @State var selection = TabViewSelection.first
    @EnvironmentObject var viewModel: ViewModel
    @State var linkOne: Bool = false
    @State var linkTwo: Bool = false
    var body: some View {
        TabView (selection: $selection) {
            FirstView(viewModel: viewModel)
                .tabItem {
                    Image("first")
                        .renderingMode(.template)
                        .foregroundColor( selection == .second ? .white : .black)
                }
                .tag(TabViewSelection.first)
            SecondView(viewModel: viewModel)
                .tabItem {
                    Image("second")
                        .renderingMode(.template)
                        .foregroundColor( selection == .second ? .white : .black)
                }
                .tag(TabViewSelection.second)
        }
        .onOpenURL(perform: { url in
            if url == URL(string:Constants.link1)! {
                selection = .first
            } else if url == URL(string:Constants.link2)! {
                selection = .second
            }
        })
        
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
