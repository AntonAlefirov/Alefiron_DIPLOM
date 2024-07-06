
#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ПодсветкаСтрок();
	
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьСотрудников(Команда)
	
	ЗаполнитьСотрудниковНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСотрудниковНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_ФизическиеЛица.Ссылка КАК Сотрудник
	               |ИЗ
	               |	Справочник.ВКМ_ФизическиеЛица КАК ВКМ_ФизическиеЛица";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Объект.ОтпускаСотрудников.Очистить();
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрока = Объект.ОтпускаСотрудников.Добавить();
		НоваяСтрока.Сотрудник = Выборка.Сотрудник;
		
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьАнализГрафика(Команда)
	
	Адрес = ЗаписьДанныхДляДопформы();
	ПараметрыФормы = Новый Структура("Адрес", Адрес);
	
	ОткрытьФорму("Документ.ВКМ_ГрафикОтпусков.Форма.АнализГрафика", ПараметрыФормы, Элементы.ОтпускаСотрудников);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Функция ЗаписьДанныхДляДопформы()
	
	Возврат ПоместитьВоВременноеХранилище(Объект.ОтпускаСотрудников.Выгрузить(,"Сотрудник, ДатаНачала, ДатаОкончания"), 
	УникальныйИдентификатор);
	
КонецФункции 

&НаКлиенте
Процедура ОтпускаСотрудниковДатаОкончанияПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ОтпускаСотрудников.ТекущиеДанные;
	ТекущиеДанные.ВсегоДнейОтпуска = (НачалоДня(ТекущиеДанные.ДатаОкончания) - НачалоДня(ТекущиеДанные.ДатаНачала)) / (60*60*24);
	
	ПодсветкаСтрок();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтпускаСотрудниковДатаНачалаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ОтпускаСотрудников.ТекущиеДанные;
	ТекущиеДанные.ВсегоДнейОтпуска = (КонецДня(ТекущиеДанные.ДатаОкончания) - НачалоДня(ТекущиеДанные.ДатаНачала) - 86400) / (60*60*24);
	
	ПодсветкаСтрок();	
	
КонецПроцедуры

&НаСервере
Процедура ПодсветкаСтрок() 
	
	ТЗ = Объект.ОтпускаСотрудников.Выгрузить(,"Сотрудник, ВсегоДнейОтпуска");
	ТЗ.Свернуть("Сотрудник", "ВсегоДнейОтпуска");
	
	Для Каждого Колонка ИЗ ТЗ Цикл
		
		Если Колонка.ВсегоДнейОтпуска > 28 Тогда 
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрШаблон("Отпуск превышает 28 дней у сотрудника %1. И составляет %2 дней", Колонка.Сотрудник, Колонка.ВсегоДнейОтпуска));
		КонецЕсли;	
	КонецЦикла;	
	
	Оформление  = УсловноеОформление.Элементы.Добавить();
	Оформление.Использование = Истина;
	
	ПолеОформляемое1 = Оформление.Поля.Элементы.Добавить();
	ПолеОформляемое1.Поле = Новый ПолеКомпоновкиДанных("ОтпускаСотрудниковСотрудник");
	ПолеОформляемое2 = Оформление.Поля.Элементы.Добавить();
	ПолеОформляемое2.Поле = Новый ПолеКомпоновкиДанных("ОтпускаСотрудниковДатаНачала");
	ПолеОформляемое3 = Оформление.Поля.Элементы.Добавить();
	ПолеОформляемое3.Поле = Новый ПолеКомпоновкиДанных("ОтпускаСотрудниковДатаОкончания");
	
	Отбор = Оформление.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	Отбор.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ОтпускаСотрудников.ВсегоДнейОтпуска");
	Отбор.ПравоеЗначение = 28;
	Отбор.ВидСравнения = ВидСравненияКомпоновкиДанных.Больше;
	Отбор.Использование = Истина;
	Оформление.Оформление.УстановитьЗначениеПараметра("ЦветФона", WebЦвета.Аквамарин); 
	
КонецПроцедуры

#КонецОбласти


