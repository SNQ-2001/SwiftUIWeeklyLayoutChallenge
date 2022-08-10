//
//  Topic005.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/10.
//

import SwiftUI

/// <doc:Topic005>
public struct Topic005View: View {
    public init() {}
    
    public var body: some View {
        #if os(iOS) || os(macOS)
        if #available(iOS 15.0, macOS 12.0, *) {
            Topic005ContentView()
        } else {
            Text("Support for this platform is not considered.")
        }
        #else
        Text("Support for this platform is not considered.")
        #endif
    }
}

#if os(iOS) || os(macOS)
@available(iOS 15.0, macOS 12.0, *)
fileprivate struct Topic005ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GroupBox(label: VStack(alignment: .center, spacing: 3) {
                Text("#SwiftUIレイアウト一本勝負")
                    .fontWeight(.black)
                    #if os(iOS)
                    .font(.system(.title2, design: .monospaced))
                    #elseif os(macOS)
                    .font(.system(size: 32, design: .monospaced))
                    #endif
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.purple, .pink, .red, .orange, .yellow, .green, .cyan, .blue, .indigo, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                HStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Text("主なテーマ")
                        #if os(iOS)
                        .font(.headline)
                        #elseif os(macOS)
                        .font(.body)
                        #endif
                    Spacer()
                }
            }) {
                ForEach(topics) { topic in
                    GroupBox(topic.title) {
                        VStack(alignment: .leading, spacing: 3) {
                            ForEach(0..<topic.massages.count, id: \.self) { index in
                                Label {
                                    Text(topic.massages[index])
                                } icon: {
                                    Text("・")
                                }
                                .labelStyle(Topic005LabelStyle())
                            }
                        }
                    }
                }
            }
            .padding(.all, 15)
        }
    }
}
#endif

fileprivate struct Topic005LabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top, spacing: 3) {
            if #available(iOS 15.0, macOS 11.0, *) {
                configuration.icon
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                configuration.title
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                Spacer()
            } else {
                Text("Support for this platform is not considered.")
            }
        }
    }
}

fileprivate struct Topic005: Identifiable {
    let id = UUID()
    let title: String
    let massages: [LocalizedStringKey]
}

fileprivate let topics: [Topic005] = [
    .init(title: "001", massages: ["Stacksと`layputPriority(_:)`を使ってみる"]),
    .init(title: "002", massages: ["`NavigationLink`を使ってみる", "`List`を使ってみる"]),
    .init(title: "003", massages: ["`Form`を使ってみる", "`PickerとpickerStyle(_:)`を使ってみる", "`fixedSize(horizontal:vertical:)`を使ってみる"]),
    .init(title: "004", massages: ["`PrimitiveButtonStyle`を使ってみる"]),
]

struct Topic005View_Previews: PreviewProvider {
    static var previews: some View {
        Topic005View()
    }
}
