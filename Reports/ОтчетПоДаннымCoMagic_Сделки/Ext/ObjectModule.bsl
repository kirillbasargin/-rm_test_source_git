﻿
#Область ПрограммныйИнтерфейс

Процедура СформироватьОтчет(Результат, КомпоновщикНастроек, ДанныеРасшифровки) Экспорт
			
	УстановитьПривилегированныйРежим(Истина);
	
	СхемаКомпоновкиДанных = ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();
	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;
		
	Результат.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЗаявкиНаСделку.Запрос КАК Запрос,
	|	ЗаявкиНаСделку.Проект КАК Проект,
	|	Сделки.ДатаСозданияСделки КАК Сделки,
	|	Сделки.ЗаявкаНаСделку КАК Сделка
	|ПОМЕСТИТЬ ВТ_ЗаявкиНаСделку
	|ИЗ
	|	РегистрСведений.ЗаявкиНаСделку КАК ЗаявкиНаСделку
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Сделки КАК Сделки
	|		ПО ЗаявкиНаСделку.Заявка = Сделки.ЗаявкаНаСделку
	|ГДЕ
	|	НЕ Сделки.СтатусСделки = ЗНАЧЕНИЕ(Перечисление.СтатусыСделокСправочник.Расторгнута)
	|	И Сделки.ДатаСозданияСделки МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ЗаявкиНаСделку.Проект = &Проект
	|	И ЗаявкиНаСделку.Запрос = &Предмет
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Запрос
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВЫРАЗИТЬ(Взаимодействия.Взаимодействие КАК Документ.ТелефонныйЗвонок) КАК Взаимодействие,
	|	Взаимодействия.Проект КАК Проект,
	|	Взаимодействия.Предмет КАК Предмет,
	|	ВЫРАЗИТЬ(Взаимодействия.Контакт КАК Справочник.Клиенты) КАК Клиент,
	|	Взаимодействия.ДатаВзаимодействия КАК ДатаПервичногоЗвонкаГПТ
	|ПОМЕСТИТЬ ВТ_ПервичныеЗвонки
	|ИЗ
	|	РегистрСведений.Взаимодействия КАК Взаимодействия
	|ГДЕ
	|	Взаимодействия.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВзаимодействий.Завершено)
	|	И Взаимодействия.ГруппаОтветственного = &ГруппаГПТ
	|	И Взаимодействия.АктивностьВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипАктивностиВзаимодействия.Первичное)
	|	И Взаимодействия.ТипВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипыВзаимодействий.ТелефонныйЗвонок)
	|	И Взаимодействия.Предмет В
	|			(ВЫБРАТЬ
	|				ВТ_ЗаявкиНаСделку.Запрос
	|			ИЗ
	|				ВТ_ЗаявкиНаСделку КАК ВТ_ЗаявкиНаСделку)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Предмет,
	|	Взаимодействие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫРАЗИТЬ(Взаимодействия.Взаимодействие КАК Документ.ТелефонныйЗвонок) КАК Взаимодействие,
	|	Взаимодействия.Предмет КАК Предмет,
	|	Взаимодействия.Проект КАК Проект,
	|	Взаимодействия.ДатаВзаимодействия КАК ДатаВторичногоЗвонкаГПТ
	|ПОМЕСТИТЬ ВТ_ВторичныеЗвонки
	|ИЗ
	|	РегистрСведений.Взаимодействия КАК Взаимодействия
	|ГДЕ
	|	Взаимодействия.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВзаимодействий.Завершено)
	|	И Взаимодействия.ГруппаОтветственного = &ГруппаГПТ
	|	И НЕ Взаимодействия.АктивностьВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипАктивностиВзаимодействия.Первичное)
	|	И Взаимодействия.ТипВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипыВзаимодействий.ТелефонныйЗвонок)
	|	И Взаимодействия.Предмет В
	|			(ВЫБРАТЬ
	|				ВТ_ПервичныеЗвонки.Предмет
	|			ИЗ
	|				ВТ_ПервичныеЗвонки КАК ВТ_ПервичныеЗвонки)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Предмет,
	|	Взаимодействие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПараметрыЗапросаЛинейный.РасшифровкаИсточниковПриходаКлиента КАК ИсточникРекламы,
	|	ПараметрыЗапросаЛинейный.ПервоначальныйОбъект КАК ПервоначальныйОбъект,
	|	ПараметрыЗапросаЛинейный.Запрос КАК Запрос
	|ПОМЕСТИТЬ ВТ_ПараметрыЗапросаДляЗвонков
	|ИЗ
	|	РегистрСведений.ПараметрыЗапросаЛинейный КАК ПараметрыЗапросаЛинейный
	|ГДЕ
	|	ПараметрыЗапросаЛинейный.Регистратор В
	|			(ВЫБРАТЬ
	|				ВТ_ЗаявкиНаСделку.Запрос
	|			ИЗ
	|				ВТ_ЗаявкиНаСделку КАК ВТ_ЗаявкиНаСделку)
	|	И ПараметрыЗапросаЛинейный.Активность
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Запрос
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеCallTracking.Сайт КАК Сайт,
	|	ДанныеCallTracking.РекламнаяКампания КАК ИсточникCoMagic,
	|	ДанныеCallTracking.Запрос КАК Запрос,
	|	ДанныеCallTracking.Взаимодействие КАК Взаимодействие
	|ПОМЕСТИТЬ ВТ_ДанныеCallTracking
	|ИЗ
	|	РегистрСведений.ДанныеCallTracking КАК ДанныеCallTracking
	|ГДЕ
	|	(ДанныеCallTracking.Запрос, ДанныеCallTracking.Взаимодействие) В
	|			(ВЫБРАТЬ
	|				ВТ_ПервичныеЗвонки.Предмет,
	|				ВТ_ПервичныеЗвонки.Взаимодействие
	|			ИЗ
	|				ВТ_ПервичныеЗвонки КАК ВТ_ПервичныеЗвонки)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Запрос,
	|	Взаимодействие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеCallTracking.Сайт КАК Сайт,
	|	ДанныеCallTracking.РекламнаяКампания КАК ИсточникCoMagic,
	|	ДанныеCallTracking.Запрос КАК Запрос,
	|	ДанныеCallTracking.Взаимодействие КАК Взаимодействие
	|ПОМЕСТИТЬ ВТ_ДанныеCallTrackingДляВторичныхЗвонков
	|ИЗ
	|	РегистрСведений.ДанныеCallTracking КАК ДанныеCallTracking
	|ГДЕ
	|	(ДанныеCallTracking.Запрос, ДанныеCallTracking.Взаимодействие) В
	|			(ВЫБРАТЬ
	|				ВТ_ВторичныеЗвонки.Предмет,
	|				ВТ_ВторичныеЗвонки.Взаимодействие
	|			ИЗ
	|				ВТ_ВторичныеЗвонки КАК ВТ_ВторичныеЗвонки)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Запрос,
	|	Взаимодействие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫРАЗИТЬ(Взаимодействия.Взаимодействие КАК Документ.Встреча) КАК Взаимодействие,
	|	Взаимодействия.Предмет КАК Предмет,
	|	Взаимодействия.Проект КАК Проект,
	|	ВЫРАЗИТЬ(Взаимодействия.Контакт КАК Справочник.Клиенты) КАК Клиент,	
	|	Взаимодействия.ДатаВзаимодействия КАК ПервичноеПосещениеФилиала
	|ПОМЕСТИТЬ ВТ_ПервичныеВстречи
	|ИЗ
	|	РегистрСведений.Взаимодействия КАК Взаимодействия
	|ГДЕ
	|	Взаимодействия.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВзаимодействий.Завершено)
	|	И Взаимодействия.ГруппаОтветственного В (&ГруппаФилиал, &ГруппаЗемляРозница, &ГруппаЦО, &ГруппаКоммерческаяНедвижимость)
	|	И Взаимодействия.АктивностьВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипАктивностиВзаимодействия.Первичное)
	|	И Взаимодействия.ТипВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипыВзаимодействий.Встреча)
	|	И Взаимодействия.Предмет В
	|			(ВЫБРАТЬ
	|				ВТ_ЗаявкиНаСделку.Запрос
	|			ИЗ
	|				ВТ_ЗаявкиНаСделку КАК ВТ_ЗаявкиНаСделку)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Предмет,
	|	Взаимодействие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫРАЗИТЬ(Взаимодействия.Взаимодействие КАК Документ.Встреча) КАК Взаимодействие,
	|	Взаимодействия.Предмет КАК Предмет,
	|	Взаимодействия.Проект КАК Проект,
	|	Взаимодействия.ДатаВзаимодействия КАК ВторичноеПосещениеФилиала
	|ПОМЕСТИТЬ ВТ_ВторичныеВстречи
	|ИЗ
	|	РегистрСведений.Взаимодействия КАК Взаимодействия
	|ГДЕ
	|	Взаимодействия.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВзаимодействий.Завершено)
	|	И Взаимодействия.ГруппаОтветственного В (&ГруппаФилиал, &ГруппаЗемляРозница, &ГруппаЦО, &ГруппаКоммерческаяНедвижимость)
	|	И НЕ Взаимодействия.АктивностьВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипАктивностиВзаимодействия.Первичное)
	|	И Взаимодействия.ТипВзаимодействия = ЗНАЧЕНИЕ(Перечисление.ТипыВзаимодействий.Встреча)
	|	И Взаимодействия.Предмет В
	|			(ВЫБРАТЬ
	|				ВТ_ПервичныеЗвонки.Предмет
	|			ИЗ
	|				ВТ_ПервичныеЗвонки КАК ВТ_ПервичныеЗвонки)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Предмет,
	|	Взаимодействие
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ЗаявкиНаСделку.Запрос КАК Предмет,
	|	ВТ_ЗаявкиНаСделку.Сделка КАК Сделка,
	|	ВТ_ЗаявкиНаСделку.Проект КАК Проект,
	|	ВТ_ЗаявкиНаСделку.Сделки КАК Сделки,
	|	ЕСТЬNULL(ВТ_ПервичныеЗвонки.ДатаПервичногоЗвонкаГПТ, ДАТАВРЕМЯ(1, 1, 1)) КАК ДатаПервичногоЗвонкаГПТ,
	|	ЕСТЬNULL(ВТ_ПервичныеВстречи.Клиент, ЗНАЧЕНИЕ(Справочник.Клиенты.ПустаяСсылка)) КАК Клиент,
	|	ЕСТЬNULL(ВТ_ПараметрыЗапросаДляЗвонков.ПервоначальныйОбъект, ЗНАЧЕНИЕ(Справочник.Проекты.ПустаяСсылка)) КАК ПервоначальныйОбъект,
	|	ЕСТЬNULL(ВТ_ДанныеCallTracking.Сайт, ЗНАЧЕНИЕ(Справочник.ПараметрыПолученияОбращенийComagic.ПустаяСсылка)) КАК Сайт,
	|	ЕСТЬNULL(ВТ_ПараметрыЗапросаДляЗвонков.ИсточникРекламы, ЗНАЧЕНИЕ(Справочник.РасшифровкаИсточниковПриходаКлиента.ПустаяСсылка)) КАК ИсточникРекламы,
	|	ЕСТЬNULL(ВТ_ДанныеCallTracking.ИсточникCoMagic, ЗНАЧЕНИЕ(Справочник.РекламныеКампании.ПустаяСсылка)) КАК ИсточникCoMagic,
	|	ЕСТЬNULL(ВТ_ПервичныеВстречи.ПервичноеПосещениеФилиала, ДАТАВРЕМЯ(1, 1, 1)) КАК ПервичноеПосещениеФилиала
	|ПОМЕСТИТЬ ВТ_ДанныеПоПервичнымЗвонкамИВстречам
	|ИЗ
	|	ВТ_ЗаявкиНаСделку КАК ВТ_ЗаявкиНаСделку
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПервичныеЗвонки КАК ВТ_ПервичныеЗвонки
	//|			ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПараметрыЗапросаДляЗвонков КАК ВТ_ПараметрыЗапросаДляЗвонков
	//|			ПО ВТ_ПервичныеЗвонки.Предмет = ВТ_ПараметрыЗапросаДляЗвонков.Запрос
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДанныеCallTracking КАК ВТ_ДанныеCallTracking
	|			ПО ВТ_ПервичныеЗвонки.Предмет = ВТ_ДанныеCallTracking.Запрос
	|				И ВТ_ПервичныеЗвонки.Взаимодействие = ВТ_ДанныеCallTracking.Взаимодействие
	//|			ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПервичныеВстречи КАК ВТ_ПервичныеВстречи
	//|			ПО ВТ_ПервичныеЗвонки.Предмет = ВТ_ПервичныеВстречи.Предмет
	//|				И ВТ_ПервичныеЗвонки.ДатаПервичногоЗвонкаГПТ <= ВТ_ПервичныеВстречи.ПервичноеПосещениеФилиала
	|		ПО ВТ_ЗаявкиНаСделку.Запрос = ВТ_ПервичныеЗвонки.Предмет
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПервичныеВстречи КАК ВТ_ПервичныеВстречи
	|		ПО ВТ_ЗаявкиНаСделку.Запрос = ВТ_ПервичныеВстречи.Предмет
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ПараметрыЗапросаДляЗвонков КАК ВТ_ПараметрыЗапросаДляЗвонков
	|		ПО ВТ_ЗаявкиНаСделку.Запрос = ВТ_ПараметрыЗапросаДляЗвонков.Запрос	
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ПервичныеЗвонки.Предмет КАК Предмет,
	|	ВТ_ПервичныеЗвонки.Проект КАК Проект,
	|	ВТ_ВторичныеЗвонки.Взаимодействие КАК Взаимодействие,
	|	ВТ_ВторичныеЗвонки.ДатаВторичногоЗвонкаГПТ КАК ДатаВторичногоЗвонкаГПТ,
	|	ЕСТЬNULL(ВТ_ДанныеCallTrackingДляВторичныхЗвонков.ИсточникCoMagic, ЗНАЧЕНИЕ(Справочник.РекламныеКампании.ПустаяСсылка)) КАК ИсточникCoMagic
	|ПОМЕСТИТЬ ВТ_ДанныеПоВторичнымЗвонкам
	|ИЗ
	|	ВТ_ПервичныеЗвонки КАК ВТ_ПервичныеЗвонки
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ВторичныеЗвонки КАК ВТ_ВторичныеЗвонки
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДанныеCallTrackingДляВторичныхЗвонков КАК ВТ_ДанныеCallTrackingДляВторичныхЗвонков
	|			ПО ВТ_ВторичныеЗвонки.Предмет = ВТ_ДанныеCallTrackingДляВторичныхЗвонков.Запрос
	|				И ВТ_ВторичныеЗвонки.Взаимодействие = ВТ_ДанныеCallTrackingДляВторичныхЗвонков.Взаимодействие
	|		ПО ВТ_ПервичныеЗвонки.Предмет = ВТ_ВторичныеЗвонки.Предмет
	|			И (ВТ_ВторичныеЗвонки.ДатаВторичногоЗвонкаГПТ >= ВТ_ПервичныеЗвонки.ДатаПервичногоЗвонкаГПТ)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Предмет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеПоВторичнымЗвонкам.Предмет КАК Предмет,
	|	ВТ_ВторичныеВстречи.Взаимодействие КАК Взаимодействие,
	|	ВТ_ВторичныеВстречи.ВторичноеПосещениеФилиала КАК ВторичноеПосещениеФилиала
	|ПОМЕСТИТЬ ВТ_ДанныеПоВторичнымВстречам
	|ИЗ
	|	ВТ_ВторичныеВстречи КАК ВТ_ВторичныеВстречи
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ДанныеПоВторичнымЗвонкам КАК ВТ_ДанныеПоВторичнымЗвонкам
	|		ПО (ВТ_ДанныеПоВторичнымЗвонкам.Предмет = ВТ_ВторичныеВстречи.Предмет)
	|			И (ВТ_ДанныеПоВторичнымЗвонкам.ДатаВторичногоЗвонкаГПТ <= ВТ_ВторичныеВстречи.ВторичноеПосещениеФилиала)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеПоВторичнымЗвонкам.Предмет КАК Предмет,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВТ_ДанныеПоВторичнымЗвонкам.ДатаВторичногоЗвонкаГПТ) КАК ДатаВторичногоЗвонкаГПТ
	|ПОМЕСТИТЬ ВТ_КоличестваВторичныхЗвонков
	|ИЗ
	|	ВТ_ДанныеПоВторичнымЗвонкам КАК ВТ_ДанныеПоВторичнымЗвонкам
	|
	|СГРУППИРОВАТЬ ПО
	|	ВТ_ДанныеПоВторичнымЗвонкам.Предмет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеПоВторичнымВстречам.Предмет КАК Предмет,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВТ_ДанныеПоВторичнымВстречам.ВторичноеПосещениеФилиала) КАК ВторичноеПосещениеФилиала
	|ПОМЕСТИТЬ ВТ_КоличестваВторичныхВстреч
	|ИЗ
	|	ВТ_ДанныеПоВторичнымВстречам КАК ВТ_ДанныеПоВторичнымВстречам
	|
	|СГРУППИРОВАТЬ ПО
	|	ВТ_ДанныеПоВторичнымВстречам.Предмет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ВТ_КоличестваВторичныхЗвонков.ДатаВторичногоЗвонкаГПТ) КАК МаксимумВторичныхЗвонков
	|ПОМЕСТИТЬ ВТ_МаксимумВторичныхЗвонков
	|ИЗ
	|	ВТ_КоличестваВторичныхЗвонков КАК ВТ_КоличестваВторичныхЗвонков
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МАКСИМУМ(ВТ_КоличестваВторичныхВстреч.ВторичноеПосещениеФилиала) КАК МаксимумВторичныхВстреч
	|ПОМЕСТИТЬ ВТ_МаксимумВторичныхВстреч
	|ИЗ
	|	ВТ_КоличестваВторичныхВстреч КАК ВТ_КоличестваВторичныхВстреч
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВТ_ДанныеПоВторичнымВстречам.Предмет КАК Предмет,
	|	ВТ_ДанныеПоВторичнымВстречам.Взаимодействие КАК Взаимодействие,
	|	ВТ_ДанныеПоВторичнымВстречам.ВторичноеПосещениеФилиала КАК ДатаВзаимодействия,
	|	ВТ_ДанныеПоВторичнымВстречам.ВторичноеПосещениеФилиала КАК ВторичноеПосещениеФилиала
	|ИЗ
	|	ВТ_ДанныеПоВторичнымВстречам КАК ВТ_ДанныеПоВторичнымВстречам
	|
	|УПОРЯДОЧИТЬ ПО
	|	ВТ_ДанныеПоВторичнымВстречам.ВторичноеПосещениеФилиала
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВТ_ДанныеПоВторичнымЗвонкам.Предмет КАК Предмет,
	|	ВТ_ДанныеПоВторичнымЗвонкам.Взаимодействие КАК Взаимодействие,
	|	ВТ_ДанныеПоВторичнымЗвонкам.ДатаВторичногоЗвонкаГПТ КАК ДатаВзаимодействия,
	|	ВТ_ДанныеПоВторичнымЗвонкам.ДатаВторичногоЗвонкаГПТ КАК ДатаВторичногоЗвонкаГПТ,
	|	ВТ_ДанныеПоВторичнымЗвонкам.ИсточникCoMagic КАК ИсточникCoMagic
	|ИЗ
	|	ВТ_ДанныеПоВторичнымЗвонкам КАК ВТ_ДанныеПоВторичнымЗвонкам
	|
	|УПОРЯДОЧИТЬ ПО
	|	ВТ_ДанныеПоВторичнымЗвонкам.ДатаВторичногоЗвонкаГПТ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_МаксимумВторичныхЗвонков.МаксимумВторичныхЗвонков + ВТ_МаксимумВторичныхВстреч.МаксимумВторичныхВстреч КАК ДопКолонок_Всего,
	|	ВТ_МаксимумВторичныхЗвонков.МаксимумВторичныхЗвонков КАК ДопКолонок_Звонков,
	|	ВТ_МаксимумВторичныхВстреч.МаксимумВторичныхВстреч КАК ДопКолонок_Встреч
	|ИЗ
	|	ВТ_МаксимумВторичныхЗвонков КАК ВТ_МаксимумВторичныхЗвонков,
	|	ВТ_МаксимумВторичныхВстреч КАК ВТ_МаксимумВторичныхВстреч
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.Предмет КАК Предмет,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.Сделка КАК Сделка,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.ДатаПервичногоЗвонкаГПТ КАК ДатаПервичногоЗвонкаГПТ,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.Клиент КАК Клиент,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.Проект КАК Проект,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.ПервоначальныйОбъект КАК ПервоначальныйОбъект,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.Сайт КАК Сайт,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.ИсточникРекламы КАК ИсточникРекламы,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.ИсточникCoMagic КАК ИсточникCoMagic,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.ПервичноеПосещениеФилиала КАК ПервичноеПосещениеФилиала,
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам.Сделки КАК Сделки
	|ИЗ
	|	ВТ_ДанныеПоПервичнымЗвонкамИВстречам КАК ВТ_ДанныеПоПервичнымЗвонкамИВстречам";
	
	Запрос.УстановитьПараметр("ГруппаГПТ", Справочники.ГруппыПользователей.НайтиПоНаименованию("ГПТ", Истина));
	Запрос.УстановитьПараметр("ГруппаЗемляРозница", Справочники.ГруппыПользователей.НайтиПоНаименованию("Земля розница", Истина));
	Запрос.УстановитьПараметр("ГруппаКоммерческаяНедвижимость", Справочники.ГруппыПользователей.НайтиПоНаименованию("Коммерческая Недвижимость", Истина));
	Запрос.УстановитьПараметр("ГруппаФилиал", Справочники.ГруппыПользователей.НайтиПоНаименованию("Филиал", Истина));
	Запрос.УстановитьПараметр("ГруппаЦО", Справочники.ГруппыПользователей.НайтиПоНаименованию("Центральный офис", Истина));
	
	пПериод = Настройки.ПараметрыДанных.Элементы.Найти("Период");
	Если НЕ пПериод = Неопределено И пПериод.Использование Тогда
		Запрос.УстановитьПараметр("НачалоПериода", пПериод.Значение.ДатаНачала);
		Запрос.УстановитьПараметр("КонецПериода", пПериод.Значение.ДатаОкончания);		
	КонецЕсли;
	
	пПроект = Настройки.ПараметрыДанных.Элементы.Найти("Проект");
	Если НЕ пПроект = Неопределено И пПроект.Использование Тогда
		Запрос.УстановитьПараметр("Проект", пПроект.Значение);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ЗаявкиНаСделку.Проект = &Проект", "");
	КонецЕсли;	
	
	пПредмет = Настройки.ПараметрыДанных.Элементы.Найти("Предмет");
	Если НЕ пПредмет = Неопределено И пПредмет.Использование Тогда
		Запрос.УстановитьПараметр("Предмет", пПредмет.Значение);
	Иначе
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "И ЗаявкиНаСделку.Запрос = &Предмет", "");
	КонецЕсли;	
			
	РезультатПакет = Запрос.ВыполнитьПакет();
	Если НЕ РезультатПакет.Количество() Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеCoMagic = РезультатПакет[РезультатПакет.ВГраница()].Выгрузить();
	ДанныеДопКолонок = РезультатПакет[РезультатПакет.ВГраница() - 1].Выгрузить();
	ДанныеПоВторичнымЗвонкам = РезультатПакет[РезультатПакет.ВГраница() - 2].Выгрузить();
	ДанныеПоВторичнымВстречам = РезультатПакет[РезультатПакет.ВГраница() - 3].Выгрузить();
	
	ВнешниеНаборыДанных = Новый Структура; 
	
	тзДанные = Новый ТаблицаЗначений;			
	тзДанные.Колонки.Добавить("Предмет", Новый ОписаниеТипов("ДокументСсылка.Запрос")); 
	тзДанные.Колонки.Добавить("Сделка", Новый ОписаниеТипов("ДокументСсылка.ЗаявкаНаСделку"));
	тзДанные.Колонки.Добавить("ДатаПервичногоЗвонкаГПТ", Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));	
	тзДанные.Колонки.Добавить("Клиент", Новый ОписаниеТипов("СправочникСсылка.Клиенты"));	
	тзДанные.Колонки.Добавить("Проект", Новый ОписаниеТипов("СправочникСсылка.Проекты"));
	тзДанные.Колонки.Добавить("ПервоначальныйОбъект", Новый ОписаниеТипов("СправочникСсылка.Проекты"));	
	тзДанные.Колонки.Добавить("Сайт", Новый ОписаниеТипов("СправочникСсылка.ПараметрыПолученияОбращенийComagic"));
	тзДанные.Колонки.Добавить("ИсточникРекламы", Новый ОписаниеТипов("СправочникСсылка.РасшифровкаИсточниковПриходаКлиента"));
	тзДанные.Колонки.Добавить("ИсточникCoMagic", Новый ОписаниеТипов("СправочникСсылка.РекламныеКампании"), "Источник CoMagic");	
	тзДанные.Колонки.Добавить("ПервичноеПосещениеФилиала", Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
	тзДанные.Колонки.Добавить("Сделки", Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
	
	тзДанные = ?(НЕ ДанныеCoMagic.Количество(), тзДанные, ДанныеCoMagic);
			
	ЗаполнитьНаборыДопКолонок(ДанныеДопКолонок, тзДанные, ДанныеПоВторичнымЗвонкам, ДанныеПоВторичнымВстречам, СхемаКомпоновкиДанных, Настройки);
	
	ВнешниеНаборыДанных.Вставить("ДанныеCoMagic", тзДанные);
				
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных, ДанныеРасшифровки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(Результат);	
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
			
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СформироватьОтчет(ДокументРезультат, КомпоновщикНастроек, ДанныеРасшифровки);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьНаборыДопКолонок(ДанныеДопКолонок, тзДанные, ДанныеПоВторичнымЗвонкам, ДанныеПоВторичнымВстречам, СхемаКомпоновкиДанных, Настройки)
	
	Если НЕ ДанныеДопКолонок.Количество() 
		ИЛИ НЕ тзДанные.Количество() Тогда
		Возврат;	
	КонецЕсли;
	
	СтрокаДанных = ДанныеДопКолонок[0];	
	ДопКолонок_Звонков = СтрокаДанных.ДопКолонок_Звонков;	
	ДопКолонок_Встреч = СтрокаДанных.ДопКолонок_Встреч;
	
	Для Индекс = 1 По ДопКолонок_Звонков Цикл
		тзДанные.Колонки.Добавить("ВторичныйЗвонок" + Индекс, Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)), "Вторичный звонок " + Индекс);
		тзДанные.Колонки.Добавить("ИсточникCoMagic" + Индекс, Новый ОписаниеТипов("СправочникСсылка.РекламныеКампании"), "Источник CoMagic " + Индекс);
	КонецЦикла; 
	
	Для Индекс = 1 По ДопКолонок_Встреч Цикл
		тзДанные.Колонки.Добавить("ВторичноеПосещениеФилиала" + Индекс, Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)), "Вторичное посещение филиала " + Индекс);
	КонецЦикла; 	
	           
    ДозаполнитьСтрокиДанных(тзДанные, ДопКолонок_Звонков, ДопКолонок_Встреч, ДанныеПоВторичнымЗвонкам, ДанныеПоВторичнымВстречам);
	
	Для Индекс = 1 По ДопКолонок_Звонков Цикл
		
		Поле = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1.Поля.Добавить(Тип("ПолеНабораДанныхСхемыКомпоновкиДанных"));
		
		Поле.Заголовок		= "Вторичный звонок " + Индекс;
		Поле.ПутьКДанным	= "ВторичныйЗвонок" + Индекс;
		Поле.Поле			= "ВторичныйЗвонок" + Индекс;
		Поле.ТипЗначения	= Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)); 
		
		ПолеРесурса = СхемаКомпоновкиДанных.ПоляИтога.Добавить(); 
		
		ПолеРесурса.Выражение	= "ВторичныйЗвонок" +  Индекс;  
		ПолеРесурса.ПутьКДанным	= "ВторичныйЗвонок" + Индекс; 
	
		ПолеРесурса.Группировки.Добавить("Сделка"); 
		ПолеРесурса.Группировки.Добавить("Предмет"); 
		
		ВыбранноеПоле = Настройки.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
		
		ВыбранноеПоле.Заголовок		= Поле.Заголовок;
		ВыбранноеПоле.Использование	= Истина; 
		ВыбранноеПоле.Поле			= Новый ПолеКомпоновкиДанных(Поле.Поле); 
		
		Поле = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1.Поля.Добавить(Тип("ПолеНабораДанныхСхемыКомпоновкиДанных"));
		
		Поле.Заголовок		= "Источник CoMagic " + Индекс;
		Поле.ПутьКДанным	= "ИсточникCoMagic" + Индекс;
		Поле.Поле			= "ИсточникCoMagic" + Индекс;
		Поле.ТипЗначения	= Новый ОписаниеТипов("СправочникСсылка.РекламныеКампании"); 
		
		ПолеРесурса = СхемаКомпоновкиДанных.ПоляИтога.Добавить(); 
		
		ПолеРесурса.Выражение	= "ИсточникCoMagic" +  Индекс;  
		ПолеРесурса.ПутьКДанным	= "ИсточникCoMagic" + Индекс; 
		
		ПолеРесурса.Группировки.Добавить("Сделка"); 
		ПолеРесурса.Группировки.Добавить("Предмет"); 
		
		ВыбранноеПоле = Настройки.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
		
		ВыбранноеПоле.Заголовок		= Поле.Заголовок;
		ВыбранноеПоле.Использование	= Истина; 
		ВыбранноеПоле.Поле			= Новый ПолеКомпоновкиДанных(Поле.Поле); 		
		
	КонецЦикла;
	
	Для Индекс = 1 По ДопКолонок_Встреч Цикл
		
		Поле = СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1.Поля.Добавить(Тип("ПолеНабораДанныхСхемыКомпоновкиДанных"));
		
		Поле.Заголовок		= "Вторичное посещение филиала " + Индекс;
		Поле.ПутьКДанным	= "ВторичноеПосещениеФилиала" + Индекс;
		Поле.Поле			= "ВторичноеПосещениеФилиала" + Индекс;
		Поле.ТипЗначения	= Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)); 
		
		ПолеРесурса = СхемаКомпоновкиДанных.ПоляИтога.Добавить(); 
		
		ПолеРесурса.Выражение	= "ВторичноеПосещениеФилиала" +  Индекс;  
		ПолеРесурса.ПутьКДанным	= "ВторичноеПосещениеФилиала" + Индекс; 
		
		ПолеРесурса.Группировки.Добавить("Сделка"); 
		ПолеРесурса.Группировки.Добавить("Предмет"); 
		
		ВыбранноеПоле = Настройки.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
		
		ВыбранноеПоле.Заголовок		= Поле.Заголовок;
		ВыбранноеПоле.Использование	= Истина; 
		ВыбранноеПоле.Поле			= Новый ПолеКомпоновкиДанных(Поле.Поле); 
	
	КонецЦикла;
		
