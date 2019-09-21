//
//  Array+indexOf.swift
//  MatchEmUpGameTest
//


import Foundation


extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
