//
//  Constants.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 15.03.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import Foundation

enum GlobalConstants {
    
    enum AlertMessages {
        static let emptyFields = "Введите логин и пароль."
        static let wrongCredentials = "Неверный логин или пароль."
        static let connectionIssues = "Не удалось получить данные с сервера."
        static let defaultAuthFail = "Не удалось авторизоваться."
        static let defaultUserInfoFail = "Не удалось получить информацию о пользователе."
        static let defaultNewsFail = "Не удалось получить список новостей."
        static let defaultEventsFail = "Не удалось получить список событий."
        static let defaultScheduleFail = "Не удалось получить актуальное расписание."
        static let chosenDayScheduleFail = "Не удалось получить список занятий в выбранный день."
        static let defaultLogoutFail = "Не удалось выйти из профиля."
        static let probablyWrongSMScode = "Неверный смс-код"
        static let unknownError = "Неизвестная ошибка."
        static let unknownReponseFromServer = "Не удалось прочитать ответ сервера"
        static let notAuthorised = "Сессия устарела. Попробуйте перезайти в профиль."
        static let noURLForWebinar = "Данный вебинар пока недоступен. Попробуйте позже."
        static let noURLForEvent = "Не удалось получить подробную инофрмацию о событии."
        static let chatPreview = "Не удалось обновить список чатов."
        static let couldntSendMessage = "Не удалось отправить сообщение."
        static let getContacts = "Не удалось получить список контактов."
        static let chatHistory = "Не удалось получить список сообщений."
        static let disciplineList = "Не удалось получить список дисциплин."
        static let disciplineDetails = "Не удалось получить информацию о дисциплине."
        static let libraryURL = "Не удалось авторизоваться в библиотеке."
        static let setNotificationsConfiguration = "Не удалось обновить настройки уведомлений."
        static let getNotificationsConfiguration = "Не удалось получить настройки уведомлений."
        static let notCheckedDisciplines = "Не удалось получить список дисциплин."
        static let serverSideProblem = "Проблема на сервере"
    }
}
