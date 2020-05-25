<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>
<@c.page>

</@c.page>
<#--My information :
    <div class="add-wrapper">
        <form action="/user/area/edit" method="post" enctype="multipart/form-data">
            <label>Выберите контору</label>
            <select name = "companyTitle">
                <#list company as compan>
                    <option value="${compan.companyTitle}">${compan.companyTitle}</option>
                </#list>
            </select>

            <div>
                <div><input  hidden type="text" name="user_id" value="${users.id}"/></div>
                <div><label>Логин:</label><input type="text" name="username" value="${users.username}" class="input-comment-name"/></div>
                <div><label>Пароль:</label><input type="text" name="password" value="" class="input-comment-name"/></div>
                <div><label>Повторите пароль:</label><input type="text" name="password1" value="" class="input-comment-name"/></div>
                <div><label>ФИО:<input type="text" name = "fio" value="${users.fio}" class="input-comment-name" /></label></div>
                <div><label>Мобильный телефон: <input type="text" name="telephoneMobile" value="${users.telephoneMobile}" class="input-comment-name" /></label></div>
                <div><label>Рабочий телефон: <input type="text" name="telephoneWork" value="${users.telephoneWork}" class="input-comment-name" /></label></div>
            </div>
            <div>
                <#if users.department ??>
                    <div><input  hidden type="text" name="department_id" value="${users.department.id}"/></div>
                    <div><label>Название отдела: <input type="text" name="departmentTitle" value="${users.department.departmentTitle}" class="input-comment-name"/></label></div>
                    <div><label>Номер кабинета: <input type="text" pattern="[0-9]{0,10}" name="numberRoom" value="${users.department.numberRoom}" class="input-comment-name"/></label></div>
                <#else >
                     <div><input  hidden type="text" name="department_id" value=""/></div>
                    <div><label>Название отдела: <input type="text" name="departmentTitle" value="" class="input-comment-name"/></label></div>
                    <div><label>Номер кабинета: <input type="text" pattern="[0-9]{0,10}" name="numberRoom" value="" class="input-comment-name"/></label></div>
                </#if>
                </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div><input type="submit" value="Сохранить" class="filter-button"/></div>
        </form>
    </div>-->