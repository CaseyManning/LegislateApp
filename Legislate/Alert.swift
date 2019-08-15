//
//  Alert.swift
//  Legislate
//
//  Created by Casey Manning on 8/15/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

struct Alert {
    
    var title: String
    var description: String
    var shouldOccur: () -> Bool
    
    init(shouldOccur: @escaping () -> Bool, title: String, description: String) {
        self.title = title
        self.description = description
        self.shouldOccur = shouldOccur
    }
    
    static func addAlerts() {
        Civilization.shared.alerts.append(Alert(shouldOccur: {Civilization.shared.turn == 5}, title: "New Social Class", description: "Previously,  everyone in your society except the ruling class worked the fields to sustain themselves. However, increased agricultural production allows some people to specialize, becoming artisans. Artisans are normally wealthier than farmers, and live in more urban areas."))
    }
}
