//
//  StringSequence.swift
//  suffixTask
//
//  Created by Никита Иванов on 24.06.2022.
//

struct StringSequence: IteratorProtocol, Sequence {

    let sequence: String
    var offset: String.Index

    init(sequence: String) {
        self.sequence = sequence
        self.offset = sequence.endIndex
    }

    mutating func next() -> Substring? {
        guard offset > sequence.startIndex else { return nil }
        offset = sequence.index(before: offset)
        return sequence.suffix(from: offset)
    }
}
