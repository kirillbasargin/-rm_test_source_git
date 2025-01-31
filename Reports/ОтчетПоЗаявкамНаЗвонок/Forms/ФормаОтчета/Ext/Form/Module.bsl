﻿
&НаСервере
Функция ПолучитьТекстЗапроса(Вариант)
	
	Если ВариантОтчета = "СоЗвонкамиГрупировка" Или ВариантОтчета = "СоЗвонкамиБезГруппировки" Тогда //по звонкам
		Возврат "ВЫБРАТЬ РАЗРЕШЕННЫЕ
		        |	ЗаявкаНаЗвонок.Ссылка КАК Ссылка
		        |ПОМЕСТИТЬ ВТ_ПервичныеДанные
		        |ИЗ
		        |	Документ.ЗаявкаНаЗвонок КАК ЗаявкаНаЗвонок
		        |ГДЕ
		        |	НЕ ЗаявкаНаЗвонок.ЭтоТестоваяЗаявка
		        |	И НЕ ЗаявкаНаЗвонок.ПометкаУдаления
		        |	И ВЫБОР
		        |			КОГДА &ПериодНачало = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |					И &ПериодОкончание = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |				ТОГДА ИСТИНА
		        |			КОГДА &ПериодНачало = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |					И &ПериодОкончание <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |				ТОГДА ЗаявкаНаЗвонок.Дата <= &ПериодОкончание
		        |			КОГДА &ПериодНачало <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |					И &ПериодОкончание = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |				ТОГДА ЗаявкаНаЗвонок.Дата >= &ПериодНачало
		        |			ИНАЧЕ ЗаявкаНаЗвонок.Дата МЕЖДУ &ПериодНачало И &ПериодОкончание
		        |		КОНЕЦ
		        |
		        |ИНДЕКСИРОВАТЬ ПО
		        |	Ссылка
		        |;
		        |
		        |////////////////////////////////////////////////////////////////////////////////
		        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		        |	ИсторияЗвонков.ЗаявкаИнициатор КАК ЗаявкаИнициатор,
		        |	ИсторияЗвонков.ДлительностьВызова КАК ДлительностьВызова,
		        |	ИсторияЗвонков.ДлительностьРазговора КАК ДлительностьРазговора,
		        |	ИсторияЗвонков.ТипЗвонка КАК ТипЗвонка,
		        |	ИсторияЗвонков.ВидЗвонка КАК ВидЗвонка,
		        |	ИсторияЗвонков.Ответственный КАК Ответственный,
		        |	ИсторияЗвонков.НомерТелефона КАК НомерТелефона,
		        |	ИсторияЗвонков.Контакт КАК Контакт,
		        |	ИсторияЗвонков.ДатаНачалаЗвонка КАК ДатаНачалаЗвонка,
		        |	СоответствиеЗапросовЗвонкам.Запрос КАК Запрос
		        |ПОМЕСТИТЬ ВТ_История
		        |ИЗ
		        |	РегистрСведений.ИсторияЗвонков КАК ИсторияЗвонков
		        |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.СоответствиеЗапросовЗвонкам КАК СоответствиеЗапросовЗвонкам
		        |		ПО ИсторияЗвонков.ID_Звонка = СоответствиеЗапросовЗвонкам.ID_Звонка
		        |ГДЕ
		        |	ИсторияЗвонков.ЗаявкаИнициатор В
		        |			(ВЫБРАТЬ
		        |				ВТ_ПервичныеДанные.Ссылка КАК Ссылка
		        |			ИЗ
		        |				ВТ_ПервичныеДанные КАК ВТ_ПервичныеДанные)
		        |
		        |ИНДЕКСИРОВАТЬ ПО
		        |	ЗаявкаИнициатор
		        |;
		        |
		        |////////////////////////////////////////////////////////////////////////////////
		        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		        |	ПараметрыЗапроса.Регистратор КАК Регистратор,
		        |	ПараметрыЗапроса.ЗначениеСсылка КАК Стадия
		        |ПОМЕСТИТЬ ВТ_ЗапросСтадия
		        |ИЗ
		        |	РегистрСведений.ПараметрыЗапроса КАК ПараметрыЗапроса
		        |ГДЕ
		        |	ПараметрыЗапроса.Регистратор В
		        |			(ВЫБРАТЬ
		        |				ВТ_История.Запрос КАК Запрос
		        |			ИЗ
		        |				ВТ_История КАК ВТ_История)
		        |	И ПараметрыЗапроса.Параметр В
		        |			(ВЫБРАТЬ
		        |				ПараметрыЗапроса.Ссылка КАК Ссылка
		        |			ИЗ
		        |				Справочник.ПараметрыЗапроса КАК ПараметрыЗапроса
		        |			ГДЕ
		        |				ПараметрыЗапроса.Наименование = ""Стадия"")
		        |
		        |ИНДЕКСИРОВАТЬ ПО
		        |	Регистратор
		        |;
		        |
		        |////////////////////////////////////////////////////////////////////////////////
		        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
		        |	ПараметрыЗапроса.Регистратор КАК Регистратор,
		        |	ПараметрыЗапроса.ЗначениеСсылка КАК Статус
		        |ПОМЕСТИТЬ ВТ_ЗапросСтатус
		        |ИЗ
		        |	РегистрСведений.ПараметрыЗапроса КАК ПараметрыЗапроса
		        |ГДЕ
		        |	ПараметрыЗапроса.Регистратор В
		        |			(ВЫБРАТЬ
		        |				ВТ_История.Запрос КАК Запрос
		        |			ИЗ
		        |				ВТ_История КАК ВТ_История)
		        |	И ПараметрыЗапроса.Параметр В
		        |			(ВЫБРАТЬ
		        |				ПараметрыЗапроса.Ссылка КАК Ссылка
		        |			ИЗ
		        |				Справочник.ПараметрыЗапроса КАК ПараметрыЗапроса
		        |			ГДЕ
		        |				ПараметрыЗапроса.Наименование = ""Статус"")
		        |
		        |ИНДЕКСИРОВАТЬ ПО
		        |	Регистратор
		        |;
		        |
		        |////////////////////////////////////////////////////////////////////////////////
		        |ВЫБРАТЬ
		        |	ВТ_ПервичныеДанные.Ссылка КАК Ссылка,
		        |	ВТ_История.ДлительностьВызова КАК ДлительностьВызова,
		        |	ВТ_История.ДлительностьРазговора КАК ДлительностьРазговора,
		        |	ВТ_История.ТипЗвонка КАК ТипЗвонка,
		        |	ВТ_История.ВидЗвонка КАК ВидЗвонка,
		        |	ВТ_История.Ответственный КАК Ответственный1,
		        |	ВТ_История.НомерТелефона КАК НомерТелефона,
		        |	ВТ_История.Контакт КАК Контакт,
		        |	ВТ_ЗапросСтадия.Стадия КАК Стадия,
		        |	ВТ_ЗапросСтатус.Статус КАК Статус,
		        |	ВТ_История.ДатаНачалаЗвонка КАК ДатаНачалаЗвонка,
		        |	ВТ_История.Запрос КАК Запрос
		        |ИЗ
		        |	ВТ_ПервичныеДанные КАК ВТ_ПервичныеДанные
		        |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_История КАК ВТ_История
		        |			ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ЗапросСтатус КАК ВТ_ЗапросСтатус
		        |			ПО ВТ_История.Запрос = ВТ_ЗапросСтатус.Регистратор
		        |		ПО ВТ_ПервичныеДанные.Ссылка = ВТ_История.ЗаявкаИнициатор
		        |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ЗапросСтадия КАК ВТ_ЗапросСтадия
		        |		ПО ВТ_История.Запрос = ВТ_ЗапросСтадия.Регистратор
		        |
		        |УПОРЯДОЧИТЬ ПО
		        |	Ссылка,
		        |	ДатаНачалаЗвонка,
		        |	ДлительностьВызова
		        |ИТОГИ ПО
		        |	Ссылка";
	Иначе
		Возврат "ВЫБРАТЬ РАЗРЕШЕННЫЕ
		        |	ЗаявкаНаЗвонок.Ссылка КАК Ссылка
		        |ИЗ
		        |	Документ.ЗаявкаНаЗвонок КАК ЗаявкаНаЗвонок
		        |ГДЕ
		        |	НЕ ЗаявкаНаЗвонок.ЭтоТестоваяЗаявка
		        |	И НЕ ЗаявкаНаЗвонок.ПометкаУдаления
		        |	И ВЫБОР
		        |			КОГДА &ПериодНачало = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |					И &ПериодОкончание = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |				ТОГДА ИСТИНА
		        |			КОГДА &ПериодНачало = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |					И &ПериодОкончание <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |				ТОГДА ЗаявкаНаЗвонок.Дата <= &ПериодОкончание
		        |			КОГДА &ПериодНачало <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |					И &ПериодОкончание = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		        |				ТОГДА ЗаявкаНаЗвонок.Дата >= &ПериодНачало
		        |			ИНАЧЕ ЗаявкаНаЗвонок.Дата МЕЖДУ &ПериодНачало И &ПериодОкончание
		        |		КОНЕЦ"; 
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура СформироватьНаСервере(ТД, ПериодОтчета)
	
	ТД.Очистить();
	
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	
	Если ВариантОтчета = "СоЗвонкамиГрупировка" Тогда
		Макет = ОтчетОбъект.ПолучитьМакет("Макет");
	ИначеЕсли ВариантОтчета = "СоЗвонкамиБезГруппировки" Тогда
		Макет = ОтчетОбъект.ПолучитьМакет("Макет2");
	Иначе
		Макет = ОтчетОбъект.ПолучитьМакет("Макет1");
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ЗаявкаНаЗвонок.Ссылка КАК Ссылка
		|ПОМЕСТИТЬ ВТ_ПервичныеДанные
		|ИЗ
		|	Документ.ЗаявкаНаЗвонок КАК ЗаявкаНаЗвонок
		|ГДЕ
		|	НЕ ЗаявкаНаЗвонок.ЭтоТестоваяЗаявка
		|	И НЕ ЗаявкаНаЗвонок.ПометкаУдаления
		|	И ВЫБОР
		|			КОГДА &ПериодНачало = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|					И &ПериодОкончание = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|				ТОГДА ИСТИНА
		|			КОГДА &ПериодНачало = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|					И &ПериодОкончание <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|				ТОГДА ЗаявкаНаЗвонок.Дата <= &ПериодОкончание
		|			КОГДА &ПериодНачало <> ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|					И &ПериодОкончание = ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)
		|				ТОГДА ЗаявкаНаЗвонок.Дата >= &ПериодНачало
		|			ИНАЧЕ ЗаявкаНаЗвонок.Дата МЕЖДУ &ПериодНачало И &ПериодОкончание
		|		КОНЕЦ
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ИсторияЗвонков.ЗаявкаИнициатор КАК ЗаявкаИнициатор,
		|	МИНИМУМ(ИсторияЗвонков.ДатаНачалаЗвонка) КАК ДатаПервогоЗвонка
		|ИЗ
		|	РегистрСведений.ИсторияЗвонков КАК ИсторияЗвонков
		|ГДЕ
		|	ИсторияЗвонков.ЗаявкаИнициатор В
		|			(ВЫБРАТЬ
		|				ВТ_ПервичныеДанные.Ссылка КАК Ссылка
		|			ИЗ
		|				ВТ_ПервичныеДанные КАК ВТ_ПервичныеДанные)
		|
		|СГРУППИРОВАТЬ ПО
		|	ИсторияЗвонков.ЗаявкаИнициатор";
	
	Запрос.УстановитьПараметр("ПериодНачало", НачалоДня(ПериодОтчета.ДатаНачала));
	Запрос.УстановитьПараметр("ПериодОкончание", КонецДня(ПериодОтчета.ДатаОкончания));
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		ИсторияЗвонков = Неопределено;
	Иначе
		ИсторияЗвонков = Результат.Выгрузить();
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = ПолучитьТекстЗапроса(ВариантОтчета);
	
	Запрос.Параметры.Вставить("Период", КонецДня(ПериодОтчета.ДатаОкончания) + 1);
	Запрос.Параметры.Вставить("ПериодНачало", НачалоДня(ПериодОтчета.ДатаНачала));
	Запрос.Параметры.Вставить("ПериодОкончание", КонецДня(ПериодОтчета.ДатаОкончания));
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		ВывестиПустойОтчет(Макет, ТД, ПериодОтчета);
	Иначе
		ТД.АвтоМасштаб = Истина;
		ТД.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;
		ТД.ОтображатьГруппировки = Истина;
		
		ВывестиПустойОтчет(Макет, ТД, ПериодОтчета);
		
		Выборка = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам,);
		
		Пока Выборка.Следующий() Цикл
			
			Если ВариантОтчета = "СоЗвонкамиБезГруппировки" Тогда
				
				СписокСтрок = Новый Массив;
				Если ИсторияЗвонков <> Неопределено Тогда
					СписокСтрок = ИсторияЗвонков.НайтиСтроки(Новый Структура("ЗаявкаИнициатор", Выборка.Ссылка));
				КонецЕсли;
				
				ВыборкаРасшифровка = Выборка.Выбрать();
				Если ВыборкаРасшифровка.Количество() > 0 Тогда
					Пока ВыборкаРасшифровка.Следующий() Цикл
						Область = Макет.ПолучитьОбласть("СтрокаОсновнойТаблицы");
						ЗаполнитьЗначенияСвойств(Область.Параметры, Выборка.Ссылка);
						ЗаполнитьЗначенияСвойств(Область.Параметры, ВыборкаРасшифровка); //"ДатаНачалаЗвонка, ДлительностьВызова, ДлительностьРазговора, ТипЗвонка, ВидЗвонка, Ответственный, НомерТелефона, Клиент, Запрос, Стадия, Статус"
						
						Если СписокСтрок.Количество() > 0 Тогда
							Область.Параметры.ДатаПервогоЗвонка = СписокСтрок[0].ДатаПервогоЗвонка;
						КонецЕсли;
						ТД.Вывести(Область);
					КонецЦикла;
				Иначе
					Область = Макет.ПолучитьОбласть("СтрокаОсновнойТаблицы");
					ЗаполнитьЗначенияСвойств(Область.Параметры, Выборка.Ссылка);
					Если СписокСтрок.Количество() > 0 Тогда
						Область.Параметры.ДатаПервогоЗвонка = СписокСтрок[0].ДатаПервогоЗвонка;
					КонецЕсли;
					ТД.Вывести(Область);
				КонецЕсли;
			Иначе
				Область = Макет.ПолучитьОбласть("СтрокаОсновнойТаблицы");
				ЗаполнитьЗначенияСвойств(Область.Параметры, Выборка.Ссылка);
			
				Если ИсторияЗвонков <> Неопределено Тогда
					
					СписокСтрок = ИсторияЗвонков.НайтиСтроки(Новый Структура("ЗаявкаИнициатор", Выборка.Ссылка));
					
					Если СписокСтрок.Количество() > 0 Тогда
						Область.Параметры.ДатаПервогоЗвонка = СписокСтрок[0].ДатаПервогоЗвонка;
					КонецЕсли;
				КонецЕсли;
				
				ТД.Вывести(Область);
				
				ВыборкаРасшифровка = Выборка.Выбрать();
				
				Если ВыборкаРасшифровка.Количество() > 0 Тогда
					ТД.НачатьГруппуСтрок(, Истина);
					
					Область = Макет.ПолучитьОбласть("ШапкаРасшифровки");
					ТД.Вывести(Область);
					
					Пока ВыборкаРасшифровка.Следующий() Цикл
						
						Область = Макет.ПолучитьОбласть("СтрокаРасшифровки");
						ЗаполнитьЗначенияСвойств(Область.Параметры, ВыборкаРасшифровка);
						
						МассивОбластейДляПроверки = Новый Массив;
						МассивОбластейДляПроверки.Добавить(Область);
			
						Если Не ТД.ПроверитьВывод(МассивОбластейДляПроверки) Тогда
							ТД.ВывестиГоризонтальныйРазделительСтраниц();
							
							ОбластьШапка = Макет.ПолучитьОбласть("ШапкаОсновнойТаблицы");
							ТД.Вывести(ОбластьШапка);
							ОбластьШапка = Макет.ПолучитьОбласть("ШапкаРасшифровки");
							ТД.Вывести(ОбластьШапка);
						КонецЕсли; 
						
						ТД.Вывести(Область);
					КонецЦикла;
					ТД.ЗакончитьГруппуСтрок();
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ВывестиПустойОтчет(Макет, ТД, ПериодОтчета)
	
	Область = Макет.ПолучитьОбласть("Заголовок");
	ТД.Вывести(Область);
	Область = Макет.ПолучитьОбласть("ПустаяСтрока");
	ТД.Вывести(Область);
	
	Если ПериодОтчета.ДатаНачала = Дата(1,1,1) И ПериодОтчета.ДатаОкончания = Дата(1,1,1) Тогда
		//Параметры не выводим
	Иначе
		Область = Макет.ПолучитьОбласть("Параметры");
		
		Если ПериодОтчета.ДатаНачала = Дата(1,1,1) Тогда
			Область.Параметры.ПараметрПериод = " с " + Формат(ПериодОтчета.ДатаНачала, "ДФ=dd.MM.yyyy") + " по -";
		ИначеЕсли ПериодОтчета.ДатаОкончания = Дата(1,1,1) Тогда
			Область.Параметры.ПараметрПериод = " с - по " + Формат(ПериодОтчета.ДатаОкончания, "ДФ=dd.MM.yyyy");
		ИначеЕсли НачалоДня(ПериодОтчета.ДатаНачала) = НачалоДня(ПериодОтчета.ДатаОкончания) Тогда
			Область.Параметры.ПараметрПериод = " " + Формат(ПериодОтчета.ДатаОкончания, "ДФ=dd.MM.yyyy");
		Иначе
			Область.Параметры.ПараметрПериод = " с " + Формат(ПериодОтчета.ДатаНачала, "ДФ=dd.MM.yyyy") + " по " + Формат(ПериодОтчета.ДатаОкончания, "ДФ=dd.MM.yyyy");
		КонецЕсли;
		
		ТД.Вывести(Область);
		
		Область = Макет.ПолучитьОбласть("ПустаяСтрока");
		ТД.Вывести(Область);
	КонецЕсли;
	
	Область = Макет.ПолучитьОбласть("ШапкаОсновнойТаблицы");
	ТД.Вывести(Область);
	
КонецПроцедуры

&НаКлиенте
Процедура Сформировать(Команда)
	
	СформироватьНаСервере(ТД, ПериодОтчета);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекущаяДата = ТекущаяДата();
	
	ПериодОтчета.ДатаНачала = НачалоДня(НачалоДня(ТекущаяДата) - 1);
	ПериодОтчета.ДатаОкончания = НачалоДня(ТекущаяДата) - 1;
	
	ВариантОтчета = "СоЗвонкамиБезГруппировки";
	
КонецПроцедуры


&НаКлиенте
Процедура ВариантОтчетаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры


&НаКлиенте
Процедура ВариантОтчетаПриИзменении(Элемент)
	
	ТД = Новый ТабличныйДокумент;
	
КонецПроцедуры

