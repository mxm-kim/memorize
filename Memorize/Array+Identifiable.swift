//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Maksim Kim on 14.06.2020.
//  Copyright © 2020 Bellerage. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in self.indices {
            if self[index].id == matching.id {
                return index
            }
        }

        return nil
    }
}
