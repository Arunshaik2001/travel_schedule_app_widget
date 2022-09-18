//
//  TravelSchedule.swift
//  TravelSchedule
//
//  Created by Shaik Ahron on 18/09/22.
//

import WidgetKit
import SwiftUI

private let widgetGroupId = "YOUR_APP_GROUP_ID"

struct ExampleEntry: TimelineEntry {
    let date: Date
    let traveList: [TravelData]
}

struct TravelData{
    let place: String
    let travelDate: String
    let icon: String
}

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> ExampleEntry {
        ExampleEntry(date: Date(), traveList: [TravelData(place: "Mumbai", travelDate: "4/12/2022", icon: "mumbai-image")])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ExampleEntry) -> ()) {
        let data = UserDefaults.init(suiteName:widgetGroupId)
        
        print(data?.string(forKey: "placesData") ?? "Delhi")
        
        let entry = ExampleEntry(date: Date(), traveList: [TravelData(place: "Delhi", travelDate: "4/12/2022", icon: "delhi-image"),TravelData(place: "Mumbai", travelDate: "5/12/2022", icon: "mumbai-image"),TravelData(place: "Hyderabad", travelDate: "9/12/2022", icon: "hyderabad-image")])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}




struct TravelScheduleEntryView : View {
    var entry: Provider.Entry
    let data = UserDefaults.init(suiteName:widgetGroupId)

    @Environment(\.widgetFamily) var family
    
    var body: some View {
        
        switch family {
        case .systemSmall,.systemMedium:
            TWSmallView(_travel: entry.traveList.first!)
        default:
            TWView(_travelList: entry.traveList)
        }
    
    }
}

@main
struct TravelSchedule: Widget {
    let kind: String = "TravelSchedule"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TravelScheduleEntryView(entry: entry)
        }
        .configurationDisplayName("My Travel App Widget")
        .description("This is a Travel App widget.")
    }
}

struct TravelSchedule_Previews: PreviewProvider {
    static var previews: some View {
        TravelScheduleEntryView(entry: ExampleEntry(date: Date(),traveList: [TravelData(place: "Mumbai", travelDate: "4/12/2022", icon: "mumbai-image"),TravelData(place: "Mumbai", travelDate: "4/12/2022", icon: "mumbai-image"),TravelData(place: "Mumbai", travelDate: "4/12/2022", icon: "mumbai-image")]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


