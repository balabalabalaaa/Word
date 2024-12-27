import Foundation
import SwiftUI

enum WordStatus: Int, CaseIterable {
    case notLearned = 0
    case reviewing
    case reviewed
    case marked
    
    var description: String {
        switch self {
        case .notLearned:
            return "未学习"
        case .reviewing:
            return "复习中"
        case .reviewed:
            return "已复习"
        case .marked:
            return "已标记"
        }
    }
}

struct Word: Identifiable {
    let id: UUID
    let english: String
    let chinese: String
    var status: WordStatus
    var translations: [String]  // 将 translations 改为 var
    var lastReviewed: Date?
}

class WordDataManager: ObservableObject {
    private var correctAnswers: Int = 0
    private var totalAnswers: Int = 0
    @Published var words: [Word] = [
        // 水果
        Word(id: UUID(), english: "apple", chinese: "苹果", status: .notLearned, translations: []),
        Word(id: UUID(), english: "banana", chinese: "香蕉", status: .notLearned, translations: []),
        Word(id: UUID(), english: "orange", chinese: "橙子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pear", chinese: "梨", status: .notLearned, translations: []),
        Word(id: UUID(), english: "grape", chinese: "葡萄", status: .notLearned, translations: []),
        Word(id: UUID(), english: "strawberry", chinese: "草莓", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cherry", chinese: "樱桃", status: .notLearned, translations: []),
        Word(id: UUID(), english: "blueberry", chinese: "蓝莓", status: .notLearned, translations: []),
        Word(id: UUID(), english: "watermelon", chinese: "西瓜", status: .notLearned, translations: []),
        Word(id: UUID(), english: "honeydew", chinese: "哈密瓜", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cantaloupe", chinese: "甜瓜", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pumpkin", chinese: "南瓜", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pineapple", chinese: "菠萝", status: .notLearned, translations: []),
        Word(id: UUID(), english: "mango", chinese: "芒果", status: .notLearned, translations: []),
        Word(id: UUID(), english: "coconut", chinese: "椰子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "papaya", chinese: "木瓜", status: .notLearned, translations: []),
        Word(id: UUID(), english: "lemon", chinese: "柠檬", status: .notLearned, translations: []),
        Word(id: UUID(), english: "lime", chinese: "酸橙", status: .notLearned, translations: []),
        Word(id: UUID(), english: "grapefruit", chinese: "柚子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "tangerine", chinese: "柑橘", status: .notLearned, translations: []),

        // 动物
        Word(id: UUID(), english: "dog", chinese: "狗", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cat", chinese: "猫", status: .notLearned, translations: []),
        Word(id: UUID(), english: "elephant", chinese: "大象", status: .notLearned, translations: []),
        Word(id: UUID(), english: "lion", chinese: "狮子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "tiger", chinese: "老虎", status: .notLearned, translations: []),
        Word(id: UUID(), english: "bear", chinese: "熊", status: .notLearned, translations: []),
        Word(id: UUID(), english: "wolf", chinese: "狼", status: .notLearned, translations: []),
        Word(id: UUID(), english: "fox", chinese: "狐狸", status: .notLearned, translations: []),
        Word(id: UUID(), english: "rabbit", chinese: "兔子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "squirrel", chinese: "松鼠", status: .notLearned, translations: []),
        Word(id: UUID(), english: "duck", chinese: "鸭子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "chicken", chinese: "鸡", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cow", chinese: "牛", status: .notLearned, translations: []),
        Word(id: UUID(), english: "sheep", chinese: "羊", status: .notLearned, translations: []),
        Word(id: UUID(), english: "horse", chinese: "马", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pig", chinese: "猪", status: .notLearned, translations: []),
        Word(id: UUID(), english: "goat", chinese: "山羊", status: .notLearned, translations: []),
        Word(id: UUID(), english: "deer", chinese: "鹿", status: .notLearned, translations: []),
        Word(id: UUID(), english: "zebra", chinese: "斑马", status: .notLearned, translations: []),
        Word(id: UUID(), english: "giraffe", chinese: "长颈鹿", status: .notLearned, translations: []),

        // 颜色
        Word(id: UUID(), english: "red", chinese: "红色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "blue", chinese: "蓝色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "green", chinese: "绿色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "yellow", chinese: "黄色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "orange", chinese: "橙色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "purple", chinese: "紫色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pink", chinese: "粉色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "black", chinese: "黑色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "white", chinese: "白色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "gray", chinese: "灰色", status: .notLearned, translations: []),
        Word(id: UUID(), english: "brown", chinese: "棕色", status: .notLearned, translations: []),

        // 职业
        Word(id: UUID(), english: "doctor", chinese: "医生", status: .notLearned, translations: []),
        Word(id: UUID(), english: "nurse", chinese: "护士", status: .notLearned, translations: []),
        Word(id: UUID(), english: "teacher", chinese: "教师", status: .notLearned, translations: []),
        Word(id: UUID(), english: "engineer", chinese: "工程师", status: .notLearned, translations: []),
        Word(id: UUID(), english: "lawyer", chinese: "律师", status: .notLearned, translations: []),
        Word(id: UUID(), english: "police", chinese: "警察", status: .notLearned, translations: []),
        Word(id: UUID(), english: "firefighter", chinese: "消防员", status: .notLearned, translations: []),
        Word(id: UUID(), english: "chef", chinese: "厨师", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pilot", chinese: "飞行员", status: .notLearned, translations: []),
        Word(id: UUID(), english: "driver", chinese: "司机", status: .notLearned, translations: []),
        Word(id: UUID(), english: "artist", chinese: "艺术家", status: .notLearned, translations: []),
        Word(id: UUID(), english: "actor", chinese: "演员", status: .notLearned, translations: []),
        Word(id: UUID(), english: "musician", chinese: "音乐家", status: .notLearned, translations: []),
        Word(id: UUID(), english: "writer", chinese: "作家", status: .notLearned, translations: []),
        Word(id: UUID(), english: "scientist", chinese: "科学家", status: .notLearned, translations: []),
        Word(id: UUID(), english: "journalist", chinese: "记者", status: .notLearned, translations: []),
        Word(id: UUID(), english: "farmer", chinese: "农民", status: .notLearned, translations: []),
        Word(id: UUID(), english: "carpenter", chinese: "木匠", status: .notLearned, translations: []),
        Word(id: UUID(), english: "electrician", chinese: "电工", status: .notLearned, translations: []),
        Word(id: UUID(), english: "plumber", chinese: "水管工", status: .notLearned, translations: []),

        // 天气
        Word(id: UUID(), english: "sunny", chinese: "晴朗", status: .notLearned, translations: []),
        Word(id: UUID(), english: "rainy", chinese: "下雨", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cloudy", chinese: "多云", status: .notLearned, translations: []),
        Word(id: UUID(), english: "windy", chinese: "有风", status: .notLearned, translations: []),
        Word(id: UUID(), english: "snowy", chinese: "下雪", status: .notLearned, translations: []),
        Word(id: UUID(), english: "stormy", chinese: "暴风雨", status: .notLearned, translations: []),
        Word(id: UUID(), english: "foggy", chinese: "雾蒙蒙", status: .notLearned, translations: []),
        Word(id: UUID(), english: "hot", chinese: "热", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cold", chinese: "冷", status: .notLearned, translations: []),
        Word(id: UUID(), english: "warm", chinese: "温暖", status: .notLearned, translations: []),
        Word(id: UUID(), english: "cool", chinese: "凉爽", status: .notLearned, translations: []),

        // 日常用品
        Word(id: UUID(), english: "book", chinese: "书", status: .notLearned, translations: []),
        Word(id: UUID(), english: "pen", chinese: "笔", status: .notLearned, translations: []),
        Word(id: UUID(), english: "chair", chinese: "椅子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "table", chinese: "桌子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "bed", chinese: "床", status: .notLearned, translations: []),
        Word(id: UUID(), english: "sofa", chinese: "沙发", status: .notLearned, translations: []),
        Word(id: UUID(), english: "lamp", chinese: "灯", status: .notLearned, translations: []),
        Word(id: UUID(), english: "mirror", chinese: "镜子", status: .notLearned, translations: []),
        Word(id: UUID(), english: "phone", chinese: "电话", status: .notLearned, translations: []),
        Word(id: UUID(), english: "computer", chinese: "电脑", status: .notLearned, translations: []),
        Word(id: UUID(), english: "television", chinese: "电视", status: .notLearned, translations: []),
        Word(id: UUID(), english: "refrigerator", chinese: "冰箱", status: .notLearned, translations: []),
        Word(id: UUID(), english: "microwave", chinese: "微波炉", status: .notLearned, translations: []),
        Word(id: UUID(), english: "oven", chinese: "烤箱", status: .notLearned, translations: []),
        Word(id: UUID(), english: "dishwasher", chinese: "洗碗机", status: .notLearned, translations: []),
        Word(id: UUID(), english: "washingMachine", chinese: "洗衣机", status: .notLearned, translations: []),
        Word(id: UUID(), english: "dryer", chinese: "烘干机", status: .notLearned, translations: []),
        Word(id: UUID(), english: "vacuumCleaner", chinese: "吸尘器", status: .notLearned, translations: []),
        Word(id: UUID(), english: "airConditioner", chinese: "空调", status: .notLearned, translations: []),
        Word(id: UUID(), english: "fan", chinese: "风扇", status: .notLearned, translations: [])
    ]

  

    // 生成干扰项并随机排列
    func generateTranslations(for word: Word) -> [String] {
        let correctTranslation = word.chinese
        let allTranslations = words.map { $0.chinese }
        var randomTranslations: [String] = []

        // 确保不会重复选择同一个词
        while randomTranslations.count < 3 {
            let randomIndex = Int.random(in: 0..<allTranslations.count)
            let randomTranslation = allTranslations[randomIndex]
            if !randomTranslations.contains(randomTranslation) && randomTranslation != correctTranslation {
                randomTranslations.append(randomTranslation)
            }
        }

        // 将正确答案加入列表
        var allOptions = [correctTranslation] + randomTranslations

        // 打乱顺序
        allOptions.shuffle()

        return allOptions
    }

    // 初始化时为每个单词生成翻译选项
    init() {
        for (index, word) in words.enumerated() {
            let translations = generateTranslations(for: word)
            words[index].translations = translations
        }
    }
    // 更新单词状态
    func updateWordStatus(word: Word, newStatus: WordStatus) {
           if let index = words.firstIndex(where: { $0.id == word.id }) {
               words[index].status = newStatus
               words[index].lastReviewed = Date()
           }
       }

       // 记录答题情况
       func recordAnswer(isCorrect: Bool) {
           if isCorrect {
               correctAnswers += 1
           }
           totalAnswers += 1
       }

       // 获取答题正确率
       func getAnswerAccuracy() -> Double {
           guard totalAnswers > 0 else { return 0.0 }
           return Double(correctAnswers) / Double(totalAnswers) * 100
       }

       // 重置答题记录
       func resetAnswerRecords() {
           correctAnswers = 0
           totalAnswers = 0
       }

       // 计算艾宾浩斯复习间隔
       func calculateReviewIntervals(for word: Word) -> [TimeInterval] {
           // 根据单词的状态和上次复习时间计算复习间隔
           // 这里只是一个简单的示例，你可以根据实际需求调整
           let intervals: [TimeInterval] = [0, 1, 5, 24, 72, 168]
           return intervals
       }

       // 获取保留率
       func getRetentionRates() -> [Double] {
           // 这里可以根据用户的背单词正确率或其他指标来计算保留率
           // 为了简化，这里使用固定的保留率
           return [100, 80, 60, 40, 20, 10]
       }
}



