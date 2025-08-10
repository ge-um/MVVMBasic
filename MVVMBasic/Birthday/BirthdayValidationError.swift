//
//  BirthdayValidationError.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/7/25.
//

import Foundation

enum BirthdayValidationError {
    case `nil`
    case notNumber
    case outOfRangeYear
    case outOfRangeMonth
    case outOfRangeDay
}

extension BirthdayValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .nil:
            return "nil입니다."
        case .notNumber:
            return "숫자를 입력해주세요"
        case .outOfRangeYear:
            return "0~2025 범위의 연도를 입력해주세요."
        case .outOfRangeMonth:
            return "1~12 범위의 월을 입력해주세요."
        case .outOfRangeDay:
            return "1~30 범위의 일을 입력해주세요."
        }
    }
}
