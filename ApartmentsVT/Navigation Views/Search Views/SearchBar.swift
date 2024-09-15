import SwiftUI
import SteadmanUI

struct SearchBar: View {
    @FocusState private var textFieldFocus: Bool // Manages the focus of the TextEditor
    
    @State private var isLoading = false
    @State private var textEditorHeight: CGFloat = 36
    @State private var searchQuery: String = "" // Search query state
    @State private var textFieldFocusAnimator = false // Animation state for focus
    
    let isEditing: Bool // Determines if editing should be toggled when appearing
    
    let clear: Color = Color.white.opacity(0.000001)
    
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .trailing) {
                    HStack {
                        Image(.magnifyingglass)
                            .font(.icon)
                            .foregroundStyle(Color.primaryText)
                        
                        ZStack(alignment: .topLeading) {
                            Text(searchQuery)
                                .font(.subtitle)
                                .padding(5)
                                .foregroundColor(clear)
                                .lineLimit(1...10)
                                .background(GeometryReader {
                                    clear.opacity(0.000001).preference(key: ViewHeightKey.self,
                                                           value: $0.frame(in: .local).size.height)
                                })
                            TextEditor(text: $searchQuery)
                                .focused($textFieldFocus) // Link TextEditor focus state
                                .font(.subtitle)
                                .frame(height: max(36, textEditorHeight))
                            if (searchQuery.isEmpty) {
                                VStack(alignment: .leading) {
                                    Text("Smart Search")
                                        .font(.subtitle)
                                        .fontWeight(.semibold)
                                    Text("Search for listings with natural language.")
                                        .font(.detail)
                                }
                            }
                        }.onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
                        DismissingKeyboardButton(textFieldFocus: $textFieldFocus)
                            .foregroundStyle(Color.primaryText)
                    }.padding(Screen.padding)
                        .frame(maxWidth: .infinity)
                        .background(.middleground)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .padding(.horizontal, Screen.padding)
                    
                    HStack {
                        Button {
                            isLoading.toggle()
                        } label: {
                                ZStack {
                                    if isLoading {
                                        ProgressView()
                                            .frame(height: 20)
                                            .foregroundStyle(Color.glassText)
                                    } else {
                                        Image(.arrow)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 20)
                                            .foregroundStyle(Color.glassText)
                                            .rotationEffect(searchQuery.isEmpty ? .degrees(-100) : .degrees(0))
                                            .animation(.navigationItemBounce, value: searchQuery.isEmpty)
                                    }
                                }.padding(.vertical, Screen.halfPadding + 1.5)
                                .padding(.horizontal, Screen.padding + 1.5)
                                .background(!isLoading ? Color.foreground : Color.middleground)
                                .clipShape(RoundedRectangle(cornerRadius: 100))
                        }.disabled(searchQuery.isEmpty || isLoading)
                            .opacity(searchQuery.isEmpty ? 0 : 1)
                            .animation(.navigationItemBounce, value: searchQuery.isEmpty)
                            .padding(.trailing, Screen.padding)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                textFieldFocus = isEditing // Focus the TextEditor if isEditing is true
            }
        }
        .onChange(of: textFieldFocus) { _, newValue in
            // When focus changes, trigger animations or logic
            if newValue {
                // Add any custom behavior on focus change
            }
            withAnimation(.navigationItemBounce) { textFieldFocusAnimator = newValue }
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
