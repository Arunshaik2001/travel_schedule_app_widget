//
//  TravelProvider.swift
//  Runner
//
//  Created by Shaik Ahron on 18/09/22.
//

import Foundation
import WidgetKit

private let widgetGroupId = "YOUR_APP_GROUP_ID"


struct TravelProvider: TimelineProvider {
    
    typealias Entry = TravelEntry
    
    func placeholder(in context: Context) -> TravelEntry {
        TravelEntry(date: Date(), traveList: [TravelData(place: "Mumbai", travelDate: "4/12/2022", icon: "mumbai-image")])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TravelEntry) -> ()) {
        let data = UserDefaults.init(suiteName:widgetGroupId)
        
        print(data?.string(forKey: "placesData") ?? "Delhi")
        
        let entry = TravelEntry(date: Date(), traveList: [TravelData(place: "Delhi", travelDate: "4/12/2022", icon: "delhi-image"),TravelData(place: "Mumbai", travelDate: "5/12/2022", icon: "mumbai-image"),TravelData(place: "Hyderabad", travelDate: "9/12/2022", icon: "hyderabad-image")])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}
