//
//  BirthdayViewModel.swift
//  MVVMBasic
//
//  Created by 금가경 on 8/10/25.
//

import Foundation

final class BirthdayViewModel {
    
    var dateString: Observable<(year: String?, month: String?, day: String?)> = Observable(("0", "0", "0"))
    var resultText: Observable<String?> = Observable("")
    
    init() {
        dateString.bind { dateString in
            self.resultText.value = self.generateResultMessage(dateString)
        }
    }
    
    private func validateDateComponents(_ dateString: (year: String?, month: String?, day: String?)) throws (BirthdayValidationError){
        guard let yearText = dateString.year, let monthText = dateString.month, let dayText = dateString.day else {
            throw .nil
        }
        guard !yearText.isEmpty else {
            throw .noYear
        }
        guard let year = Int(yearText) else {
            throw .notNumber
        }
        guard (0...2025) ~= year else {
            throw .outOfRangeYear
        }
        guard !monthText.isEmpty else {
            throw .noMonth
        }
        guard let month = Int(monthText) else {
            throw .notNumber
        }
        guard (1...12) ~= month else {
            throw .outOfRangeMonth
        }
        guard !dayText.isEmpty else {
            throw .noDay
        }
        guard let day = Int(dayText) else {
            throw .notNumber
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
    
    private func generateResultMessage(_ dateString: (year: String?, month: String?, day: String?)) -> String? {
        do {
            try validateDateComponents(dateString)
            
            let (year, month, day) = unwrapDateComponents(dateString)
            let diff = calculateDayDifference(year: year, month: month, day: day)
            
            return formattedDayDifference(diff)
        } catch {
            return error.localizedDescription
        }
    }
    
    private func unwrapDateComponents(_ dateString: (year: String?, month: String?, day: String?)) -> (Int, Int, Int) {
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
