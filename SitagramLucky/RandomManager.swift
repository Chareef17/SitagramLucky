//
//  RandomManager.swift
//  SitagramLucky
//
//  Created by Chareef on 18/11/2566 BE.
//

import UIKit

class RandomManager: NSObject {
    static let shared: RandomManager = RandomManager()
    let key_CurrentRate: String = "key_CurrentRate"

    var currentRate: Float {
        get {
            if UserDefaults.standard.float(forKey: key_CurrentRate) > 0 {
                return UserDefaults.standard.float(forKey: key_CurrentRate)
            }
            return 0.6
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key_CurrentRate)
            UserDefaults.standard.synchronize()
        }
    }
}
