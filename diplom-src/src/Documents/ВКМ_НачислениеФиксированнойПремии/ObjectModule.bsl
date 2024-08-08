#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения) 
	
	Для Каждого Строка Из СписокСотрудников Цикл
		Движение = Движения.ВКМ_ДополнительныеНачисления.Добавить();
		Движение.Сторно = Ложь;
		Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ДополнительныеНачисления.ВКМ_ПремияФиксированная;
		Движение.ПериодРегистрации = Дата;
		Движение.Сотрудник = Строка.Сотрудник;
		Движение.Результат = Строка.СуммаПремии; 
		
		НДФЛ = Движение.Результат * 13 / 100;
				
		ДвижениеУдержания = Движения.ВКМ_Удержания.Добавить();
		ДвижениеУдержания.ПериодРегистрации = Дата;
		ДвижениеУдержания.ВидРасчета = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
		ДвижениеУдержания.Сотрудник = Строка.Сотрудник;
		ДвижениеУдержания.НДФЛ = НДФЛ;				
	КонецЦикла;	
	
	Движения.ВКМ_ДополнительныеНачисления.Записать(); 
	Движения.ВКМ_Удержания.Записать(); 
	
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записывать = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_ДополнительныеНачисления.Сотрудник КАК Сотрудник,
	               |	СУММА(ВКМ_ДополнительныеНачисления.Результат) КАК Начисления
	               |ПОМЕСТИТЬ ВТ_ДопНачисления
	               |ИЗ
	               |	РегистрРасчета.ВКМ_ДополнительныеНачисления КАК ВКМ_ДополнительныеНачисления
	               |ГДЕ
	               |	ВКМ_ДополнительныеНачисления.Регистратор = &Ссылка
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ВКМ_ДополнительныеНачисления.Сотрудник
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ВКМ_Удержания.Сотрудник КАК Сотрудник,
	               |	СУММА(ВКМ_Удержания.НДФЛ) КАК Удержания
	               |ПОМЕСТИТЬ ВТ_Удержания
	               |ИЗ
	               |	РегистрРасчета.ВКМ_Удержания КАК ВКМ_Удержания
	               |ГДЕ
	               |	ВКМ_Удержания.Регистратор = &Ссылка
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ВКМ_Удержания.Сотрудник
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	ВТ_ДопНачисления.Сотрудник КАК Сотрудник,
	               |	ВТ_ДопНачисления.Начисления КАК Начисления,
	               |	ВТ_Удержания.Удержания КАК Удержания
	               |ИЗ
	               |	ВТ_ДопНачисления КАК ВТ_ДопНачисления
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Удержания КАК ВТ_Удержания
	               |		ПО ВТ_ДопНачисления.Сотрудник = ВТ_Удержания.Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Сотрудник = Выборка.Сотрудник;
		Движение.Сумма = Выборка.Начисления - Выборка.Удержания;
		
	КонецЦикла;	
	
КонецПроцедуры

#КонецОбласти