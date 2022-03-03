//
//  String+DateFormat.swift
//  CriticalMovies
//
//  Created by Phillip Baker on 1/31/22.
//

import Foundation

extension String {
    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y/MM/d"
        let date = dateFormatter.date(from: self)
        guard let formattedString = date?.formatted(date: .abbreviated, time: .omitted) else { return "Unknown Date" }
        return formattedString
    }
}
