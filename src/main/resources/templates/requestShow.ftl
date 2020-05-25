<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#include "parts/security.ftl">
<@c.page>
<#if status??>${status}</#if>
    <#if status1??>${status1}</#if>
<div class = "container mt-5" >
    <div class="card">
        <div class="card-body">
            <div class="container">
                <div class="row">
                    <div class="col-sm">
                         <#if request ??>
                             <p>ID заявки ${request.id}</p>
                         </#if>
                    </div>
                </div>
                <#if isAdmin || isSuperAdmin >
                <table class="table-borderless">
                    <thead>
                        <tr>
                            <th>
                                <form action="/request/seч  tAssigned/${request.id}" method="get">
                                <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Взять</button>
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                </form>
                            </th>
                            <th>
                                <form action="/request/close/${request.id}" method="get">
                                    <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Закрыть</button>
                                </form>
                            </th>
                                <#if isSuperAdmin>
                                    <form action="/request/action" method="get">
                                      <th>
                                         <#if admins??>
                                             <select name = "user_id">
                                                 <option value="0">Выберете специалиста</option>
                                                 <#list admins as user>
                                                    <option value="${user.id}">${user.fio}</option>
                                                 </#list>
                                             </select>
                                         </#if>
                                      </th>
                                      <th>
                                            <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Назначить</button>
                                            <input hidden type="text" id="request_id" name="request_id" value="${request.id}">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                      </th>
                                    </form>
                                </#if>
                        </tr>
                    </thead>
                </table>
                </#if>
                <br/>

               <#-- <#if isAdmin || isSuperAdmin >
                <div class="row">
                        <form action="/request/seч  tAssigned/${request.id}" method="get">
                            <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Взять</button>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                        </form>
                        <form action="/request/close/${request.id}" method="get">
                            <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Закрыть</button>
                        </form>
                        <#if isSuperAdmin>
                         <form action="/request/action" method="get">
                             <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Назначить</button>
                             <input hidden type="text" id="request_id" name="request_id" value="${request.id}">
                             <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                 <#if admins??>
                                     <select name = "user_id">
                                         <option value="0">Выберете специалиста</option>
                                         <#list admins as user>
                                            <option value="${user.id}">${user.fio}</option>
                                         </#list>
                                     </select>
                                 </#if>
                         </form>
                         </#if>
                </div>
                </#if>-->
                -------------------------------------------------------------------------------------------------------------------------------------------------------------
                <form action="/request/edit/${request.id}" method="post">
                    <div class="form-group">
                        <label for="formGroupExampleInput2">Тема</label>
                        <input disabled type="text"  value="${request.subject}" name="subject" id="formGroupExampleInput2">
                    </div>
                <div class="row">
                    <div class="col-sm">
                        От ${request.userApplicant.fio}
                        на ${request.dateCreate}
                    </div>
                    <div class="col-sm">
                        <#if request.dateEnd??>
                           Дата выполнения ${request.dateEnd}
                        </#if>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="container">
                            <label for="formGroupExampleInput2">Описание</label>
                            <div class="row">
                                <div class="col-xs-15">
                                    <textarea  name="description" style="width:1000px; height:150px; class="form-control">
                                    ${request.description}
                                    </textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <p></p>
                <div class="card">
                    <div class="card-body">
                        <div class="container">
                            <label for="formGroupExampleInput2">Сведения о заявке</label>
                            <div class="row">
                                <div class="col-xs-15">
                                <#if request??>
                                    <div class="row mx-md-n5">
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Статус</label>
                                               <#-- <input type="text" readonly name="status" value="${request.status}" class="form-control" id="formGroupExampleInput">-->
                                                <select name="status" id="inputState" class="form-control">
                                                    <option selected disabled>${request.status}</option>
                                                    <option value="Закрыто">Закрыто</option>
                                                    <option value="Пауза">Пауза</option>
                                                    <option value="Работа">В работе</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Последствия</label>
                                               <#-- <input type="text" readonly name="effects" value="${request.effects}" class="form-control" id="formGroupExampleInput">-->
                                             <select name="effects" id="inputState" class="form-control">
                                                 <option selected disabled>${request.effects}</option>
                                                 <option value="Весь офис">Весь офис</option>
                                                 <option value="Несколько_человек">Несколько человек</option>
                                                 <option value="Один_человек">Один человек</option>
                                             </select>
                                            </div>
                                        </div>
                                        <div class="row mx-md-n5">
                                            <div class="col px-md-5">
                                                <div class="p-3 border bg-light">
                                                    <label for="inputState">Срочность выполнения</label>
                                                    <#--<input type="text" readonly name="priority" value="${request.priority.name()}" class="form-control" id="formGroupExampleInput">
                                                    --><select name="priority" id="inputState" class="form-control">
                                                        <option value="${request.priority.name()}">${request.priority.name()}</option>
                                                        <option value="Самый_Низкий">Самый Низкий</option>
                                                        <option value="Низкий">Низкий</option>
                                                        <option value="Обычный">Обычный</option>
                                                        <option value="Высокий">Высокий</option>
                                                        <option value="Безотлагательный">Безотлагательный</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <p></p>
                                        </div>
                                    </div>
                                    <p></p>

                                    <div class="row mx-md-n5">
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Назначенный специалист</label>
                                                <#if request.userAssigned??>
                                                    <input type="text" readonly name="assignedFio" value="${request.userAssigned.fio}" class="form-control" id="formGroupExampleInput">
                                                </#if>
                                                </div>
                                        </div>
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Категория</label>
                                                <#--<input type="text" readonly name="category" value="${request.category}" class="form-control" id="formGroupExampleInput">-->
                                                <select name="category" id="inputState" class="form-control">
                                                    <option selected value="${request.category}">${request.category}</option>
                                                    <option value="Другое">Другое</option>
                                                    <option value="Внутренние_работы"> Внутренние работы</option>
                                                    <option value="Установка_ОС">Установка_ОС</option>
                                                    <option value="Закупки">Закупки</option>
                                                    <option value="Оборудование">Оборудование</option>
                                                    <option value="Продажи">Продажи</option>
                                                    <option value="Монтаж_сети"> Монтаж_сети</option>
                                                    <option value="Документооборот">Документооборот</option>
                                                    <option value="Штрафы">Штрафы</option>
                                                    <option value="Консалтинг">Консалтинг</option>
                                                    <option value="Права_доступа">Права_доступа</option>
                                                    <option value="Активация_ПО">Активация ПО</option>
                                                </select>
                                            </div>
                                        </div>
                                        <#--<div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Статус</label>
                                                <input type="text" readonly name="category" value="${request.status.name()}" class="form-control" id="formGroupExampleInput">
                                            </div>
                                        </div>-->
                                    </div>
                                </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <#if isAdmin || isSuperAdmin>
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type = "submit" name="button"  class="btn btn-info">Редактировать</button>
                    </#if>
                </form>
