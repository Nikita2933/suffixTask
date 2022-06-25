//
//  StringIterator.swift
//  suffixTask
//
//  Created by Никита Иванов on 24.06.2022.
//

struct StringIterator {
    let sequence: String

    func makeIterator() -> StringIterator {
        StringIterator(sequence: sequence)
    }
}
