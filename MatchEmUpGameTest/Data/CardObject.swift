//
//  CardObject.swift
//  MatchEmUpGameTest
//


import Foundation
import UIKit

class CardObject: Equatable {

    var image : UIImage?
    var isHidden = true
    
 
    init(image: UIImage? = nil, isHidden:Bool = true) {
  
        self.image = image
        self.isHidden = isHidden
    }
    
    static func ==(lhs: CardObject, rhs: CardObject) -> Bool {
        return lhs === rhs 
    }
}
