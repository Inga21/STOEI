<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#include "parts/security.ftl">
<@c.page>
<div class = "container mt-5" >
    <div  id = "cont" >
    <#if isAdmin||isSuperAdmin>
    <select id = "requestChoice" name ="filter">
        <option>Фильтр</option>
        <option value="http://localhost:8080/request/my">Мои заявки</option>
        <option value="http://localhost:8080/request/unassigned">Неназначенные заявки</a></option>
        <option value="http://localhost:8080/request/open">Мои открытые</option>
        <option value="http://localhost:8080/request/close">Мои закрытые</option>
        <option value="http://localhost:8080/request/allClose">Все закрытые</option>
        <#list users as user>
            <option value="http://localhost:8080/request/admin/${user.id}">
                ${user.fio} Открытые
            </option>
        </#list>
        </select>
</#if>

    <table class="table-borderless">
        <thead>
        <form action="/request/find" method="get" class="find-wrapper" >
        <tr>
            <th><input type="text" name="findRequest_id" class="find-input-ares" placeholder="id"></th>
            <th>
                <input type="submit" name="" value="Найти" class="filter-button">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            </th>
        </tr>
        </form>
        <tr>
            <th>
                <form action="/request/add" method="get">
                <input type="submit" value="Создать" class="filter-button">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            </form>
            </th>
        </tr>

        </form>
        </thead>
    </table>
<br/>
   <#-- <form action="/request/find" method="get" class="find-wrapper" >
        <input type="text" name="findRequest_id" class="find-input-ares">
        <input type="submit" name="" value="Найти" class="filter-button">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>

    <form action="/request/add" method="get">
        <input type="submit" value="Создать" class="filter-button">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
    <br/>-->
<form action="/request/action" method="get">
    <#if isAdmin  || isSuperAdmin >
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type = "submit" name="button" value ="getRequest" class="btn btn-info">Взять</button>
        <button type = "submit" name="button" value ="closeRequest" class="btn btn-info">Закрыть</button>
        <button type = "submit" name="button" value ="pauseRequest" class="btn btn-info">Остановить</button>
        <button type = "submit" name="button" value="reNewRequest" class="btn btn-info">Возобновить</button>
        <select name = "user_id">
        <#if users ??>
            <option value="0">Выберете специалиста</option>
                <#list users as user>
                    <option value="${user.id}">${user.fio}</option>
                </#list>
        </#if>
        </select>
        <button type = "submit" name="button" value="assignToRequest" class="btn btn-info">Назначить</button>
    </#if>
    <#if message??>
        <input type="text" value="${message}" class="find-input-ares">
    </#if>
    <table class="table_blur" style="margin-top: 50px;">
        <thead>
        <tr>
            <th>Площадка</th>
            <th>Тема</th>
            <th>Статус</th>
            <th>Приоритет</th>
            <th>Имя автора заявки</th>
            <th>Назначено</th>
            <th>Дата создания</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#if requests ??>
           <#list requests as request>
           <tr>
               <#if request??>
                   <#if request.userApplicant??>
               <#if request.userApplicant.department ??>
                       <td>${request.userApplicant.department.company.companyTitle}</td>
                   <#else>
                       <td>-</td>
               </#if>
               </#if>
               <td><a href="/request/${request.id}" >${request.subject}</a></td>
               <td>${request.status.name()}</td>
               <td>${request.priority.name()}</td>
               <td>${request.userApplicant.fio}</td>
               <#if request.userAssigned ??>
                       <td>${request.userAssigned.fio}</td>
                   <#else>
                       <td>-</td>
               </#if>
               <td>${request.dateCreate}</td>
               <td><input type="radio" id="request_id" name="request_id" value="${request.id}"></td>
               </#if>
            </tr>
            </#list>
        </#if>
        </tbody>
    </table>
</form>
    </div>
</div>
</@c.page>
<script>
    document.getElementById("requestChoice").onchange = function() {
        if (this.selectedIndex!==0) {
            window.location.href = this.value;
        }
    };
</script>
