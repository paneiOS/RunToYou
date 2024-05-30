//
//  AppAuthViewReactor.swift
//  RunToYou
//
//  Created by 23 09 on 2024/05/17.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import AVFoundation
import Photos
import CoreLocation

final class AppAuthViewReactor: NSObject, Reactor, CLLocationManagerDelegate {
    enum Action {
        case takeAuthority
        case goNextPage
    }

    enum Mutation {
        case goNextPage
    }

    struct State {
        var goNextPage: Bool = false
    }

    let initialState: State = State()
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    deinit {
        print("\(type(of: self)): Deinited")
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .takeAuthority:
            return Observable.concat([
                requestNotificationAuth(),
                requestCameraAuth(),
                requestPhotoLibraryAuth(),
                requestLocationAuth()
            ])
        case .goNextPage:
            return Observable.just(Mutation.goNextPage)
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .goNextPage:
            newState.goNextPage = true
        }
        return newState
    }

    private func requestNotificationAuth() -> Observable<Mutation> {
        return Observable.create { observer in
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]) { _, _ in
                    observer.onCompleted()
                }
            return Disposables.create()
        }
    }

    private func requestCameraAuth() -> Observable<Mutation> {
        return Observable.create { observer in
            AVCaptureDevice.requestAccess(for: .video) { _ in
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    private func requestPhotoLibraryAuth() -> Observable<Mutation> {
        return Observable.create { observer in
            PHPhotoLibrary.requestAuthorization { _ in
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    private func requestLocationAuth() -> Observable<Mutation> {
        return Observable.create { observer in
            self.locationManager.requestWhenInUseAuthorization()
            observer.onCompleted()
            return Disposables.create()
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.action.onNext(.goNextPage)
        case .restricted, .notDetermined:
            break
        case .denied:
            break
        @unknown default:
            return
        }
    }
}
