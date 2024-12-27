// 详情页面

import SwiftUI
struct BookView: View {
    @Environment(\.presentationMode) var presentationMode  // 用于控制视图的显示和隐藏

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background01")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // 添加 backview01
                backview01()
                    .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top + 90)

                // 添加 backview02 并确保其底部对齐到屏幕底部
                backview02()
                    .position(x: geometry.size.width / 2, y: geometry.size.height - geometry.safeAreaInsets.bottom - 120)

                // 添加 text01 到中间顶部位置
                text01()
                    .position(x: geometry.size.width / 2, y: geometry.safeAreaInsets.top - 120)

                // 添加正在学习
                text02()
                    .position(x: geometry.safeAreaInsets.leading + 70, y: geometry.safeAreaInsets.top - 72)

                // 添加其他词书
                text03()
                    .position(x: geometry.safeAreaInsets.leading + 70, y: geometry.safeAreaInsets.top + 260)

                // 添加图书图像并设置点击跳转到详情页面
                NavigationLink(destination: TheWordList()) {
                    tushu01()
                        .position(x: geometry.size.width / 2 - 50, y: geometry.safeAreaInsets.top + 50)
                }
                xiugai01()
                    .position(x: geometry.size.width / 2 + 110, y: geometry.safeAreaInsets.top + 50)
            }
            .navigationBarBackButtonHidden(true)  // 隐藏默认的返回按钮
            .navigationBarItems(leading: customBackButton)  // 添加自定义的返回按钮
        }
    }

    // 自定义的返回按钮
    private var customBackButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()  // 关闭当前视图
        }) {
            Image("1-1")  // 使用您的自定义图片
                .resizable()
                .frame(width: 35, height: 35)  // 设置按钮大小
        }
    }
}

struct backview01: View {
    var body: some View {
        Image("background01")
            .resizable()
            .frame(width: 350, height:280)
            .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }
}

struct tushu01: View {
    var body: some View {
        Image("tushu01")
    }
}

struct xiugai01: View {
    var body: some View {
        Image("xiugai")
            .resizable()
            .frame(width: 64, height: 64)
    }
}

struct backview02: View {
    var body: some View {
        Image("background01")
            .resizable()
            .frame(width: 350, height: 400)
            .shadow(color: .gray, radius: 10, x: 5, y: 5)
    }
}

struct text01: View {
    var body: some View {
        Text("词书")
            .font(.system(size: 40))
            .foregroundColor(.white)
    }
}

struct text02: View {
    var body: some View {
        Text("正在学习")
            .font(.system(size: 25))
            .foregroundColor(.black)
    }
}

struct text03: View {
    var body: some View {
        Text("其他词书")
            .font(.system(size: 25))
            .foregroundColor(.black)
    }
}

// 预览结构体
struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookView()
        }
    }
}
