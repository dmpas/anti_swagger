#Использовать logos

Перем Лог Экспорт;

Перем Пути Экспорт;
Перем ПоддерживаемыеМетоды Экспорт;
Перем ВыходынеПараметры Экспорт;
Перем ВходныеПараметры Экспорт;
Перем ПутьККаталогу Экспорт;
Перем ИмяРасширения Экспорт;

Перем ПрефиксРасширения;
Перем ИмяСервиса;

Процедура СформироватьИсходникиРасширения() Экспорт

	ИмяСервиса = "oas2сfe";
	ПрефиксРасширения = ИмяРасширения + "_";
	
	СтруктураЗаполнения = Новый Структура;
	
	СтруктураЗаполнения.Вставить("Язык", Добавить_Язык());
	СтруктураЗаполнения.Вставить("Роль", Добавить_Роль());
	СтруктураЗаполнения.Вставить("Сервис", Добавить_Сервис());	
	СтруктураЗаполнения.Вставить("ОбщийМодуль_Контроллер", Добавить_ОбщийМодуль("КОНТРОЛЛЕР", СтруктураЗаполнения.Сервис));
	СтруктураЗаполнения.Вставить("ОбщийМодуль_Модель", Добавить_ОбщийМодуль("МОДЕЛЬ", СтруктураЗаполнения.Сервис));
	СтруктураЗаполнения.Вставить("ОбщийМодуль_Представление", Добавить_ОбщийМодуль("ПРЕДСТАВЛЕНИЕ", СтруктураЗаполнения.Сервис));
		
	СтруктураЗаполнения.Вставить("Конфигурация", Добавить_Конфигурацию(СтруктураЗаполнения));	
	
	Добавить_ОписаниеЗагрузки(СтруктураЗаполнения);	

КонецПроцедуры

Функция Добавить_Язык()
	
	путь_Языка = "\Languages\Русский.xml";	
	СоздатьКаталог(ПутьККаталогу + "\Languages");
	
	ЯЗЫК_УИД = Строка(Новый УникальныйИдентификатор);
	
	СтруктураПараметров = Новый Структура();
	СтруктураПараметров.Вставить("ЯЗЫК_УИД", ЯЗЫК_УИД);
	
	Шаблон = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_Язык");
	
	ЗаписатьФайлПоПути(ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон, СтруктураПараметров), ПутьККаталогу + путь_Языка);
		
	Возврат СтруктураПараметров;	
	
КонецФункции

Функция Добавить_Роль()
		
	РОЛЬ_ИМЯ = ПрефиксРасширения + "mainRole";
	РОЛЬ_УИД = Строка(Новый УникальныйИдентификатор);
	
	путь_Роли = "\Roles\" + РОЛЬ_ИМЯ + ".xml";	
	СоздатьКаталог(ПутьККаталогу + "\Roles");
	
	СтруктураПараметров = Новый Структура();
	СтруктураПараметров.Вставить("РОЛЬ_ИМЯ", РОЛЬ_ИМЯ);
	СтруктураПараметров.Вставить("РОЛЬ_УИД", РОЛЬ_УИД);
	
	Шаблон = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_Роль");
	
	ЗаписатьФайлПоПути(ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон, СтруктураПараметров), ПутьККаталогу + путь_Роли);
	
	Возврат СтруктураПараметров;	
	
КонецФункции

