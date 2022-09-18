//
//  TVSmallView.swift
//  Runner
//
//  Created by Shaik Ahron on 18/09/22.
//

import WidgetKit
import SwiftUI

struct TWSmallView: View {
    private var travel: TravelData
    init(_travel: TravelData) {
        self.travel = _travel
    }

    var body: some View {
        VStack(alignment:.leading, spacing:10){
            Text("Upcoming trips")
                .font(Font.headline)
                .foregroundColor(Color.primary)

            Text(travel.travelDate).font(.subheadline)
                .foregroundColor(Color.secondary)

            HStack{
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.red)
                    .frame(width: 2, height: 37)
                Text(travel.place).font(.title).widgetURL(URL(string: "homeWidgetExample://message?message=\(travel.place)&homeWidget"))
            }
        }
    }
}



