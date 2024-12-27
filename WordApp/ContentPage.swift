import SwiftUI

struct ContentPage: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {  // 添加 NavigationView 以支持导航
            ZStack {
                // 背景图像
                Image("TheWordListbackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Spacer(minLength: 10)
                    pagetext()
                    ZStack {
                        PageView(width: 360, height: 92)
                        pagecontent(imagee: "在学词书", text: "在学词书") {
                            AnyView(NavigationLink(destination: WordView(), label: {
                                EmptyView()
                            }).hidden())
                        }
                    }
                    ZStack {
                        PageView(width: 360, height: 200)
                        VStack {
                            pagecontent(imagee: "jinriyixuerenwu", text: "今日已学") {
                                AnyView(NavigationLink(destination: WordView(), label: {
                                    EmptyView()
                                }).hidden())
                            }
                            pagecontent(imagee: "jinriyixue-4", text: "全部已学") {
                                AnyView(NavigationLink(destination: WordView(), label: {
                                    EmptyView()
                                }).hidden())
                            }
                        }
                    }
                    ZStack {
                        PageView(width: 360, height: 200)
                        VStack {
                            pagecontent(imagee: "biaoji-yibiaoji-2", text: "已标记") {
                                AnyView(NavigationLink(destination: WordView(), label: {
                                    EmptyView()
                                }).hidden())
                            }
                            pagecontent(imagee: "a-bijibenbiji", text: "笔记") {
                                AnyView(NavigationLink(destination: WordView(), label: {
                                    EmptyView()
                                }).hidden())
                            }
                        }
                    }
                    Spacer(minLength: 180)
                }
            }
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

struct pagetext: View {
    var body: some View {
        Text("我的内容")
            .font(.system(size: 40))
            .foregroundColor(.black)
    }
}

struct PageView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image("backcolor1")  // 确保图像名称正确
            .resizable()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct pagecontent: View {
    // 定义变量
    let imagee: String
    let text: String
    let destination: () -> AnyView  // 目标视图的闭包
    
    var body: some View {
        HStack {  // 使用 HStack 横向排列视图，并设置间距
            // 固定长度的间隔
            Rectangle()  // 使用 Rectangle 来创建一个固定长度的间隔
                .fill(Color.clear)  // 填充透明色
                .frame(width: 10)  // 设置间隔宽度为10个单位
            
            // 图片
            Image(imagee)
                .resizable()
                .frame(width: 40, height: 40)  // 设置图片的固定尺寸
            
            // 文字
            Text(text)
                .font(.system(size: 36))  // 设置文字大小为36
                .foregroundColor(.white)  // 设置文字颜色为白色
                .multilineTextAlignment(.leading)  // 文字左对齐
            
            Spacer()
            // 按钮
            NavigationLink(destination: destination()) {
                Image("jiantou")
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

// 预览
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPage()
    }
}