Функция Добавить_Сервис()
	
	ПолноеИмяСервиса = ПрефиксРасширения + ИмяСервиса;
	
	ПутьСервиса = "\HTTPServices\" + ПолноеИмяСервиса + ".xml";
	
	СоздатьКаталог(ПутьККаталогу + "\HTTPServices");
	
	СтруктураВозврата = Новый Структура;
	МассивВозврата = Новый Массив;
	ОписанияШаблонов = "";
	
	Для каждого Шаблон Из Пути Цикл
		
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("ИдентифкаторОтбора", Шаблон.ИдентифкаторОтбора);
		
		НайденныеМетоды = ПоддерживаемыеМетоды.НайтиСтроки(СтруктураПоиска);
		
		ОписаниеМетодов = "";		
		МассивМетодов = Новый Массив;
		
		Для каждого Метод Из НайденныеМетоды Цикл
			
			Шаблон_Метод = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_Сервис_Метод");
			
			СтруктураМетода = Новый Структура;
			СтруктураМетода.Вставить("МЕТОД_УИД", Метод.Идентификатор);
			СтруктураМетода.Вставить("МЕТОД_ИМЯ", ВРЕГ(Метод.ИмяМетода));
			СтруктураМетода.Вставить("МЕТОД_СИНОНИМ", ВРЕГ(Метод.СинонимМетода));
			СтруктураМетода.Вставить("МЕТОД_КОММЕНТАРИЙ", ВРЕГ(Метод.КомментарийМетода));
			СтруктураМетода.Вставить("МЕТОД_МЕТОД", ВРЕГ(Метод.ИмяМетода));
			СтруктураМетода.Вставить("МЕТОД_ИМЯ_ФУНКЦИИ", ВРЕГ(Шаблон.НаименованиеШаблона) + "_" + ВРЕГ(Метод.ИмяМетода));
			
			ЗаполненыйМетод = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Метод, СтруктураМетода);
			
			МассивМетодов.Добавить(СтруктураМетода);
			
			ОписаниеМетодов = ОписаниеМетодов + ЗаполненыйМетод;
			
		КонецЦикла;
		
		Шаблон_Шаблон = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_Сервис_Шаблон");
		
		СтруктураШаблона = Новый Структура;
		СтруктураШаблона.Вставить("ШАБЛОН_УИД", Шаблон.ИдентифкаторОтбора);
		СтруктураШаблона.Вставить("ШАБЛОН_ИМЯ",  ВРЕГ(Шаблон.НаименованиеШаблона));
		СтруктураШаблона.Вставить("ШАБЛОН_СИНОНИМ", ВРЕГ(Шаблон.НаименованиеШаблона));
		СтруктураШаблона.Вставить("ШАБЛОН_КОММЕНТАРИЙ", ВРЕГ(Шаблон.НаименованиеШаблона));
		СтруктураШаблона.Вставить("ШАБЛОН_ПУБЛИКАЦИЯ", Шаблон.Путь);
		СтруктураШаблона.Вставить("ШАБЛОН_МЕТОДЫ", ОписаниеМетодов);
		
		ЗаполненыйШаблон = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Шаблон, СтруктураШаблона);
		
		СтруктураШаблона.Вставить("ШАБЛОН_МАССИВ_МЕТОДОВ", МассивМетодов);
		
		МассивВозврата.Добавить(СтруктураШаблона);
		
		ОписанияШаблонов = ОписанияШаблонов + ЗаполненыйШаблон;
		
	КонецЦикла;
	
	ИдентификаторСервиса = Строка(Новый УникальныйИдентификатор);
	
	Шаблон_Сервис = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_Сервис_Сервис");
	
	СтруктураСервиса = Новый Структура;
	СтруктураСервиса.Вставить("СЕРВИС_УИД", ИдентификаторСервиса);
	СтруктураСервиса.Вставить("СЕРВИС_ИМЯ", ПолноеИмяСервиса);
	СтруктураСервиса.Вставить("СЕРВИС_СИНОНИМ", ВРег(ПолноеИмяСервиса));
	СтруктураСервиса.Вставить("СЕРВИС_КОММЕНТАРИЙ", ВРег(ИмяСервиса));
	СтруктураСервиса.Вставить("СЕРВИС_ПУБЛИКАЦИЯ", ИмяСервиса);
	СтруктураСервиса.Вставить("СЕРВИС_ШАБЛОНЫ", ОписанияШаблонов);
	
	ЗаписатьФайлПоПути(ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Сервис, СтруктураСервиса), ПутьККаталогу + ПутьСервиса); 
	
	СтруктураВозврата = СтруктураСервиса;
	СтруктураВозврата.Вставить("СЕРВИС_МАССИВ_ШАБЛОНОВ", МассивВозврата);
	
	Добавить_Сервис_Модуль(СтруктураВозврата);
	
	Возврат СтруктураВозврата;
	
КонецФункции

