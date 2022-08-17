//
//  Topic006.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/17.
//

import SwiftUI

/// <doc:Topic006>
public struct Topic006View: View {
    public init() {}
    
    public var body: some View {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            Topic006ContentView()
        } else {
            Text("Support for this platform is not considered.")
        }
        #else
        Text("Support for this platform is not considered.")
        #endif
    }
}

#if os(iOS)
@available(iOS 15.0, *)
fileprivate struct Topic006ContentView: View {
    private let paddingLength: CGFloat = 16
    @State var isNewAlert: Bool = false
    @State var isAddVoiceAlert: Bool = false
    @State var isAddImageAlert: Bool = false
    @State var offset: CGSize = .zero
    @State var isDragging = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Text("後ろに位置するView")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            Menu {
                Button(action: {
                    isNewAlert = true
                }) {
                    Text("新規作成")
                    Image(systemName: "square.and.pencil")
                }
                Button(action: {
                    isAddImageAlert = true
                }) {
                    Text("画像を追加")
                    Image(systemName: "photo")
                }
                Button(action: {
                    isAddVoiceAlert = true
                }) {
                    Text("音声を追加")
                    Image(systemName: "mic.badge.plus")
                }
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(isNewAlert ? Color.gray : isAddVoiceAlert ? Color.gray : isAddImageAlert ? Color.gray : Color.blue)
                    .clipShape(Circle())
            } primaryAction: {
                isNewAlert = true
            }
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = CGSize(width: value.location.x - 25, height: value.location.y - 25)
                        isDragging = true
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .padding(.all, paddingLength)
            .alert("新規作成", isPresented: $isNewAlert) { }
            .alert("音声を追加", isPresented: $isAddVoiceAlert) { }
            .alert("画像を追加", isPresented: $isAddImageAlert) { }
        }
    }
}
#endif

struct Topic006View_Previews: PreviewProvider {
    static var previews: some View {
        Topic006View()
    }
}
