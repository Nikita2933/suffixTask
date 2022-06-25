//
//  AscendingType.swift
//  suffixTask
//
//  Created by Никита Иванов on 24.06.2022.
//

enum AscendingType: CaseIterable {
    case asc, desc, top10
}

extension AscendingType {
    var title: String {
        switch self {
            case .asc:
                return "ASC"
            case .desc:
                return "DESC"
            case .top10:
                return "TOP10"
        }
    }
}
