//
//  Date+DateFormat.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/31/22.
//

import Foundation

extension Date {
    func abbreviatedUppercase() -> String {
        return self.formatted(date: .abbreviated, time: .omitted).uppercased()
    }
}
