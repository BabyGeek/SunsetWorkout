//
//  TabBarView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var navigationCoordinator: NavigationCoordinator = .shared
    let tabs: [TabBarItem]
    var promotedItems: [TabBarItem]? = nil
    
    @Binding var selection: TabBarItem
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            tabBar
        }
        .padding()
        .overlay(
            Circle()
                .fill(Color(.systemCyan))
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            , alignment: .bottomLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemPurple))
                .clipShape(TabCurveShape(tabPoint: getCurvePoint() - 15))
        )
        .padding([.horizontal, .bottom])
    }
}

extension TabBarView {
    /// Tab bar item view
    /// - Parameter item: item of the tab bar presented
    /// - Returns: some View representing the tab item
    private func tabView(item: TabBarItem, forceShowText: Bool = false) -> some View {
        GeometryReader { proxy -> AnyView in
            let midX = proxy.frame(in: .global).midX
            DispatchQueue.main.async {
                if tabPoints.count <= tabs.count {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                    Button(action: {
                        switchToTab(tab: item)
                    }, label: {
                        item.symbol
                    })
                    .foregroundColor(Color(.systemBackground))
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 50)
    }
    
    /// promoted tab bar item view
    /// - Parameter item: item of the tab bar presented
    /// - Returns: some View representing the promoted tab item
    private func prometedTabView(item: TabBarItem, forceShowText: Bool = false) -> some View {
        GeometryReader { proxy -> AnyView in
            let midX = proxy.frame(in: .global).midX
            DispatchQueue.main.async {
                if tabPoints.count <= tabs.count {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                    Button(action: {
                        switchToTab(tab: item)
                    }, label: {
                        item.symbol
                    })
                    .foregroundColor(Color(.systemBackground))
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color(.systemCyan))
                    .clipShape(Circle())
                    .shadow(color: Color(.systemCyan), radius: 12)
                    .offset(y: -40)
            )
        }
        .frame(height: 50)
    }
    
    /// Tab bar display, go through each item and display a tabView and add tap gesture
    private var tabBar: some View {
        ForEach(tabs, id: \.self) { tab in
            if promotedItems?.contains(tab) ?? false {
                prometedTabView(item: tab)
            } else {
                tabView(item: tab)
                    .offset(y: selection == tab ? -10 : 0)
            }
        }
    }
    
    /// Allow swicthing between each tabs
    /// - Parameter tab: the tab to switch to
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
            selection = tab
            navigationCoordinator.selectionFromTabBarItem(selection)
        }
    }
    
    private func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 20
        }
        
        if let selectedIndex = tabs.firstIndex(of: selection) {
            return tabPoints[selectedIndex]
        }
        
        return tabPoints[0]
    }
}

#if DEBUG
struct TabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .dashboard,
        .create,
        .launch,
        .workouts,
        .history
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            TabBarView(tabs: tabs, promotedItems: [.launch], selection: .constant(.dashboard))
        }
    }
}
#endif
