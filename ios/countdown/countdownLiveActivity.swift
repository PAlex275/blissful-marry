//
//  countdownLiveActivity.swift
//  countdown
//
//  Created by Alex Petrisor on 08.01.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct countdownAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct countdownLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: countdownAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension countdownAttributes {
    fileprivate static var preview: countdownAttributes {
        countdownAttributes(name: "World")
    }
}

extension countdownAttributes.ContentState {
    fileprivate static var smiley: countdownAttributes.ContentState {
        countdownAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: countdownAttributes.ContentState {
         countdownAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: countdownAttributes.preview) {
   countdownLiveActivity()
} contentStates: {
    countdownAttributes.ContentState.smiley
    countdownAttributes.ContentState.starEyes
}
