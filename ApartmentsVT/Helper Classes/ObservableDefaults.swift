//
//  ObservableDefaults.swift
//  ponder
//
//  Created by Spencer Steadman on 10/31/23.
//

import Foundation
import Combine
import UIKit

class ObservableDefaults: ObservableObject {
    static var shared = ObservableDefaults()
    
    @Published var host: String? {
        didSet {
            UserDefaults.standard.set(self.host, forKey: ObservableDefaults.hostRoute)
        }
    }

    init() {
        self.host = UserDefaults.standard.string(forKey: ObservableDefaults.hostRoute)
    }
    
    static let hostRoute = "host"
}
