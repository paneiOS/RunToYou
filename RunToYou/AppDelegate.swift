//
//  AppDelegate.swift
//  RunToYou
//
//  Created by 이정환 on 4/22/24.
//

import UIKit
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // kakao login
        RxKakaoSDK.initSDK(appKey: "625a045f6d46a73f5449c3345256774d")
        // google login
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
            // Show the app's signed-in state.
          }
        }
        // naver login
        application.registerForRemoteNotifications()
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        instance?.isNaverAppOauthEnable = true // 네이버앱 로그인 설정
        instance?.isInAppOauthEnable = true // 사파리 로그인 설정

        instance?.serviceUrlScheme = "runtoyou" // URL Scheme
        instance?.consumerKey = "fD5pPHiy3_EajPbdMItv" // 클라이언트 아이디
        instance?.consumerSecret = "ehr6IFzkm0" // 시크릿 아이디
        instance?.appName = "RunToYou" // 앱이름
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [: ]) -> Bool {
        // naver
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        // google
        GIDSignIn.sharedInstance.handle(url)
        // kakao
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.rx.handleOpenUrl(url: url)
        }
        return true
    }
}
