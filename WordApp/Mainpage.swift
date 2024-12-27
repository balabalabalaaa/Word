import SwiftUI

struct Mainpage: View {
    @State private var isButtonTapped = false
    @State private var lastTappedDate: Date?
    @State private var isProfileButtonTapped = false
    @State private var isRectButton1Tapped = false
    @State private var isRectButton2Tapped = false
    @State private var showLearnView = false  // 用于控制是否显示 Learn 视图
    @State private var showBookView = false  // 用于控制是否显示 BookView
    @State private var showContentPage = false  // 用于控制是否显示 ContentPage
    @State private var showEbbinghausCurveView = false  // 新增状态变量

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    BackImage()
                    VStack {
                        // 放置圆形按钮（头像）在左上角
                        HStack {
                            ProfileButton(isProfileButtonTapped: $isProfileButtonTapped)
                            Spacer()
                        }
                        .padding([.leading, .top]) // 添加外边距
                        
                        Spacer()
                        
                        // 原来的按钮
                        MainButton(isButtonTapped: $isButtonTapped, lastTappedDate: $lastTappedDate)
                            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.08)
                        
                        // 新增的两个并排矩形按钮
                        HStack(spacing: 20) {
                            RectButton(isTapped: $isRectButton1Tapped, image: "rectbutton1", action: { showLearnView = true })
                            RectButton(isTapped: $isRectButton2Tapped, image: "rectbutton2", action: { showLearnView = true })
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.27)
                        
                        // 新增的三个带有图片和文字说明的方形按钮
                        HStack(spacing: 20) {
                            ForEach(["词书", "内容", "曲线"], id: \.self) { buttonText in
                                SquareButton(buttonText: buttonText, imageName: "rectbutton\((["词书", "内容", "曲线"].firstIndex(of: buttonText)! + 3))", action: {
                                    if buttonText == "词书" {
                                        self.showBookView = true
                                    } else if buttonText == "内容" {
                                        self.showContentPage = true  // 更新状态变量以显示 ContentPage
                                    } else if buttonText == "曲线" {
                                        self.showEbbinghausCurveView = true  // 显示艾宾浩斯曲线图
                                    }
                                })
                            }
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.13)
                        
                        // 隐藏的 NavigationLink
                        NavigationLink(destination: Learn(isLearningMode: true), isActive: $showLearnView) {
                            EmptyView()
                        }

                        // 隐藏的 NavigationLink 用于跳转到 BookView
                        NavigationLink(destination: BookView(), isActive: $showBookView) {
                            EmptyView()
                        }

                        // 隐藏的 NavigationLink 用于跳转到 ContentPage
                        NavigationLink(destination: ContentPage(), isActive: $showContentPage) {
                            EmptyView()
                        }

                        // 隐藏的 NavigationLink 用于跳转到 EbbinghausCurveView
                        NavigationLink(destination: EbbinghausCurveView(), isActive: $showEbbinghausCurveView) {
                            EmptyView()
                        }

                        Spacer()
                    }
                }
            }
        }
    }
}

// 背景图片视图
struct BackImage: View {
    var body: some View {
        Image("Mainpagebackground")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}

// 头像按钮
struct ProfileButton: View {
    @Binding var isProfileButtonTapped: Bool

    var body: some View {
        Button(action: {
            isProfileButtonTapped.toggle()
        }) {
            Image("1-2")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 0)
                )
                .padding(10) // 添加内边距
        }
    }
}

// 主按钮
struct MainButton: View {
    @Binding var isButtonTapped: Bool
    @Binding var lastTappedDate: Date?

    var body: some View {
        Button(action: {
            if !isButtonTapped {
                let calendar = Calendar.current
                if let lastTapped = lastTappedDate,
                   calendar.isDateInToday(lastTapped) {
                    // 如果今天已经点击过，则不执行任何操作
                    return
                }

                isButtonTapped = true
                lastTappedDate = Date()
            }
        }) {
            if isButtonTapped {
                Image("mainpagebutton1")
                    .resizable()
                    .scaledToFit()
            } else {
                Image("mainpagebutton2")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: 150, height: 150)
        .background(Color.clear)
        .cornerRadius(10)
        .padding()
    }
}

// 矩形按钮
struct RectButton: View {
    @Binding var isTapped: Bool
    let image: String
    let action: () -> Void  // 添加一个动作参数

    var body: some View {
        Button(action: {
            isTapped.toggle()
            action()  // 执行传递的动作
        }) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 90)
                .cornerRadius(10)
        }
        .padding()
    }
}

// 方形按钮
struct SquareButton: View {
    let buttonText: String
    let imageName: String
    let action: () -> Void  // 添加一个动作参数

    var body: some View {
        Button(action: {
            action()  // 执行传递的动作
        }) {
            VStack(spacing: 5) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                Text(buttonText)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.clear)
            .cornerRadius(10)
        }
    }
}

// 预览结构体
struct Mainpage_Previews: PreviewProvider {
    static var previews: some View {
        Mainpage()
    }
}
