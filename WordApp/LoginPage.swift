import SwiftUI

struct LoginPage: View {
    @Binding var isUserLoggedIn: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    // 背景图片
                    Image("logininterfacebackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    
                    // 透明模糊的长方形框包裹登录表单
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.48) // 设置相同高度
                        .foregroundColor(.orange1.opacity(0.5))
                        .blur(radius: 1)
                        .overlay(
                            VStack(alignment: .center, spacing: 20) {
                                TextField("Username", text: $username)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                SecureField("Password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                Button(action: {
                                    self.loginUser(username: username, password: password)
                                }) {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding()
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding([.horizontal, .top], 20)
                                
                                NavigationLink(destination: RegistrationPage(showLoginPage: .constant(true))) {
                                    Text("还没有账号？注册")
                                        .foregroundColor(.blue)
                                        .font(.subheadline)
                                }
                                .padding()
                            }
                            .padding()
                        )
                        .offset(y: -geometry.size.height * 0.07) // 调整垂直位置
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertMessage), dismissButton: .default(Text("确定")))
                }
                // 添加条件渲染 Mainpage 视图，并使用 transition 效果
                .overlay(
                    Group {
                        if isUserLoggedIn {
                            Mainpage()
                                .transition(.opacity)
                        }
                    }
                )
            }
        }
    }

    func loginUser(username: String, password: String) {
        guard let savedUsername = UserDefaults.standard.string(forKey: "username"),
              let savedPassword = UserDefaults.standard.string(forKey: "password"),
              savedUsername == username,
              savedPassword == password else {
            showAlert = true
            alertMessage = "登录失败。用户名或密码错误。"
            return
        }
        
        // 登录成功后显示 Mainpage
        isUserLoggedIn = true
    }
}

// 预览结构体
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(isUserLoggedIn: .constant(false))
    }
}
