#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ,Режим)
	
	// регистр ВКМ_ДниОтпуска
	Движения.ВКМ_ДниОтпуска.Записывать = Истина;
	Для Каждого ТекСтрокаОтпускаСотрудников из ОтпускаСотрудников Цикл
		Движение = Движения.ВКМ_ДниОтпуска.Добавить();
		Движение.Период = Дата;
		Движение.Сотрудник = ТекСтрокаОтпускаСотрудников.Сотрудник;
		Движение.Дни = ТекСтрокаОтпускаСотрудников.ВсегоДнейОтпуска;
		Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Отпуск;
	КонецЦикла; 
	
	// регистр ВКМ_ГрафикиОтпусков
	Движения.ВКМ_ГрафикиОтпусков.Записывать = Истина;
	Для Каждого ТекСтрокаОтпускаСотрудников из ОтпускаСотрудников Цикл
		Движение = Движения.ВКМ_ГрафикиОтпусков.Добавить();
		Движение.Дата = Дата;
		Движение.Сотрудник = ТекСтрокаОтпускаСотрудников.Сотрудник;
		Движение.ДатаНачала = ТекСтрокаОтпускаСотрудников.ДатаНачала;
		Движение.ДатаОкончания = ТекСтрокаОтпускаСотрудников.ДатаОкончания;
		Движение.Год = Год;
		Движение.Регистратор = Ссылка;
	КонецЦикла;
 
КонецПроцедуры

#КонецОбласти

