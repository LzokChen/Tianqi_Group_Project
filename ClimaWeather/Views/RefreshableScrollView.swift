//
//  RefreshableScrollView.swift
//  ClimaWeather
//
//  Created by Mingyu Liu on 2022-08-12.
//

import SwiftUI
import SDWebImageSwiftUI

public struct RefreshableScrollView<Content: View>: View {
    var content: Content
    var onRefresh: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    public init(content: @escaping () -> Content, onRefresh: @escaping () -> Void) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var imageURL:String{
        if colorScheme == .dark {
            return "https://images.unsplash.com/photo-1598046147932-c78b6d9c0905?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHN0YXJyeSUyMHNreXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
        } else {
            return "https://images.unsplash.com/photo-1522441815192-d9f04eb0615c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80"
        }
    }
    
    public var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            onRefresh()
        }
        .background(WebImage(url: URL(string: imageURL))
                    
            .onSuccess { image, data, cacheType in
            }
            .resizable()
            .placeholder(Image(systemName: "photo"))
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
            .scaledToFill())
    }
}
