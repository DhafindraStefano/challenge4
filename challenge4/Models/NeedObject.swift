//
//  NeedObject.swift
//  challenge4
//
//  Created by Muhammad Dwiva Arya Erlangga on 19/08/25.
//

import SwiftData
import Foundation

@Model
class NeedObject {
    var id: UUID
<<<<<<< Updated upstream
    var needs: [String] 
=======
    var needs: [String]
>>>>>>> Stashed changes
    
    init(id: UUID = UUID(), needs: [String] = []) {
        self.id = id
        self.needs = needs
    }
}
