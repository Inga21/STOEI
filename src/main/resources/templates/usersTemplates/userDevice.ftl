<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>

<@c.page>
<div class = "container mt-5">
     <table class="table-borderless">
         <thead>
         <tr>
             <th><a href = "/user/add">Добавить сотрудника</a></th>
             <th></th>
         </tr>
         <form action="/user/device/find" method="get" class="find-wrapper" style="margin-top: 50px">
         <tr>
             <th>
                 <select size="3" name="choice" style="width: 200px;">
                     <option disabled>Выберите поле</option>
                     <option selected value="fio">ФИО</option>
                     <option value="personnel_number">Номер</option>
                 </select>
             </th>
             <th>
                 <input type="text" name="findField" value="" placeholder="" class="find-input-ares">
                 <input type="hidden" name="_csrf" value="${_csrf.token}" />
                 <button type="submit" name="button" class="edit-button">Найти</button>
             </th>
         </tr>
         </form>
         </thead>
     </table>
    <form action="/user/device/edit" method="get">
    <table class="table_blur" style="margin-top: 50px;">
        <thead>
        <tr>
            <th>ФИО сотрудника</th>
            <th>Табельный номер</th>
            <th>Модель</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#if devices ??>
            <#list devices as device>
            <tr>
                <td>${device.user.fio}</td>
                <td>${device.personnelNumber}</td>
                <td>${device.model}</td>
                <td></td>
                <td><input type="radio" id="id" name="id" value="${device.id}"></td>
            </tr>
            </#list>
        </#if>
        </tbody>
    </table>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type = "submit" name="button" value="editUserDevice" class="btn btn-info">Редактировать</button>
        <button type="submit" name="button" value="deleteDevice" class="btn btn-info">Удалить</button>
</form>
</div>
</@c.page>