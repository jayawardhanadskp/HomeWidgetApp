//
//  HomeWidget.swift
//  HomeWidget
//
//  Created by I O N Groups Pvt Ltd on 2024-12-05.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), headlineTitle: "Loading...", configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let title = fetchHeadlineTitle()
        return SimpleEntry(date: Date(), headlineTitle: title, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate entries for each hour (or set this as needed)
        let currentDate = Date()
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let title = fetchHeadlineTitle() // Fetch the title from shared UserDefaults
            let entry = SimpleEntry(date: entryDate, headlineTitle: title, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

    // Function to fetch the title stored in shared UserDefaults (App Group)
    private func fetchHeadlineTitle() -> String {
        let userDefaults = UserDefaults(suiteName: "group.HomeWidget") // Use your app group identifier
        return userDefaults?.string(forKey: "headline_title") ?? "Not Set"
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let headlineTitle: String // Add headlineTitle to the entry
    let configuration: ConfigurationAppIntent
}

struct HomeWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Title:")  // Add a label for the title
                .font(.headline)
                .padding(.bottom, 5)
            
            Text(entry.headlineTitle)  // Display the headlineTitle fetched from the Flutter app
                .font(.title)
                .padding()

            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
        .padding()
    }
}

struct HomeWidget: Widget {
    let kind: String = "HomeWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            HomeWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

//#Preview(as: .systemSmall) {
//    HomeWidget()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
