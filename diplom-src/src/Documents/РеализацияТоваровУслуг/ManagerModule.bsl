
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	#Область ПрограммныйИнтерфейс 
	
	//++АА: Добавление процедуры печати	
	Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
		
		// Акт оказанных услуг
		КомандаПечати = КомандыПечати.Добавить();
		КомандаПечати.Идентификатор = "Акт";
		КомандаПечати.Представление = НСтр("ru = 'Акт'");
		КомандаПечати.Порядок = 5;
		
	КонецПроцедуры
	
	Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
		
		ПечатнаяФорма = УправлениеПечатью.СведенияОПечатнойФорме(КоллекцияПечатныхФорм, "Акт");
		Если ПечатнаяФорма <> Неопределено Тогда
			ПечатнаяФорма.ТабличныйДокумент = ПечатьАкта(МассивОбъектов, ОбъектыПечати);
			ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Акт'");
			ПечатнаяФорма.ПолныйПутьКМакету = "Документ.РеализацияТоваровУслуг.ПФ_MXL_Акт";
		КонецЕсли;
		
	КонецПроцедуры
	
	Функция ПечатьАкта(МассивОбъектов, ОбъектыПечати) Экспорт
		
		ТабличныйДокумент = Новый ТабличныйДокумент;
		ТабличныйДокумент.КлючПараметровПечати = "ПараметрыПечати_Акт";
		
		Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.РеализацияТоваровУслуг.ПФ_MXL_Акт");
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
		|	РеализацияТоваровУслуг.Номер КАК Номер,
		|	РеализацияТоваровУслуг.Дата КАК Дата,
		|	РеализацияТоваровУслуг.Организация КАК Организация,
		|	РеализацияТоваровУслуг.Контрагент КАК Контрагент,
		|	РеализацияТоваровУслуг.Договор КАК Договор,
		|	РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента,
		|	РеализацияТоваровУслуг.Ответственный КАК Ответственный,
		|	РеализацияТоваровУслуг.Услуги.(
		|		НомерСтроки КАК НомерСтроки,
		|		Номенклатура КАК Номенклатура,
		|		Количество КАК Количество,
		|		Цена КАК Цена,
		|		Сумма КАК Сумма
		|	) КАК Услуги,
		|	ВКМ_ПодписиПечати.Печать КАК ПечатьОрганизации,
		|	ВКМ_ПодписиПечати.Подпись КАК ПодписьОтветственного
		|ИЗ
		|	Справочник.ВКМ_ПодписиПечати КАК ВКМ_ПодписиПечати
		|		ПРАВОЕ СОЕДИНЕНИЕ Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|		ПО (РеализацияТоваровУслуг.Организация = ВКМ_ПодписиПечати.Организация)
		|ГДЕ
		|	РеализацияТоваровУслуг.Ссылка В(&Ссылка)";
		
		Запрос.Параметры.Вставить("Ссылка", МассивОбъектов);
		Выборка = Запрос.Выполнить().Выбрать();
		
		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		Шапка = Макет.ПолучитьОбласть("Шапка");
		ОбластьУслугиШапка = Макет.ПолучитьОбласть("УслугиШапка");
		ОбластьУслуги = Макет.ПолучитьОбласть("Услуги");
		Подвал = Макет.ПолучитьОбласть("Подвал");
		ПодписьФаксимиле = Макет.ПолучитьОбласть("ПодписьФаксимиле");
				
		ВставлятьРазделительСтраниц = Ложь;
		Пока Выборка.Следующий() Цикл
			
			Если ВставлятьРазделительСтраниц Тогда
				ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;
			
			НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы +1;
			
			ТабличныйДокумент.Вывести(ОбластьЗаголовок);
			
			ХранилищеПодписи = Выборка.ПодписьОтветственного;
			ДвоичныеДанныеПодписи = ХранилищеПодписи.Получить();
			
			Если ДвоичныеДанныеПодписи <> Неопределено Тогда
				ПодписьФаксимиле.Рисунки.ПодписьОтветственного.Картинка = Новый Картинка(ДвоичныеДанныеПодписи);
			КонецЕсли;
			
			ХранилищеПечати = Выборка.ПечатьОрганизации;
			ДвоичныеДанныеПечати = ХранилищеПечати.Получить();
			
			Если ДвоичныеДанныеПечати <> Неопределено Тогда
				ПодписьФаксимиле.Рисунки.ПечатьОрганизации.Картинка = Новый Картинка(ДвоичныеДанныеПечати);
			КонецЕсли;
			
			Шапка.Параметры.Заполнить(Выборка);
					
			ТабличныйДокумент.Вывести(Шапка, Выборка.Уровень());	
			
			ТабличныйДокумент.Вывести(ОбластьУслугиШапка);
			ВыборкаУслуги = Выборка.Услуги.Выбрать();
			Пока ВыборкаУслуги.Следующий() Цикл
				ОбластьУслуги.Параметры.Заполнить(ВыборкаУслуги);
				ТабличныйДокумент.Вывести(ОбластьУслуги, ВыборкаУслуги.Уровень());
			КонецЦикла;
					
			ПараметрыПрописи = "рубль, рубля, рублей, м, Копейка, копейки, копеек, ж, 2";
			СуммаПрописная = ЧислоПрописью(Выборка.СуммаДокумента,"ДП = Истина",ПараметрыПрописи);
			Подвал.Параметры.Заполнить(Выборка);
			Подвал.Параметры.СуммаПрописная = СуммаПрописная;
			ТабличныйДокумент.Вывести(Подвал);	
					
			ВставлятьРазделительСтраниц = Истина;
			УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати, Выборка.Ссылка);
		КонецЦикла;
			
		ТабличныйДокумент.Вывести(ПодписьФаксимиле);	
		
		Возврат ТабличныйДокумент;
		
	КонецФункции
	//--АА

Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Если ПравоДоступа("Добавление", Метаданные.Документы.РеализацияТоваровУслуг) Тогда
		
        КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
        КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РеализацияТоваровУслуг.ПолноеИмя();
        КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.РеализацияТоваровУслуг);
        КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
		
	КонецЕсли;

	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#КонецЕсли