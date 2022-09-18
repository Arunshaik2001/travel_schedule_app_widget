//
//  TSMedium.swift
//  Runner
//
//  Created by Shaik Ahron on 18/09/22.
//

import SwiftUI
import WidgetKit

struct TWView: View {
    private var travelList: [TravelData]
    init(_travel: [TravelData]) {
        self.travelList = _travel
    }

    var body: some View {
        VStack{
            ForEach(travelList,id: \.place){item in
                VStack.init(alignment: .center, spacing: 5, content: {
                    Image(item.icon).resizable().cornerRadius(5).frame(width: 50, height: 50, alignment: .center)
                    Text(item.place).bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(item.travelDate)
                        .font(.body)
                        .widgetURL(URL(string: "homeWidgetExample://message?message=\(item.place)&homeWidget"))
                }
                ).overlay( Divider()
                    .frame(maxWidth: .infinity, maxHeight:1)
                        .background(Color.black), alignment: .top).frame(
                    minWidth: 0,
                    maxWidth: .infinity
                  )
            }
        }
    }
}


