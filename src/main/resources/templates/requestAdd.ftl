<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#include "parts/security.ftl">
<@c.page>
<div class = "container mt-5" >
    <#if priority??>    ${priority}</#if>

    <#if priority1??> ${priority1}</#if>

    <div class="card">
        <div class="card-body">
            <div class="container">
    <form action="/request/add" method="post">
    <#if request??>
        <div class="row mx-md-n5">
            <div class="col px-md-5">
                <div class="p-3 border bg-light">
                    <label for="inputState">Статус</label>
                    <#if isSuperAdmin || isAdmin>
                    <select name="status" id="inputState" class="form-control">
                        <option value="Работа">В работе</option>
                        <option value="Закрыто">Закрыто</option>
                        <option value="Пауза">Пауза</option>
                    </select>
                    <#else >
                    <input readonly type="text" class="form-control" name="status" id="formGroupExampleInput2" value="Работа">
                    </#if>
                </div>
            </div>
            <div class="col px-md-5">
                <div class="p-3 border bg-light">
                    <label for="inputState">Последствие</label>
                    <select name="effects" id="inputState" class="form-control">
                        <option value="Весь_офис">Весь офис</option>
                        <option value="Несколько_человек">Несколько человек</option>
                        <option value="Один_человек">Один человек</option>
                    </select>
                </div>
            </div>
        </div>
        <p></p>
        <div class="row mx-md-n5">
            <div class="col px-md-5">
                <div class="p-3 border bg-light">
                    <label for="inputState">Срочность выполнения</label>
                    <select name="priority" id="inputState" class="form-control">
                        <option value="Самый_Низкий">Самый Низкий</option>
                        <option value="Низкий">Низкий</option>
                        <option value="Обычный">Обычный</option>
                        <option value="Высокий">Высокий</option>
                        <option value="Безотлагательный">Безотлагательный</option>
                    </select>
                </div>
            </div>
            <div class="col px-md-5">
                <div class="p-3 border bg-light">
                    <label for="formGroupExampleInput2">Сведения об авторе</label>
                    <#if isSuperAdmin>
                     <select name="user_id" id="inputState" class="form-control">
                                <#list users as user>
                                    <option value="${user.id}">${user.fio}</option>
                                </#list>
                     </select>
                     <#else >
                         <div class="form-group">
                            <input type="text" readonly class="form-control" name="user_fio" id="formGroupExampleInput2" value="${user.fio}">
                        </div>
                     </#if>
                </div>
            </div>
        </div>
        <p></p>

        <div class="row mx-md-n5">
            <#if isSuperAdmin>
            <div class="col px-md-5">
                <div class="p-3 border bg-light">
                      <#if isSuperAdmin??>
                              <label for="inputState">Специалист</label>
                              <select name="adminAssigned" id="inputState" class="form-control">
                                  <option></option>
                                <#list admins as admin>
                                    <option value="${admin.id}" = "${admin.id}">${admin.fio}</option>
                                </#list>
                              </select>
                      </#if>
                </div>
            </div>
                </#if>
            <div class="col px-md-5">
                <div class="p-3 border bg-light">
                    <label for="inputState">Категория</label>
                    <select name="category" id="inputState" class="form-control">
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
        </div>
        <p></p>
        <div class="form-group">
            <label for="formGroupExampleInput2">Тема</label>
            <input type="text" class="form-control ${(subjectError??)?string('is-invalid','')}"
                   value="<#if requests??>${requests.subject}</#if>" name="subject" id="formGroupExampleInput2">
        </div>
        <#if subjectError??>
                    <div class="ismy-invalid">
                        ${subjectError}
                    </div>
        </#if>
            </br>
        <label for="formGroupExampleInput2">Описание</label>
        <div class="row">
            <div class="col-xs-15">
                <textarea  name="description" style="width:1000px; height:150px;"
                           class="form-control ${(descriptionError??)?string('is-invalid','')}"
                           value="<#if requests??>${requests.description}</#if>"></textarea>
            </div>
             <#if descriptionError??>
                    <div class="ismy-invalid">
                        ${descriptionError}
                    </div>
             </#if>
        </div>
        <br />
    </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type = "submit" name="button"  class="delete-button">Отправить</button>
    </form>
            </div>
        </div>
    </div>
</div>
</@c.page>