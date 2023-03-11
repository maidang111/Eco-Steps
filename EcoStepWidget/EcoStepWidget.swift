//
//  EcoStepWidget.swift
//  EcoStepWidget
//
//  Created by Mai Dang on 3/11/23.
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

        // Generate a timeline consisting of twenty-four entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 24 {
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

struct EcoStepWidgetEntryView : View {
    var calculation : Calculations
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Weekly")
                .foregroundColor(Color("AccentColor 1"))
            Text("\(convertStepstoCo2(steps: calculation.totalSteps)) g")
                .foregroundColor(Color("AccentColor 1"))
                .padding(.bottom)
            Text("Overall")
                .foregroundColor(Color("AccentColor 1"))
            Text("\(convertStepstoCo2(steps: calculation.totalSteps)) g")
                .foregroundColor(Color("AccentColor 1"))

        }
    }
}

struct EcoStepWidget: Widget {
    let kind: String = "EcoStepWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EcoStepWidgetEntryView(calculation: Calculations(), entry: entry)
        }
        .configurationDisplayName("Eco Step Widget")
        .description("This widget records how much CO2 you prevented by walking instead of driving")
    }
}

struct EcoStepWidget_Previews: PreviewProvider {
    static var previews: some View {
        EcoStepWidgetEntryView(calculation: Calculations() , entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
