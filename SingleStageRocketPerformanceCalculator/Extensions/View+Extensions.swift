//
//  View+Extensions.swift
//  SingleStageRocketPerformanceCalculator
//
//  Created by Joseph Jung on 4/22/21.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView {self}
    }
}