КонецПроцедуры

Процедура ДозаполнитьСтрокиДанных(тзДанные, ДопКолонок_Звонков, ДопКолонок_Встреч, ДанныеПоВторичнымЗвонкам, ДанныеПоВторичнымВстречам)
	
	Для Индекс = 0 По тзДанные.Количество() - 1 Цикл
		СтрокаТз = тзДанные[Индекс];
		Предмет = СтрокаТз.Предмет;
		ДатаПервичногоЗвонкаГПТ = СтрокаТз.ДатаПервичногоЗвонкаГПТ;
		ПервичноеПосещениеФилиала = СтрокаТз.ПервичноеПосещениеФилиала;
		
		ВторичныеДанныеПоПредмету = НайтиВторичныеДанныеПоПредмету(Предмет, ДатаПервичногоЗвонкаГПТ, ДанныеПоВторичнымЗвонкам);
		Если ВторичныеДанныеПоПредмету.Количество() <= ДопКолонок_Звонков Тогда  		
			Для Счетчик = 1 По ВторичныеДанныеПоПредмету.Количество() Цикл			
				ИмяКолонкиЗвонка = "ВторичныйЗвонок" + Счетчик;
				ИмяКолонкиИсточника = "ИсточникCoMagic" + Счетчик;
				СтрокаТз[ИмяКолонкиЗвонка] = ВторичныеДанныеПоПредмету[Счетчик - 1].ДатаВзаимодействия; 
				СтрокаТз[ИмяКолонкиИсточника] = ВторичныеДанныеПоПредмету[Счетчик - 1].ИсточникCoMagic; 
			КонецЦикла;
		КонецЕсли;
		
		ВторичныеДанныеПоПредмету = НайтиВторичныеДанныеПоПредмету(Предмет, ПервичноеПосещениеФилиала, ДанныеПоВторичнымВстречам);
		Если ВторичныеДанныеПоПредмету.Количество() <= ДопКолонок_Встреч Тогда  		
			Для Счетчик = 1 По ВторичныеДанныеПоПредмету.Количество() Цикл			
				ИмяКолонкиВстречи = "ВторичноеПосещениеФилиала" + Счетчик;
				СтрокаТз[ИмяКолонкиВстречи] = ВторичныеДанныеПоПредмету[Счетчик - 1].ДатаВзаимодействия;  
			КонецЦикла;
		КонецЕсли;
	КонецЦикла; 
	
КонецПроцедуры

Функция НайтиВторичныеДанныеПоПредмету(Предмет, ДатаПервичногоВзаимодействия, ТаблицаДанныхПоиска)

	МассивСтрок = Новый Массив;
	
	Если НЕ ЗначениеЗаполнено(ДатаПервичногоВзаимодействия) Тогда
		Возврат МассивСтрок;
	КонецЕсли;
	
	СтрокиДанных = ТаблицаДанныхПоиска.НайтиСтроки(Новый Структура("Предмет", Предмет));
	Для каждого СтрокаДанных Из СтрокиДанных Цикл
		Если СтрокаДанных.ДатаВзаимодействия > ДатаПервичногоВзаимодействия Тогда
			МассивСтрок.Добавить(СтрокаДанных);
		КонецЕсли;
	КонецЦикла;
	
	Возврат МассивСтрок;
	
КонецФункции

#КонецОбласти

