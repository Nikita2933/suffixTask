//
//  ViewModel.swift
//  suffixTask
//
//  Created by Никита Иванов on 19.06.2022.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {
    @Published var inputText: String = ""
    var inputSearchArray: [Suffix] = []
    @Published var searchText: String = ""
    @Published var showingSuffixArray: [Suffix] = []
    @Published var ascending: AscendingType = .asc
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $ascending
            .receive(on: RunLoop.main)
            .sink { _ in
                self.ascend()
            }
            .store(in: &subscriptions)
        $inputText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] inputText in
                guard let strongSelf = self else { return }
                strongSelf.updateSuffixArray()
            }
            .store(in: &subscriptions)
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] search in
                guard let strongSelf = self else { return }
                strongSelf.updateSuffixArray()
            }
            .store(in: &subscriptions)
    }
    
    func updateSuffixArray() {
        var dictionarySuffix: [String: Int] = [:]
        var updateSuffixArray: [Suffix] = []
        inputText
            .components(separatedBy: .whitespacesAndNewlines)
            .lazy
            .map { StringSequence(sequence: String($0)) }
            .forEach { text in
                text.filter { $0.count >= 3 } .forEach { substring in
                    dictionarySuffix[substring.lowercased(), default: 0] += 1
                }
            }
        
        dictionarySuffix.forEach { title, count in
            if title.count >= 3 {
                updateSuffixArray.append(.init(title: title, count: count))
            }
        }
        
        if searchText.count >= 2 {
            updateSuffixArray = updateSuffixArray.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        inputSearchArray = updateSuffixArray
        ascend()
    }
    
    func ascend() {
        switch ascending {
            case .asc:
                showingSuffixArray = inputSearchArray.sorted(by: { $0.title < $1.title })
            case .desc:
                showingSuffixArray = inputSearchArray.sorted(by: { $0.title > $1.title })
            case .top10:
                showingSuffixArray = Array(inputSearchArray.filter { $0.count > 3 }.prefix(10))
        }
    }
}
