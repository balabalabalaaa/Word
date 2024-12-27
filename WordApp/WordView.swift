import SwiftUI

struct WordView: View {
    @Environment(\.presentationMode) var presentationMode  // 修正变量名

    var body: some View {
        ZStack {
            // 背景图像
            Image("background01")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)  // 隐藏默认的返回按钮
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                customBackButton(presentationMode: presentationMode)  // 传递 presentationMode
            }
        }
    }
}

// 自定义的返回按钮
private func customBackButton(presentationMode: Binding<PresentationMode>) -> some View {
    Button(action: {
        presentationMode.wrappedValue.dismiss()  // 关闭当前视图
    }) {
        Image("1-1")  // 使用您的自定义图片
            .resizable()
            .frame(width: 35, height: 35)  // 设置按钮大小
    }
}

#Preview {
    NavigationView {
        WordView()
    }
}
