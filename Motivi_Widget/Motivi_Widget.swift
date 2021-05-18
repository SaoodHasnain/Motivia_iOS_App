//
//  Motivi_Widget.swift
//  Motivi Widget
//
//  Created by Hamza Shahbaz on 07/04/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Motivi_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("6")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }
            Text(entry.date , style: .time)
                .font(Font.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(.white)
        }
    }
    
}

@main
struct Motivi_Widget: Widget {
    let kind: String = "Motivi_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Motivi_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Motivi Widget")
        .description("This is an example widget.")
    }
}

struct Motivi_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Motivi_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
