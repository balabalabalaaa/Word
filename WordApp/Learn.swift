import SwiftUI

struct Learn: View {
    @Environment(\.presentationMode) var presentationMode  // 获取当前视图的呈现模式
    @EnvironmentObject var wordDataManager: WordDataManager  // 访问单词数据管理器
    @State private var currentWordIndex = 0  // 当前单词的索引
    @State private var isCorrectAnswerSelected = false  // 是否选择了正确答案
    @State private var selectedButtonIndices: [Int] = []  // 选中的按钮索引
    let isLearningMode: Bool  // 新增的学习模式参数

    var body: some View {
        ZStack {
            backimage01()
            contentVStack
                .padding(.horizontal, 20) // 添加水平内边距
        }
        .navigationTitle("")  // 清空导航栏标题
        .navigationBarBackButtonHidden(true)  // 隐藏默认的返回按钮
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .onTapGesture {
            if isCorrectAnswerSelected {
                // 重置状态并进入下一个单词
                self.currentWordIndex = (self.currentWordIndex + 1) % wordDataManager.words.count
                self.selectedButtonIndices = []
                self.isCorrectAnswerSelected = false
            }
        }
    }

    // 辅助计算属性：获取当前单词的正确翻译
    var correctTranslation: String {
        return wordDataManager.words[currentWordIndex].chinese
    }

    // 主内容 VStack
    var contentVStack: some View {
        VStack(spacing: 18) {
            Spacer(minLength: 100)
            
            AdditionalTextView(text: wordDataManager.words[currentWordIndex].english)  // 显示英文单词
            
            translationButtons
            
            Spacer()
                .frame(height: 160)
            
            bottomButtonsHStack
            Spacer()
                .frame(height: 60)
        }
    }

    // 翻译按钮
    var translationButtons: some View {
        ForEach(0..<wordDataManager.words[currentWordIndex].translations.count, id: \.self) { index in
            RectangleButton(
                color: self.selectedButtonIndices.contains(index) ? (self.correctTranslation == wordDataManager.words[currentWordIndex].translations[index] ? Color.green : Color.red) : Color(hex: 0xEED7D7),
                width: 360,
                height: 65,
                text: wordDataManager.words[currentWordIndex].translations[index],
                textColor: .black,
                fontSize: 20,
                action: {
                    if !selectedButtonIndices.contains(index) {
                        self.selectedButtonIndices.append(index)
                        if wordDataManager.words[currentWordIndex].translations[index] == wordDataManager.words[currentWordIndex].chinese {
                            self.isCorrectAnswerSelected = true
                            // 将单词状态更新为已复习
                            updateWordStatus(word: wordDataManager.words[currentWordIndex], newStatus: .reviewed)
                        } else {
                            // 如果选择错误，可以做一些其他处理
                        }
                    }
                }
            )
        }
    }

    // 底部按钮 HStack
    var bottomButtonsHStack: some View {
        HStack(spacing: 100) {
            RectangleButton(color: Color(hex: 0xB2E1FF), width: 100, height: 65, text: "看答案", textColor: .white, fontSize: 25, action: {
                print("Bottom Left Button Tapped")
            })
            RectangleButton(color: Color(hex: 0xB2E1FF), width: 100, height: 65, text: "标记", textColor: .white, fontSize: 25, action: {
                // 将单词状态更新为已标记
                updateWordStatus(word: wordDataManager.words[currentWordIndex], newStatus: .marked)
            })
        }
    }

    // 返回按钮
    var backButton: some View {
        Button(action: {
            // 返回操作
            self.presentationMode.wrappedValue.dismiss()  // 关闭当前视图
        }) {
            RoundedRectangle(cornerRadius: 8)  // 自定义按钮形状
                .fill(Color.clear)  // 自定义按钮背景颜色
                .frame(width: 40, height: 40)  // 设置按钮大小
                .overlay(
                    Image(systemName: "chevron.backward")  // 使用系统图标作为返回按钮
                        .foregroundColor(.white)  // 改变返回按钮箭头的颜色
                )
        }
    }
    
    // 更新单词的状态
    func updateWordStatus(word: Word, newStatus: WordStatus) {
        wordDataManager.updateWordStatus(word: word, newStatus: newStatus)
    }
}

// 辅助文本视图
struct AdditionalTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.black)
            .padding()
            .background(Color.clear) // 设置背景为透明
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 50) // 调整文本位置
    }
}

// 背景图片
struct backimage01: View {
    var body: some View {
        Image("background02")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}

// 自定义矩形按钮视图
struct RectangleButton: View {
    let color: Color
    let width: CGFloat
    let height: CGFloat
    let text: String
    let textColor: Color
    let fontSize: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(color)
                    .frame(width: width, height: height)
                    .shadow(radius: 5)
                Text(text)
                    .font(.system(size: fontSize, weight: .bold))
                    .foregroundColor(textColor)
                    .padding()
            }
        }
    }
}

// 扩展 Color 以支持十六进制颜色
extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: opacity
        )
    }
}

#Preview {
    Learn(isLearningMode: true)
        .environmentObject(WordDataManager())
}
