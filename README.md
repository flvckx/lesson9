# lesson9
Читаем:
Раздел 5
Matt Neuburg - Programming iOS 7, 4th Edition - 2013
или
Раздел 18
Mark D., Nutting J., Topley K., Olsson F., LaMarche J. - Beginning iPhone Development Exploring the iOS SDK - 2014

И документы тоже изучаем
https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIResponder_Class/
https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/event_delivery_responder_chain/event_delivery_responder_chain.html
https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIControl_Class/
https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIEvent_Class/
https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/multitouch_background/multitouch_background.html 

Домашнее задание:<br/>
1. Просмотреть все проекты в папке Samples<br/>
2. В проекте Help:<br/>
    - создаем свой CircleGestureRecognizer, нужно реализовать жест рисования круга.<br/>
    - создаем свой AimGestureRecognizer, нужно реализовать жест рисования круга с точкой посередине<br/>
    - создаем свой SquareGestureRecognizer, нужно реализрвать жест рисования квадрата<br/>
3. Проект task1, создаем простую игру с помощью gesture recognizers и таймеров, правила:<br/>
    - Изначально есть 4 квадратных UIView с разными цветами<br/>
    - Изначально все UIView расположены вверху экрана<br/>
    - Каждая UIView движется вниз с разной скоростью (у первой UIView наибольшая скорость и последней наименьшая)<br/>
    - Каждая UIView реагирует на свой gesture recognizer, при срабатывании UIView возвращается в исходную позицию<br/>
    - Gesture recognizers: 1 - Single tap, 2 - Double tap, 3 - Swipe Up, 4 - Swipe Down<br/>
    - По истечению каждых 30 секунд увеличивать скорость игры<br/>
    - Когда одна из UIView достигает низа экрана - игра проиграна, выведите количество секунд в игре (это финальный счет)<br/>
    - Бонус: если на UIView сделан неправильный жест (жест для одной из трех остальных UIView) подвинуть лишний раз UIView вниз.<br/>
    - Бонус: по истечению каждых 30 секунд поменять UIView местами в случайном порядке<br/>
