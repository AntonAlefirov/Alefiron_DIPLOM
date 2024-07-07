## ИНСТРУКЦИЯ ПО НАЧАЛЬНОЙ НАСТРОЙКЕ

### Конфигурация позволяет планировать обслуживание сотрудниками оборудования и программ клиентов.

1. Менеджерам и специалистам добавлена возможность формирования документа «Обслуживание клиента» для планирования обслуживания сотрудниками оборудования и программ клиентов *(Добавленные объекты – Обслуживание клиентов – Обслуживание клиента)* с необходимым заполнением дополнительных полей:
Клиент;
Договор;
Специалист;
Дата проведения работ;
Время начала работ (план);
Время окончания работ (план);
Описание проблемы;
Комментарий;
и табличной части:
Описание работ;
Фактически потрачено часов;
Часы к оплате клиенту;

2. Менеджерам и специалистам добавлена возможность создания договоров вида «Абонентское обслуживание» (Добавленные объекты – Обслуживание клиентов – Договоры контрагентов) с необходимым заполнением дополнительных полей:
Дата начала
Дата окончания
Сумма абонентской платы
Стоимость часа работы специалиста;

3. Специалисту добавлена возможность создания отчета «Выработка специалистов» (Добавленные объекты – Отчеты), показывающего сколько часов за выбранный период отработал выбранный специалист и какая сумма ему за этот период начислена в виде процента от выплат клиента;

4. Кадровику-расчетчику необходимо внести сведения о подразделениях организации (Добавленные объекты – Подразделения), назначить каждому сотруднику соответствующее подразделение (Добавленные объекты – Физические лица);

5. Кадровику-расчетчику необходимо внести информацию в регистр сведений «Условия оплаты сотрудников» с указанием сотрудника, подразделения, оклада и процента премии от выполненных работ (Добавленные объекты – Расчет зарплаты).

6. Кадровику-расчетчику необходимо внести сведения о запланированных в году отпусках сотрудников (Добавленные объекты – Расчет зарплаты – График отпусков). Добавлен анализ графика отпусков (диаграмма Ганта) для отслеживания случаев наложения отпусков сотрудников;

7. Кадровику-расчетчику добавлена возможность создания отчетов (Добавленные объекты – Отчеты):
«Выработка специалистов», показывающий сколько часов за выбранный период отработал выбранный специалист и какая сумма ему за этот период начислена в виде процента от выплат клиента;
«Расчеты с сотрудниками», показывающий информацию о том, какие суммы начислены и выплачены каждому сотруднику за указанный период и задолженность на начало и на конец этого периода;
«Расход запланированных отпусков», показывающий сколько дней отпуска у сотрудника в выбранный период по плану и сколько дней он фактически был в отпуске;

8. Кадровику-расчетчику добавлен функционал расчета и выплаты зарплаты сотрудникам (Добавленные объекты – Расчет зарплаты):
Расчёт зарплаты выполняется документом «Начисление заработной платы» по всем видам расчёта, кроме премий. Премии начисляются отдельным документом «Начисление фиксированных премий»;
Документ «Выплата зарплаты» учитывает начисленные и выплаченные суммы сотрудникам;

9. Бухгалтеру добавлена возможность формирования Акта об оказанных услугах (Главное – Реализация товаров и услуг - Акт) с функцией вставки электронной подписи и печати. В справочнике «Подписи и печати» необходимо загрузить подпись и печать организации;

10. Бухгалтеру добавлена возможность создания отчета «Анализ выставленных актов» (Добавленные объекты – Отчеты) включающего информацию о клиентах, договорах и суммах, которые должны быть выставлены клиентам на основе данных из документов «Обслуживание клиентов»;

11. Бухгалтеру добавлена возможность формирования документов по реализации за месяц с помощью обработки «Массовое создание актов» (Добавленные объекты – Сервис);

12. В конфигурации созданы следующие профили пользователей: «Администратор», «БухгалтерИТФирмы», «Кадровик-расчетчик», «Менеджер», «Специалист» с соответствующим набором прав доступа (Администрирование – Настройки пользователей и прав – Пользователи).

13. Реализована интеграция с Телеграм. При записи документа «Обслуживание клиента» если документ записывается первый раз или если дата, время или специалист изменились будет направлено уведомление в телеграм-бот.

Порядок действий для Администратора:

Создайте бота в Телеграм https://t.me/BotFather;
Создайте группу в Телеграм;
Добавьте в группу только что созданного бота;
Назначьте боту права администратора;
Заполните «Идентификатор группы для оповещения в телеграм» и «Токен управления телеграм-ботом» (Добавленные объекты – Сервис).
