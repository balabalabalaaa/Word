//
//  MessageView.swift
//  WordApp
//
//  Created by 赵静怡 on 2024/9/20.
//

import Foundation
import SwiftUI

struct MessageView: View {
    var body: some View {
        GeometryReader{geometry in
        ZStack{
            Image("Messageviewbackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
           
                VStack{
                    button01()//返回按钮
                        .position(x: geometry.safeAreaInsets.leading + 20, y: geometry.safeAreaInsets.top-80 )
                    image01()//图像
                        .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top-120)
                    HStack{
                        name()//姓名
                        gender()//性别
                    }.position(x: geometry.size.width / 2+10, y: geometry.safeAreaInsets.top-160)
                    huiyuan()//会员用户
                        .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top-220)
                    HStack(spacing:70){
                        button02()//收藏
                        button03()//错题本
                        button04()//我的词书
                    }
                    .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top-250)
                    textline(text01: "busfu", text02:"我爱背单词")//账号
                        .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top-240)
                    buttonexit()//编辑资料
                        .position(x: geometry.size.width / 2+100, y: geometry.safeAreaInsets.top-260)
                    buttonstop()//退出登录
                        .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top-100)
                }
            }
        }
    }
}

struct button01: View {
    var body: some View {
        Button(action: {
            
        }) {
            Image("1-1")
        }
        .padding(.top, 20)
        .padding(.leading, 20)
    }
}

struct button02: View {
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                Image("1-4")
                Text("收藏")
            }
        }
    }
}

struct button03: View {
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                Image("1-5")
                Text("错题本")
            }
        }
    }
}

struct button04: View {
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                Image("1-6")
                Text("我的词书")
            }
        }
    }
}

struct image01: View {
    var body: some View {
        Image("1-2")
    }
}

struct name: View {
    var body: some View {
        Text("大帅哥")
    }
}

struct gender: View {
    var body: some View {
        Image("1-3")
    }
}

struct huiyuan: View {
    var body: some View {
        Image("1-7")
            .resizable() // 允许图片调整大小
            .aspectRatio(contentMode: .fit) // 保持宽高比
            .frame(width: 120, height: 50) // 设置图片大小
    }
}
struct buttonstop: View {
    var body: some View {
        Button(action: {
            // 按钮点击动作
            print("退出登录按钮被点击")
        }) {
            Text("退出登录")
                .foregroundColor(.red) // 设置文本颜色为红色
                .font(.system(size: 25))
                .frame(width: 320, height: 50, alignment: .center) // 设置按钮大小
                .background(Color.white) // 设置背景颜色为蓝色
                .cornerRadius(15) // 设置圆角半径
                .padding() // 可选：如果需要在按钮周围添加外边距
        }
        .buttonStyle(PlainButtonStyle()) // 使用 PlainButtonStyle 避免默认样式
    }
}
struct buttonexit: View {
    var body: some View {
        Button(action: {
            // 按钮点击动作
            print("编辑资料按钮被点击")
        }) {
            Text("编辑资料")
                .foregroundColor(.black) // 设置文本颜色为红色
                .font(.system(size: 20))
                .frame(width: 120, height: 40, alignment: .center) // 设置按钮大小
                .background(Color.white) // 设置背景颜色为白色
                .cornerRadius(10) // 设置圆角半径
                .padding() // 可选：如果需要在按钮周围添加外边距
        }
        .buttonStyle(PlainButtonStyle()) // 使用 PlainButtonStyle 避免默认样式
    }
}
struct textline: View {
    let text01: String
    let text02: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("账号：\(text01)")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 2) // 为下边留出空间
            
            Image("Line 1")
            
            Text("个性签名：\(text02)")
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(.bottom, 2) // 为下边留出空间
            
            Image("Line 1")
        }
        .padding(.horizontal) // 添加水平内边距
    }
}

// 预览
#Preview {
    MessageView()
}
