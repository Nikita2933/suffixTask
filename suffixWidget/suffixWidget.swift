//
//  suffixWidget.swift
//  suffixWidget
//
//  Created by Никита Иванов on 19.06.2022.
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
        
        let threeSeconds: TimeInterval = 3
        var currentDate = Date()
        let endDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        while currentDate < endDate {
            
            let entry = SimpleEntry(date: currentDate, configuration: configuration)
            entries.append(entry)
            currentDate += threeSeconds
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let configuration: ConfigurationIntent
}

struct suffixWidgetEntryView : View {
    var entry: Provider.Entry
    
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        VStack {
            HStack {
                Link(destination: URL(string: Constants.link1)!, label: {
                    HStack {
                        Image("first")
                    }
                    .contentShape(Rectangle())
                    .frame(
                        width: family == .systemSmall ? 40 : 100,
                        height: family == .systemSmall ? 40 : 100,
                        alignment: .center
                    )
                    .border(.brown, width: 1)
   
                })
                Divider()
                Link(destination: URL(string: Constants.link2)!, label: {
                    HStack {
                        Image("second")
                    }
                    .contentShape(Rectangle())
                    .frame(
                        width: family == .systemSmall ? 40 : 100,
                        height: family == .systemSmall ? 40 : 100,
                        alignment: .center
                    )
                    .border(.brown, width: 1)
     
                })
                
            }
            .padding(.horizontal, 20)
        }

    }
    
}

@main
struct suffixWidget: Widget {
    let kind: String = "suffixWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            suffixWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct suffixWidget_Previews: PreviewProvider {
    static var previews: some View {
        suffixWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
