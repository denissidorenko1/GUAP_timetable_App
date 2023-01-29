//
//  Logger.swift
//  GuapTimeTable
//
//  Created by Denis on 29.01.2023.
//

import Foundation
enum Logger {
    enum LogType: String {
        case warning = "Предупреждение"
        case error = "Ошибка"
        case fatal = "Фатальная ошибка"
    }

    struct Context {
        let file: String
        let function: String
        let line: String
        var description: String {
            return "\((file as NSString).lastPathComponent): \(line) \(function)"
        }
    }

    static func log(type: LogType, message: String, file: String=#file,
                    function: String=#function, line: Int=#line) {
        let context = Context(file: file, function: function, line: String(line))
        generateOutput(type: type, message: message, context: context)
    }

    // Нужно ли писать лог в файл? Может, писать в файл с контекстом, а выводить лишь короткое сообщение
    private static func generateOutput(type: LogType, message: String, context: Context?=nil) {
        let simpleMessage: String = "[\(type.rawValue)] \(message) "

        guard let context = context else {
            print(simpleMessage)
            return
        }
        let fullMessage = simpleMessage + context.description
        print(fullMessage)
    }
}
