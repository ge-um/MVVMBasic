//
//  BirthdayViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

import Foundation

final class BirthdayViewModel {
    var dateString: (year: String?, month: String?, day: String?) = ( "0",  "0", "0") {
        didSet {
            resultText = generateResultMessage()
        }
    }
    
    var resultText: String? = "" {
        didSet {
            onResultButtonTapped?()
        }
    }
    
    var onResultButtonTapped: (() -> Void)?
    
    private func validateDateComponents() throws (BirthdayValidationError){
        guard let yearText = dateString.year, let monthText = dateString.month, let dayText = dateString.day else {
            throw .nil
        }
        guard let year = Int(yearText), let month = Int(monthText), let day = Int(dayText) else {
            throw .notNumber
        }
        guard (0...2025) ~= year else {
            throw .outOfRangeYear
        }
        guard (1...12) ~= month else {
            throw .outOfRangeMonth
        }
        guard (1...31) ~= day else {
            throw .outOfRangeDay
        }
    }
    
    private func calculateDayDifference(year: Int, month: Int, day: Int) -> Int {
        let calendar = Calendar.current
        
        let startDate = Date()
        let endDate = calendar.date(from: DateComponents(year: year, month: month, day: day))!
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        return components.day!
    }
    
    private func generateResultMessage() -> String? {
        do {
            try validateDateComponents()
            
            let (year, month, day) = unwrapDateComponents()
            let diff = calculateDayDifference(year: year, month: month, day: day)
            
            return formattedDayDifference(diff)
        } catch {
            return error.localizedDescription
        }
    }
    
    private func unwrapDateComponents() -> (Int, Int, Int) {
        let year = Int(dateString.year!)!
        let month = Int(dateString.month!)!
        let day = Int(dateString.day!)!
        return (year, month, day)
    }
    
    private func formattedDayDifference(_ diff: Int) -> String {
        let formattedDiff = diff < 0 ? "D\(diff)" : "D+\(diff)"
        return "\(formattedDiff)일째 입니다."
    }
}