Процедура Добавить_Сервис_Модуль(Знач СтруктураВходящихПарметров)
	
	Префикс = ПрефиксРасширения;
	
	СтруктураСервиса = СтруктураВходящихПарметров;
		
	Если НЕ ТипЗнч(СтруктураСервиса) = Тип("Структура") Тогда 
		Возврат;
	КонецЕсли;
	
	СЕРВИС_ИМЯ = Неопределено;
	СтруктураСервиса.Свойство("СЕРВИС_ИМЯ", СЕРВИС_ИМЯ);
	Если НЕ ЗначениеЗаполнено(СЕРВИС_ИМЯ) Тогда 
		Возврат;
	КонецЕсли;
	
	МассивШаблонов = Неопределено;
	СтруктураСервиса.Свойство("СЕРВИС_МАССИВ_ШАБЛОНОВ", МассивШаблонов);
	
	Если НЕ ТипЗнч(МассивШаблонов) = Тип("Массив") Тогда 		
		Возврат;		
	КонецЕсли;	
	
	ОписаниеМодуля = "";
	
	Для каждого Шаблон Из МассивШаблонов Цикл
		
		МассивМетодов = Неопределено;
		Шаблон.Свойство("ШАБЛОН_МАССИВ_МЕТОДОВ", МассивМетодов);
		Если НЕ ТипЗнч(МассивМетодов) = Тип("Массив") Тогда 		
			Продолжить;		
		КонецЕсли;
		
		Для каждого Метод Из МассивМетодов Цикл
			
			Шаблон_Шаблон_Метод = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Модуль_Сервиса_Функция");
			
			СтруктураПараметров = Новый Структура;
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ОПИСАНИЕ", СформироватьОписание_ФУНКЦИЯ_МОДУЛЬ_СЕРВИСА(Шаблон, Метод));
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ИМЯ", Метод.МЕТОД_ИМЯ_ФУНКЦИИ);
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ВХОДЯЩИЕПАРАМЕТРЫ", "Запрос");
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ЭКСПОРТ", "");
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ТЕЛО", "Возврат " + Префикс + "КОНТРОЛЛЕР." + Метод.МЕТОД_ИМЯ_ФУНКЦИИ + "(Запрос)");
			
			ЗаполенныйШаблон = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Шаблон_Метод, СтруктураПараметров);
			
			ОписаниеМодуля = ОписаниеМодуля + ЗаполенныйШаблон;
			
		КонецЦикла;		
		
	КонецЦикла;
	
	ПутьМодуля = "\HTTPServices\" + СЕРВИС_ИМЯ + "\Ext\Module.bsl";
	СоздатьКаталог(ПутьККаталогу + "\HTTPServices\" + СЕРВИС_ИМЯ);
	СоздатьКаталог(ПутьККаталогу + "\HTTPServices\" + СЕРВИС_ИМЯ + "\Ext");
	
	ЗаписатьФайлПоПути(ОписаниеМодуля, ПутьККаталогу + ПутьМодуля);
	
КонецПроцедуры

Функция Добавить_ОбщийМодуль(ТипМодуля, Знач СтруктураСервиса)
	
	СоздатьКаталог(ПутьККаталогу + "\CommonModules");
	
	МОДУЛЬ_ИМЯ = ПрефиксРасширения + ТипМодуля;
	МОДУЛЬ_УИД = Строка(Новый УникальныйИдентификатор);
	
	путь_Модуля = "\CommonModules\" + МОДУЛЬ_ИМЯ + ".xml";	
	
	ИсходнаяСтруктура_СтруктураПараметров = Новый Структура;
	ИсходнаяСтруктура_СтруктураПараметров.Вставить("ОБЩИЙМОДУЛЬ_ТИП", ТипМодуля);
	ИсходнаяСтруктура_СтруктураПараметров.Вставить("ОБЩИЙМОДУЛЬ_УИД", МОДУЛЬ_УИД);
	ИсходнаяСтруктура_СтруктураПараметров.Вставить("ОБЩИЙМОДУЛЬ_ИМЯ", МОДУЛЬ_ИМЯ);
	ИсходнаяСтруктура_СтруктураПараметров.Вставить("ОБЩИЙМОДУЛЬ_СИНОНИМ", СтрЗаменить(МОДУЛЬ_ИМЯ, "_", " "));
	ИсходнаяСтруктура_СтруктураПараметров.Вставить("ОБЩИЙМОДУЛЬ_КОММЕНТАРИЙ", СтрЗаменить(МОДУЛЬ_ИМЯ, "_", " "));

	СтруктураПараметров = Новый Структура;
	Для каждого Эл Из ИсходнаяСтруктура_СтруктураПараметров Цикл
		СтруктураПараметров.Вставить(Эл.Ключ, Эл.Значение);				
		СтруктураПараметров.Вставить(Эл.Ключ + "_" + ТипМодуля, Эл.Значение);		
	КонецЦикла;
	
	Шаблон = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_ОбщийМодуль");
	
	РезультатЗаполнения = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон, СтруктураПараметров);
	
	ЗаписатьФайлПоПути(РезультатЗаполнения, ПутьККаталогу + путь_Модуля); 
	
	Добавить_ОбщийМодуль_Модуль(СтруктураПараметров, СтруктураСервиса);
	
	Возврат СтруктураПараметров;
	
КонецФункции

Процедура Добавить_ОбщийМодуль_Модуль(Знач СтруктураПараметров, СтруктураСервиса)
	
	Префикс = ПрефиксРасширения;
	
	МОДУЛЬ_ИМЯ = Неопределено;
	СтруктураПараметров.Свойство("ОБЩИЙМОДУЛЬ_ИМЯ", МОДУЛЬ_ИМЯ);
	Если НЕ ЗначениеЗаполнено(МОДУЛЬ_ИМЯ) Тогда 
		Возврат;
	КонецЕсли;	
	
	МОДУЛЬ_ТИП = Неопределено;
	СтруктураПараметров.Свойство("ОБЩИЙМОДУЛЬ_ТИП", МОДУЛЬ_ТИП);
	
	МассивШаблонов = Неопределено;
	СтруктураСервиса.Свойство("СЕРВИС_МАССИВ_ШАБЛОНОВ", МассивШаблонов);
	
	Если НЕ ТипЗнч(МассивШаблонов) = Тип("Массив") Тогда 		
		Возврат;		
	КонецЕсли;	
	
	ОписаниеМодуля = ИнициализироватьТекстМодуля(МОДУЛЬ_ТИП);
	
	Для каждого Шаблон Из МассивШаблонов Цикл
		
		Если МОДУЛЬ_ТИП = "ПРЕДСТАВЛЕНИЕ" Тогда 
			Прервать;
		КонецЕсли;
		
		МассивМетодов = Неопределено;
		Шаблон.Свойство("ШАБЛОН_МАССИВ_МЕТОДОВ", МассивМетодов);
		Если НЕ ТипЗнч(МассивМетодов) = Тип("Массив") Тогда 		
			Продолжить;		
		КонецЕсли;
		
		Для каждого Метод Из МассивМетодов Цикл
			
			Шаблон_Шаблон_Метод = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Модуль_Сервиса_Функция");
			
			СтруктураПараметров = Новый Структура;
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ОПИСАНИЕ", СформироватьОписание_ФУНКЦИЯ_МОДУЛЬ_ОБЩИЙ(Шаблон, Метод, МОДУЛЬ_ТИП));
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ИМЯ", Метод.МЕТОД_ИМЯ_ФУНКЦИИ);
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ВХОДЯЩИЕПАРАМЕТРЫ", СформироватьВходящиеПараметры_ФУНКЦИЯ_МОДУЛЬ_ОБЩИЙ(Шаблон, Метод, МОДУЛЬ_ТИП));
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ЭКСПОРТ", "Экспорт");			
			СтруктураПараметров.Вставить("ФУНКЦИЯ_ТЕЛО", СформироватьТело_ФУНКЦИЯ_МОДУЛЬ_ОБЩИЙ(Шаблон, Метод, МОДУЛЬ_ТИП));
			
			ЗаполенныйШаблон = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Шаблон_Метод, СтруктураПараметров);
			
			ОписаниеМодуля = ОписаниеМодуля + ЗаполенныйШаблон;
			
		КонецЦикла;		
		
	КонецЦикла;			
	
	ПутьМодуля = "\CommonModules\" + МОДУЛЬ_ИМЯ + "\Ext\Module.bsl";
	СоздатьКаталог(ПутьККаталогу + "\CommonModules\" + МОДУЛЬ_ИМЯ);
	СоздатьКаталог(ПутьККаталогу + "\CommonModules\" + МОДУЛЬ_ИМЯ + "\Ext");
	
	ЗаписатьФайлПоПути(ОписаниеМодуля, ПутьККаталогу + ПутьМодуля);
	
КонецПроцедуры

Функция ИнициализироватьТекстМодуля(ТипМодуля)
	
	Если ТипМодуля = "КОНТРОЛЛЕР" Тогда 
		Возврат ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Модуль_Общий_КОНТРОЛЛЕР");
	ИначеЕсли ТипМодуля = "МОДЕЛЬ" Тогда 
		Возврат ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Модуль_Общий_МОДЕЛЬ");
	ИначеЕсли ТипМодуля = "ПРЕДСТАВЛЕНИЕ" Тогда 
		Возврат ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Модуль_Общий_ПРЕДСТАВЛЕНИЕ");
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

Функция Добавить_Конфигурацию(Знач СтруктураВходящихПарметров)

	путь_Шаблона = "\Configuration.xml";
	
	ШаблонКонфигурации = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Конфигурация_Поставка");
	
	Для каждого Эл Из СтруктураВходящихПарметров Цикл
		
		ШаблонКонфигурации = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(ШаблонКонфигурации, Эл.Значение);		
		
	КонецЦикла;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("РАСШИРЕНИЕ_УИД", Строка(Новый УникальныйИдентификатор));
	СтруктураПараметров.Вставить("РАСШИРЕНИЕ_ИМЯ", ВРег(СтрЗаменить(ПрефиксРасширения, "_", "")));
	СтруктураПараметров.Вставить("РАСШИРЕНИЕ_СИНОНИМ", ВРег(СтрЗаменить(ПрефиксРасширения, "_", "")));
	СтруктураПараметров.Вставить("РАСШИРЕНИЕ_ПРЕФИКС", ПрефиксРасширения);
	
	ЗаписатьФайлПоПути(ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(ШаблонКонфигурации, СтруктураПараметров), ПутьККаталогу + путь_Шаблона);
	
	Возврат СтруктураПараметров;	
	
КонецФункции

Процедура Добавить_ОписаниеЗагрузки(Знач СтруктураВходящихПарметров)
	
	ШаблонОписанияЗагрузки = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Поставка_Поставка");
	
	Для каждого Эл Из СтруктураВходящихПарметров Цикл
		
		ШаблонОписанияЗагрузки = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(ШаблонОписанияЗагрузки, Эл.Значение); 
		
	КонецЦикла;
	
	СтруктураСервиса = Неопределено;
	СтруктураВходящихПарметров.Свойство("Сервис", СтруктураСервиса);
	
	ЗаполнитьДанныеСервиса(ШаблонОписанияЗагрузки, СтруктураСервиса);
	
	путь_Шаблона = "\ConfigDumpInfo.xml";
	
	ЗаписатьФайлПоПути(ШаблонОписанияЗагрузки, ПутьККаталогу + путь_Шаблона);	
	
КонецПроцедуры

Процедура ЗаполнитьДанныеСервиса(ОписаниеЗагрузки, СтруктураСервиса)
	
	Если НЕ ТипЗнч(СтруктураСервиса) = Тип("Структура") Тогда 
		Возврат;
	КонецЕсли;
	
	СЕРВИС_ИМЯ = Неопределено;
	СтруктураСервиса.Свойство("СЕРВИС_ИМЯ", СЕРВИС_ИМЯ);
	Если НЕ ЗначениеЗаполнено(СЕРВИС_ИМЯ) Тогда 
		Возврат;
	КонецЕсли;
	
	МассивШаблонов = Неопределено;
	СтруктураСервиса.Свойство("СЕРВИС_МАССИВ_ШАБЛОНОВ", МассивШаблонов);
	
	Если НЕ ТипЗнч(МассивШаблонов) = Тип("Массив") Тогда 		
		Возврат;		
	КонецЕсли;
	
	ОписаниеВсехМетодов = "";
	
	Для каждого Шаблон Из МассивШаблонов Цикл
		
		Шаблон_Шаблон_Метод = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Поставка_Сервис_Шаблон");
		
		Полное_ШАБЛОН_ИМЯ = "HTTPService." + СЕРВИС_ИМЯ + ".URLTemplate." + Шаблон.ШАБЛОН_ИМЯ;
		
		СтруктураПараметров = Новый Структура;
		СтруктураПараметров.Вставить("ШАБЛОН_МЕТОД_УИД", Шаблон.ШАБЛОН_УИД); 
		СтруктураПараметров.Вставить("ШАБЛОН_МЕТОД_ИМЯ", Полное_ШАБЛОН_ИМЯ); 
		
		ЗаполенныйШаблон = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Шаблон_Метод, СтруктураПараметров);
		
		ОписаниеВсехМетодов = ОписаниеВсехМетодов + ЗаполенныйШаблон;
		
		МассивМетодов = Неопределено;
		Шаблон.Свойство("ШАБЛОН_МАССИВ_МЕТОДОВ", МассивМетодов);
		Если НЕ ТипЗнч(МассивМетодов) = Тип("Массив") Тогда 		
			Продолжить;		
		КонецЕсли;
		
		Для каждого Метод Из МассивМетодов Цикл
			
			Шаблон_Шаблон_Метод = ШаблоныФайловКонфигурации.ПолучитьШаблонПоИмени("Поставка_Сервис_Шаблон");
			
			Полное_МЕТОД_ИМЯ = Полное_ШАБЛОН_ИМЯ + ".Method." + ВРЕГ(Метод.МЕТОД_ИМЯ);
			
			СтруктураПараметров = Новый Структура;
			СтруктураПараметров.Вставить("ШАБЛОН_МЕТОД_УИД", Метод.МЕТОД_УИД); 
			СтруктураПараметров.Вставить("ШАБЛОН_МЕТОД_ИМЯ", Полное_МЕТОД_ИМЯ);
			
			ЗаполенныйШаблон = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(Шаблон_Шаблон_Метод, СтруктураПараметров);
			
			ОписаниеВсехМетодов = ОписаниеВсехМетодов + ЗаполенныйШаблон;
			
		КонецЦикла;		
		
	КонецЦикла;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ОПИСАНИЕ_СЕРВИСА", ОписаниеВсехМетодов);
	
	ОписаниеЗагрузки = ШаблоныФайловКонфигурации.ЗаполнитьШаблонПараметрами(ОписаниеЗагрузки, СтруктураПараметров);	
	
КонецПроцедуры

Процедура ЗаписатьФайлПоПути(ДанныеДляЗаписи, ПутьДляЗаписи)
	
	Док = Новый ТекстовыйДокумент;
	Док.УстановитьТекст(ДанныеДляЗаписи);
	
	Док.Записать(ПутьДляЗаписи);	
	
КонецПроцедуры

Функция СформироватьОписание_ФУНКЦИЯ_МОДУЛЬ_СЕРВИСА(Знач СтруктураШаблона, Знач СтруктураМетода)
	Описание = "";
	
	МассивСтрок = Новый Массив;
	
	МассивСтрок.Добавить(СтруктураМетода.МЕТОД_КОММЕНТАРИЙ);
	МассивСтрок.Добавить("Входящие параметры:");
	
	ДополнитьМассивПараметровПоИдентифкаторам(МассивСтрок, СтруктураШаблона.ШАБЛОН_УИД);
	ДополнитьМассивПараметровПоИдентифкаторам(МассивСтрок, СтруктураМетода.МЕТОД_УИД);
	
	Счетчик = 0;	
	Для каждого Эл Из МассивСтрок Цикл
		Счетчик = Счетчик + 1;
		Описание = Описание + "// " + Эл;		
		Если НЕ Счетчик = МассивСтрок.Количество() Тогда 
			Описание = Описание + Символы.ПС;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Описание;
КонецФункции

Функция СформироватьОписание_ФУНКЦИЯ_МОДУЛЬ_ОБЩИЙ(Знач СтруктураШаблона, Знач СтруктураМетода, ТипМодуля)
	
	Описание = "";
	
	МассивСтрок = Новый Массив;
	
	МассивСтрок.Добавить(СтруктураМетода.МЕТОД_КОММЕНТАРИЙ);
	МассивСтрок.Добавить("Входящие параметры:");
	
	ДополнитьМассивПараметровПоИдентифкаторам(МассивСтрок, СтруктураШаблона.ШАБЛОН_УИД);
	ДополнитьМассивПараметровПоИдентифкаторам(МассивСтрок, СтруктураМетода.МЕТОД_УИД);
	
	Счетчик = 0;	
	Для каждого Эл Из МассивСтрок Цикл
		Счетчик = Счетчик + 1;
		Описание = Описание + "// " + Эл;		
		Если НЕ Счетчик = МассивСтрок.Количество() Тогда 
			Описание = Описание + Символы.ПС;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Описание;	
	
КонецФункции

Функция СформироватьТело_ФУНКЦИЯ_МОДУЛЬ_ОБЩИЙ(Знач СтруктураШаблона, Знач СтруктураМетода, ТипМодуля)
	
	Тело = "";
	Префикс = ПрефиксРасширения;
	
	Если ТипМодуля = "КОНТРОЛЛЕР" Тогда
		
		Тело = "Параметры_УРЛ = Получить_Параметры_УРЛ(Запрос);
			|	Параметры_Запроса = Получить_Параметры_Запроса(Запрос);
			|	Параметры_Заголовки = Получить_Параметры_Заголовки(Запрос);
			|	Параметры_Тело = Получить_Параметры_Тело(Запрос);
			|	Возврат " + Префикс + "МОДЕЛЬ." + СтруктураМетода.МЕТОД_ИМЯ_ФУНКЦИИ + "(Параметры_Запроса, Параметры_УРЛ, Параметры_Заголовки, Параметры_Тело)";	
		
	ИначеЕсли ТипМодуля = "МОДЕЛЬ" Тогда
		Тело = "СтруктураОтвета = Новый Структура;
			|	КодСостояния = 200;
			|	ПричинаСостояния = ""ОК"";
			|
			|	Возврат " + Префикс + "ПРЕДСТАВЛЕНИЕ.ПодготовитьОтвет(СтруктураОтвета, КодСостояния, ПричинаСостояния);";		
		
	ИначеЕсли ТипМодуля = "ПРЕДСТАВЛЕНИЕ" Тогда		
		Тело = "";		
	Иначе
		Тело = "";
	КонецЕсли;
	
	Возврат Тело;
	
КонецФункции

Функция СформироватьВходящиеПараметры_ФУНКЦИЯ_МОДУЛЬ_ОБЩИЙ(Знач СтруктураШаблона, Знач СтруктураМетода, ТипМодуля)
	
	СтрокаПараметров = "";
	
	Если ТипМодуля = "КОНТРОЛЛЕР" Тогда
		СтрокаПараметров = "Запрос";		
	ИначеЕсли ТипМодуля = "МОДЕЛЬ" Тогда
		СтрокаПараметров = "ПраметрыЗапроса, ПараметрыУРЛ, Заголовки, Тело = Неопределено";
	ИначеЕсли ТипМодуля = "ПРЕДСТАВЛЕНИЕ" Тогда
		СтрокаПараметров = "СтруктураОтвета, КодСостояния = 200, ПричинаСостояния = """"";
	Иначе
		СтрокаПараметров = "";
	КонецЕсли;
	
	Возврат СтрокаПараметров;
	
КонецФункции

Процедура ДополнитьМассивПараметровПоИдентифкаторам(МассивСтрок, Идентифкатор)

	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ИдентифкаторОтбора", Идентифкатор);
	
	НайденныеСтроки = ВходныеПараметры.НайтиСтроки(СтруктураПоиска);
	
	Для каждого Эл Из НайденныеСтроки Цикл
		
		СтрокаПараметра = "- " + Эл.Параметр;
		Если Эл.ТипПараметра = "path" Тогда 
			СтрокаПараметра = СтрокаПараметра + " [ПараметрыURL] - ";
		ИначеЕсли Эл.ТипПараметра = "query" Тогда
			СтрокаПараметра = СтрокаПараметра + " [ПараметрыЗапроса] - ";
		Иначе
			СтрокаПараметра = СтрокаПараметра + " ";
		КонецЕсли;
		
		СтрокаПараметра = СтрокаПараметра + Эл.Описание;		
		
		МассивСтрок.Добавить(СтрокаПараметра);
		
	КонецЦикла;
	
КонецПроцедуры
