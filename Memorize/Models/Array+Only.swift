//
//  Array+Only.swift
//  Memorize
//
//  Created by Maksim Kim on 14.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
