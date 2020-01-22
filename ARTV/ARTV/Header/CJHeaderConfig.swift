//
//  CJHeaderConfig.swift
//  Privatealbums
//
//  Created by Anmo on 2019/6/12.
//  Copyright © 2019 Cingjin. All rights reserved.
//

import Foundation
import UIKit

/** 屏幕宽度*/
let CJSCREEN_WIDTH = UIScreen.main.bounds.width

/** 屏幕高度*/
let CJSCREEN_HEIGHT = UIScreen.main.bounds.height

/** 状态栏高度*/
func CJ_STATUSHEIGHT() -> CGFloat{
    if isiPhoneXLater() {
        return 44.0
    }
    return 20.0
}

/** tabbar高度*/
func CJ_TABBARHEIGHT() -> CGFloat {
    if isiPhoneXLater() {
        return 83.0
    }
    return 49.0
}

/** 适配底部高度*/
func CJ_BOTTOMMARGINHEIGHT() -> CGFloat{
    if isiPhoneXLater() {
        return 34.0
    }
    return 0.0
}

/** 导航栏高度*/
func CJ_NAVHEIGHT() -> CGFloat {
    if isiPhoneXLater() {
        return 88.0
    }
    return 64.0
}

/** 按比例自适应屏幕高度*/
func CJFIT_SCREEN_HEIGTH(_ size:CGFloat) -> CGFloat {
    return size * (CJSCREEN_HEIGHT / 667.0)
}

/** 按比例自适应屏幕宽度*/
func CJFIT_SCREEN_WIDTH(_ size:CGFloat) -> CGFloat {
    return size * (CJSCREEN_HEIGHT / 375.0)
}

/** 按比例自适应字体大小*/
func CJAUTO_FONT(_ size:CGFloat) -> UIFont {
    let autoSize = size * (CJSCREEN_WIDTH / 375.0)
    return UIFont.systemFont(ofSize: autoSize)
}

/** 获取沙盒路径*/
// home 目录 参考资料：http://www.hangge.com/blog/cache/detail_765.html
let CJ_homeDirectory = NSHomeDirectory()
// Documnets目录  ./Documents
let CJ_documentPath = CJ_homeDirectory + "/Documents"
// Library目录  ./Library 这个目录下有两个子目录：Caches 和 Preferences
let CJ_libraryPath = CJ_homeDirectory + "/Library"
//Cache目录
let CJ_cachePath = CJ_homeDirectory + "/Library/Caches"

/** 获取iPhone名称*/
func iPhoneName() -> String {
    return UIDevice.current.name
}

/** 获取当前设备型号*/
func deviceModelName() -> String{
    return UIDevice.current.modeName
}

/** 获取app版本号*/
func appVersion() -> String {
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
}

/** 获取电池电量*/
func batteryLevel() -> CGFloat {
    return CGFloat(UIDevice.current.batteryLevel)
}

/** 当前系统名称*/
func systemName() -> String {
    return UIDevice.current.systemName
}

/** 当前系统版本号*/
func systemVersion() -> String {
    return UIDevice.current.systemVersion
}

/** 通用唯一识别码UUID*/
func UUID() -> String {
    return (UIDevice.current.identifierForVendor?.uuidString)!
}

/** 获取当前设备IP*/
func deviceIP() -> String? {
    var addresses = [String]()
    var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while (ptr != nil) {
            let flags = Int32(ptr!.pointee.ifa_flags)
            var addr = ptr!.pointee.ifa_addr.pointee
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        if let address = String(validatingUTF8:hostname) {
                            addresses.append(address)
                        }
                    }
                }
            }
            ptr = ptr!.pointee.ifa_next
        }
        freeifaddrs(ifaddr)
    }
    return addresses.first
}

/** 私有方法*/
private func blankof<T>(type:T.Type) -> T {
    let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
    let val = ptr.pointee
    ptr.deinitialize(count: 0)
    return val
}

/** 获取总内存大小*/
func totalRAM() -> Int64 {
    var fs = blankof(type: statfs.self)
    if statfs("/var",&fs) >= 0{
        return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
    }
    return -1
}

/** 获取当前可用内存*/
func availableRAM() -> Int64 {
    var fs = blankof(type: statfs.self)
    if statfs("/var",&fs) >= 0{
        return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
    }
    return -1
}

/** 获取电池当前的状态，共有4种状态*/
func batteryState() -> String {
    let device = UIDevice.current
    if device.batteryState == UIDevice.BatteryState.unknown {
        return "unknown"
    } else if device.batteryState == UIDevice.BatteryState.unplugged {
        return "unplugged"
    } else if device.batteryState == UIDevice.BatteryState.charging {
        return "charging"
    } else if device.batteryState == UIDevice.BatteryState.full {
        return "full"
    }
    return ""
}

/** 获取当前语言*/
func deviceLanguage() -> String {
    return Locale.preferredLanguages[0]
}

/** 判断iPhoneX以后机型*/
func isiPhoneXLater() ->Bool {
    let screenHeight = UIScreen.main.nativeBounds.size.height
    if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
        return true
    }
    return false
}



// 参考资料：https://www.jianshu.com/p/d920885d6a02


