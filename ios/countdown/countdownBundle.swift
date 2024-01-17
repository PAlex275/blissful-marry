//
//  countdownBundle.swift
//  countdown
//
//  Created by Alex Petrisor on 08.01.2024.
//

import WidgetKit
import SwiftUI

@main
struct countdownBundle: WidgetBundle {
    var body: some Widget {
        countdown()
        countdownLiveActivity()
    }
}
