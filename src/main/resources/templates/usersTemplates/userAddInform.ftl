<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>
<@c.page>
My information :
    <div class="add-wrapper">
        <form action="/user/area/inform" method="post" enctype="multipart/form-data">
            <label>Выберите предприятие:</label>
            <select name = "companyTitle">
                <#list company as compan>
                    <option value="${compan.companyTitle}">${compan.companyTitle}</option>
                </#list>
            </select>
            <div><label>Введите название отдела: <input type="text" name="departmentTitle" class="input-comment-name "/></label></div>
            <div><label>Введите номер отдела: <input type="text" name="numberRoom" class="input-comment-name "/></label></div>
            <div class="add-button-wrapper">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div><input type="submit" value="Сохранить" class="filter-button"/></div>
            </div>
        </form>
    </div>
</@c.page>