<p></p>
                <div class="card">
                    <div class="card-body">
                        <div class="container">
                            <label for="formGroupExampleInput2">Сведения о заявителе</label>
                            <div class="row">
                                <div class="col-xs-15">
                                <#if request??>
                                    <div class="row mx-md-n5">
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Имя автора заявки</label>
                                                <input type="text" readonly name="applicantFio" value="${request.userApplicant.fio}" class="form-control" id="formGroupExampleInput">
                                            </div>
                                        </div>
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">email</label>
                                                <input type="text" readonly name="username" value="${request.userApplicant.username}" class="form-control" id="formGroupExampleInput">
                                            </div>
                                        </div>
                                    </div>
                                    <p></p>
                                    <div class="row mx-md-n5">
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Мобильный</label>
                                                <input type="text" readonly name="telephoneMobile" value="${request.userApplicant.telephoneMobile}" class="form-control" id="formGroupExampleInput">
                                            </div>

                                        </div>
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">
                                                <label for="inputState">Рабочий</label>
                                                <input type="text" readonly name="telephoneWork" value="${request.userApplicant.telephoneWork}" class="form-control" id="formGroupExampleInput">
                                            </div>
                                        </div>
                                        <#if request.userApplicant.department??>
                                        <div class="col px-md-5">
                                            <div class="p-3 border bg-light">

                                                <label for="inputState">Предприятие</label>
                                                <input type="text" readonly name="companyTitle" value="${request.userApplicant.department.company.companyTitle}" class="form-control" id="formGroupExampleInput">
                                                <label for="inputState">Отдел</label>
                                                <input type="text" readonly name="departmentTitle" value="${request.userApplicant.department.departmentTitle}" class="form-control" id="formGroupExampleInput">
                                                <label for="inputState">Кабинет</label>
                                                <input type="text" readonly name="numberRoom" value="${request.userApplicant.department.numberRoom}" class="form-control" id="formGroupExampleInput">

                                            </div>
                                        </div>
                                        </#if>
                                    </div>
                                </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



            </div>

        </div>
    </div>
</div>
</@c.page>