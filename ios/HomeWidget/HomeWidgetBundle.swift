//
//  HomeWidgetBundle.swift
//  HomeWidget
//
//  Created by I O N Groups Pvt Ltd on 2024-12-05.
//

import WidgetKit
import SwiftUI

@main
struct HomeWidgetBundle: WidgetBundle {
    var body: some Widget {
        HomeWidget()
        HomeWidgetControl()
        HomeWidgetLiveActivity()
    }
}
