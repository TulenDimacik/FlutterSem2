# Практические работы 1 и 2

## Создание Api с помощью conduit и приложения для него

<b>Цель работы:</b> Создать Api при помощи пакета coduit, а также приложение которое сможет принимать и обрабатывать API запросы.

Создаем Api.

Иерархия проекта и настройки приложения:

<img src="flutter_dio/assets/Screenshot_1.png" width=700 height=500>

Далее создаем модели и затем в терминале прописываем команды <i>conduit</i> для создания этих таблиц в базе данных, после чего в папке миграций должна появиться новая запись.


<img src="flutter_dio/assets/Screenshot_2.png" width=600 heigqht=500>


Далее переходим к созданию контпроллера для авторизации пользователя через токен.


<img src="flutter_dio/assets/Screenshot_3.png" width=900 height=500>


Затем прописываем контроллеры с методами CRUD для заметок и пользователей, которые будут почти идентичны. Методы get и post:


<img src="flutter_dio/assets/Screenshot_4.png" width=600 height=500>


Методы put и delete:


<img src="flutter_dio/assets/Screenshot_5.png" width=600 height=700>


После чего можно проверить работу непосредственно самой API.

<img src="flutter_dio/assets/Screenshot_6.png" width=600 height=250>

После того, как работа API полностью проверена можно приступать к разработке приложения. Для его создания нам понадобятся <i>Freezed, dio, get_it, bottomNavigationBar, searchDelegat</i>

Сначала прописываем в консоли команды для freezed, который поможет производить сериализацию и десериализацию данных в формат Json.

далее прописываем interceptor, который необходим для авторизации пользователей и хранения refresh token'a.


<img src="flutter_dio/assets/Screenshot_7.png" width=300 height=300>


Разрешения для экранов на синглтон, чтобы мы могли переходить на них.

<img src="flutter_dio/assets/Screenshot_8.png" width=600 height=500>


Вся логика взаимодействия с api прописана в cubit, для того чтобы удобно отправлять запросы использовался dio. Пример cubit:


<img src="flutter_dio/assets/Screenshot_9.png" width=1200 height=900>


После чего проверяем работу приложения


<img src="flutter_dio/assets/Screenshot_10.png" width=600 height=500>


<b>Вывод:</b> в ходе практической работы удалось Создать Api при помощи пакета coduit, а также приложение которое принимает и обрабатывает API запросы.


