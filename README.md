# WeatherInfo

## Технологии

- Swift
- MVVW+Coordinator
- SwiftUI
- Async/Await
- SwiftyJSON
- Realm



## Реализованные функции:

- Сделан клон приложения погоды, использовался сервис openweathermap. Приложение умеет брать ваше текущее местоположение и показать текущую погоду. Так - же присутствуеть иконка текущей погоды (https://www.iconfinder.com - бесплатные иконки).
- Снизу сделана карусель, такая же как в нативном приложении которое показывает погоду для каждого часа (для следующих +6 часов), а так же отображаеться в карусели иконка погоды.
- Добавлен поиск, который при вводе названия города (первых символов), предлагает варианты (использовался сервис https://dadata.ru, там база увы только городов России), при выборе города будет переводить на новый экран и показывать текущую погоду в этом
городе.
- Добавлен под горизонтальную карусель которая показывает погоду для каждого часа, вертикальный список с погодой на неделю вперед (и график температурных диапазонов).
- Сделано кэширование погоды, если пользователь зашел без интернета (при помощи Realm).
- Добавленна проверка соединения пользователя при запуске, если интернет есть, делаеться запрос, если нет, то показываться ранее загруженные данные.
- Если интернета нет, то загружаться предыдущая текущая погода и сообщаеться пользователю насколько это устарелые данные, Пример: (10c (10ч назад)) интервалы: (1 min > 59 min) (1h > 23h) (>1d), при этом поиск городов недоступен.
- Сделанно 2 локализации этого приложения, если приложения на англ - показывает Фаренгейты, если на русском языке, то Цельсии

