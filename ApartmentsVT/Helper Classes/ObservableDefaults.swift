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
    
    @Published var accessToken: String? {
        didSet {
            UserDefaults.standard.set(self.accessToken, forKey: ObservableDefaults.accessTokenRoute)
        }
    }
    
    @Published var refreshToken: String? {
        didSet {
            UserDefaults.standard.set(self.refreshToken, forKey: ObservableDefaults.refreshTokenRoute)
        }
    }
    
    init() {
        self.host = UserDefaults.standard.string(forKey: ObservableDefaults.hostRoute)
        self.accessToken = UserDefaults.standard.string(forKey: ObservableDefaults.accessTokenRoute)
        self.refreshToken = UserDefaults.standard.string(forKey: ObservableDefaults.refreshTokenRoute)
    }
    
    static let hostRoute = "host"
    static let accessTokenRoute = "access_token"
    static let refreshTokenRoute = "refresh_token"
}
