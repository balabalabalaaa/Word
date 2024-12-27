import SwiftUI

struct TheWordList: View {
    @EnvironmentObject var wordDataManager: WordDataManager  // 访问单词数据管理器
    @State private var selectedSegment: Int = 0  // 当前选中的标签索引
    @State private var showEbbinghausCurveView = false  // 控制是否显示艾宾浩斯曲线图

    let tags = WordStatus.allCases.map { $0.description }

    var body: some View {
        ZStack {
            BackView(selectedSegment: selectedSegment)
            
            VStack {
                Spacer(minLength: 10)
                TextView(textcontent: "四级英语词汇")
                UISegmentedControlWrapper(tags: tags, selectedSegment: $selectedSegment)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                // 显示当前选中的标签下的单词列表
                List(filteredWords) { word in
                    HStack {
                        Text(word.english)
                            .font(.headline)
                        Spacer()
                        Text(word.chinese)
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        updateWordStatus(word: word)
                    }
                }
                .listStyle(PlainListStyle())
                
                // 添加一个按钮跳转到艾宾浩斯曲线图
                Button(action: {
                    showEbbinghausCurveView = true
                }) {
                    Text("查看艾宾浩斯曲线")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
                // 其他内容可以在这里添加

            }
        }
        .navigationTitle("")  // 清空导航栏标题
        .navigationBarBackButtonHidden(true)  // 隐藏默认的返回按钮
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Mainpage()) {
                    Text("开始学习")
                        .foregroundColor(.white)
                }
            }
        }
        .sheet(isPresented: $showEbbinghausCurveView) {
            EbbinghausCurveView()
                .environmentObject(wordDataManager)
        }
    }
    
    // 过滤出当前选中的标签下的单词
    var filteredWords: [Word] {
        let selectedStatus = WordStatus(rawValue: selectedSegment) ?? .notLearned
        return wordDataManager.words.filter { $0.status == selectedStatus }
    }
    
    // 更新单词的状态
    func updateWordStatus(word: Word) {
        if let index = wordDataManager.words.firstIndex(where: { $0.id == word.id }) {
            var newStatus: WordStatus
            switch word.status {
            case .notLearned:
                newStatus = .reviewing
            case .reviewing:
                newStatus = .reviewed
            case .reviewed:
                newStatus = .marked
            case .marked:
                newStatus = .notLearned
            }
            wordDataManager.updateWordStatus(word: word, newStatus: newStatus)
        }
    }
}

// 背景图片
struct BackView: View {
    var selectedSegment: Int
    
    var body: some View {
        Image("TheWordListbackground")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}

// 标题
struct TextView: View {
    var textcontent: String
    
    var body: some View {
        Text(textcontent)
            .font(.system(size: 30))
            .foregroundColor(.white)
    }
}

// UISegmentedControl Wrapper
struct UISegmentedControlWrapper: UIViewRepresentable {
    let tags: [String]
    @Binding var selectedSegment: Int
    
    func makeUIView(context: Context) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: tags)
        segmentedControl.selectedSegmentIndex = selectedSegment
        segmentedControl.addTarget(context.coordinator, action: #selector(Coordinator.segmentValueChanged), for: .valueChanged)
        return segmentedControl
    }
    
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        uiView.selectedSegmentIndex = selectedSegment
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: UISegmentedControlWrapper
        
        init(parent: UISegmentedControlWrapper) {
            self.parent = parent
        }
        
        @objc func segmentValueChanged(sender: UISegmentedControl) {
            parent.selectedSegment = sender.selectedSegmentIndex
        }
    }
}

#Preview {
    TheWordList()
        .environmentObject(WordDataManager())
}
