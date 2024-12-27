//
//  BookDetailsView.swift
//  EnglishAPP
//
//  Created by 赵静怡 on 2024/9/14.
//

import Foundation
import SwiftUI

struct BookDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Text("这是详情页面")
                .font(.title)
        }
        .navigationBarBackButtonHidden(true) // 隐藏默认的返回按钮
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // 返回上一视图
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("1-1") // 替换为自定义返回按钮图片
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35) // 设置图片大小
                }
            }
        }
    }
}
#Preview{
    BookDetailsView()
}
