//
//  NavigationBar.swift
//  SteadmanUI
//
//  Created by Spencer Steadman on 4/25/23.
//
#if os(iOS)
import SwiftUI
import SteadmanUI

public struct NavigationItem: View {
    @Environment(\.index) var index
    @Environment(\.itemCount) var itemCount
    @ObservedObject public var bar = NavigationBar.shared
    @State var animation: CGFloat = 0
    @State public var icon: Image
    public var activeIcon: Image?
    public var name: String
    public var width: CGFloat
    
    public init(bar: NavigationBar = NavigationBar.shared, name: String, icon: Image, width: CGFloat = 100) {
        self.bar = bar
        self.name = name
        self.icon = icon
        self.width = width
    }
    
    public init(bar: NavigationBar = NavigationBar.shared, name: String, from: Image, to: Image, width: CGFloat = 100) {
        self.bar = bar
        self.name = name
        self.icon = from
        self.activeIcon = to
        self.width = width
    }
    
    public var body: some View {
        let isActive = bar.selectionIndex == index
        let foregroundColor: Color = NavigationBar.foregroundItemColor //isActive ? NavigationBar.foregroundItemColor : .black
        VStack {
            ZStack {
                if activeIcon != nil && isActive {
                    activeIcon
                        .animation(.snappy.delay(isActive ? 0 : 0.25), value: bar.selectionIndex)
                        .font(.navigationBarIcon)
                        .foregroundStyle(Color.navigationText)
                } else {
                    icon
                        .animation(.snappy.delay(isActive ? 0 : 0.25), value: bar.selectionIndex)
                        .font(.navigationBarIcon)
                        .foregroundStyle(Color.navigationText)
                }
            }.frame(height: 30)
            Text(name)
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .animation(.snappy.delay(isActive ? 0 : 0.25), value: bar.selectionIndex)
                .font(.navigationBar)
                .foregroundStyle(Color.navigationText)
        }.frame(height: NavigationBar.itemHeight)
            .padding([.leading, .trailing], 12)
            .padding([.top, .bottom], 8)
            .onAppear {
                animation = isActive ? 1 : 0
            }.onTapGesture {
                if bar.isChangeable {
                    Screen.impact(enabled: true)
                    bar.selectionIndex = index
                }
            }.onChange(of: bar.selectionIndex) { newValue in
                withAnimation(.navigationItemBounce) {
                    if bar.selectionIndex == index {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            withAnimation(.navigationItemBounce) {
                                animation = 1
                            }
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            withAnimation(.navigationItemBounce) {
                                animation = 0
                            }
                        }
                    }
                }
            }.onChange(of: animation) { newValue in
                bar.isChangeable = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    bar.isChangeable = true
                }
            }
    }
}

public class NavigationBar: ObservableObject {
    @ObservedObject public static var shared = NavigationBar()
    @Published public var isShowing = false
    @Published public var isChangeable = true
    @Published public var selectionIndex = 0
    @Published public var isViewBlurred = false
    public static var foregroundColor: Color = .blue.pastelLighten()
    public static var foregroundItemColor: Color = .blue
    public static var backgroundColor: Color = .white
    public static var cornerRadius: CGFloat = 50
    public static var iconFont: Font = .miniIcon
    public static var font: Font = .system(size: 14).bold()
    public static var height: CGFloat = 90
    public static var halfHeight: CGFloat = 58
    public static var itemHeight: CGFloat = 45
    public static var topPadding: CGFloat = 0
    public static var horizontalPadding: CGFloat = 0
}

public struct CustomNavigationBar<Content: View>: View {
    @ObservedObject var bar = NavigationBar.shared
    @ObservedObject var screen = Screen.shared
    @State var animation: CGFloat = 0
    public let items: [NavigationItem]
    public let content: Content
    //let label: LabelContent
    
    public init(items: [NavigationItem], @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.items = items
    }
    
    public var body: some View {
        ZStack {
            Extract(content) { views in
            // ^ from https://github.com/GeorgeElsham/ViewExtractor
                VStack {
                    ForEach(Array(zip(views.indices, views)), id: \.0) { index, view in
                        if bar.selectionIndex == index {
                            view
                        }
                    }
                }
            }

            VStack {
                ZStack {
                    HStack {
                        ForEach(Array(zip(items.indices, items)), id: \.0) { index, item in
                            item.environment(\.index, index)
                                .environment(\.itemCount, items.count)
                            
                            if (index < items.count - 1) {
                                Spacer()
                            }
                        }
                    }.padding(.horizontal, Screen.padding)
                        .padding(.top, NavigationBar.topPadding)
                }.frame(width: screen.width - Screen.padding * 2, height: NavigationBar.height)
                    .background(Color.navigationBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .padding(.top, (NavigationBar.height - NavigationBar.itemHeight) / -2)
                    .position(x: screen.halfWidth, y: screen.height - NavigationBar.halfHeight + screen.safeAreaInsets.bottom)
            }
            
        }.onAppear {
            bar.isShowing = true
        }.onDisappear {
            bar.isShowing = false
        }
    }
}

extension Animation {
    public static let navigationItemBounce: Animation = .interpolatingSpring(stiffness: 250, damping: 22).speed(1.25)
}

extension EnvironmentValues {
  public var index: Int {
    get { self[IndexKey.self] }
    set { self[IndexKey.self] = newValue }
  }
    public var itemCount: Int {
        get { self[ItemCountKey.self] }
        set { self[ItemCountKey.self] = newValue }
      }
}

private struct IndexKey: EnvironmentKey {
  public static let defaultValue = 0
}

private struct ItemCountKey: EnvironmentKey {
  public static let defaultValue = 0
}
#endif
