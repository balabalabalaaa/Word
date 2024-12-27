import SwiftUI
import Charts

struct EbbinghausCurveView: View {
    @EnvironmentObject var wordDataManager: WordDataManager
    @State private var retentionRates: [Double] = [100, 80, 60, 40, 20, 10]
    @State private var reviewIntervals: [TimeInterval] = [0, 1, 5, 24, 72, 168]

    var body: some View {
        VStack {
            Text("艾宾浩斯记忆曲线")
                .font(.largeTitle)
                .padding()

            Chart {
                ForEach(0..<retentionRates.count, id: \.self) { index in
                    LineMark(
                        x: .value("Review Interval", reviewIntervals[index]),
                        y: .value("Retention Rate", retentionRates[index])
                    )
                    .foregroundStyle(by: .value("Interval", index))
                    .annotation(position: .overlay) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                            .onTapGesture {
                                showDetails(for: index)
                            }
                    }
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }

            // 基于用户数据的分析
            Text("根据你的学习进度，建议你在以下时间点复习：")
                .font(.headline)
                .padding()

            // 根据 reviewIntervals 显示建议
            ForEach(0..<reviewIntervals.count, id: \.self) { index in
                HStack {
                    Text(String(format: "%.2f小时后", reviewIntervals[index]))
                    Spacer()
                    Text(String(format: "%.2f%%", retentionRates[index]))
                }
                .padding()
            }
        }
        .padding()
        .navigationTitle("艾宾浩斯曲线")
        .navigationBarItems(trailing: Button(action: {
            wordDataManager.resetAnswerRecords()
        }) {
            Text("重置答题记录")
        })
        .onAppear {
            updateRetentionRates()
        }
    }

    // 显示详细信息
    func showDetails(for index: Int) {
        let interval = reviewIntervals[index]
        let retentionRate = retentionRates[index]
        let message = "复习间隔: \(interval)小时, 保留率: \(retentionRate)%"
        print(message)  // 可以在这里添加弹出提示或其他方式展示信息
    }

    // 更新保留率
    func updateRetentionRates() {
        let accuracy = wordDataManager.getAnswerAccuracy()
        retentionRates = calculateRetentionRates(accuracy: accuracy)
    }

    // 根据答题正确率计算保留率
    func calculateRetentionRates(accuracy: Double) -> [Double] {
        // 这里可以根据答题正确率动态调整保留率
        // 为了简化，这里使用线性的关系
        let baseRetentionRates: [Double] = [100, 80, 60, 40, 20, 10]
        let adjustedRetentionRates = baseRetentionRates.map { rate in
            max(rate - (100 - accuracy) * 0.1, 0)
        }
        return adjustedRetentionRates
    }
}

struct EbbinghausCurveView_Previews: PreviewProvider {
    static var previews: some View {
        EbbinghausCurveView()
            .environmentObject(WordDataManager())
    }
}
