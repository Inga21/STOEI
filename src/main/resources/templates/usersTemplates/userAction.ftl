<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>

<@c.page>
<div class = "container mt-5">
     <table class="table-borderless">
         <thead>
         <tr>
             <th><a href = "/user/add">Добавить сотрудника</a></th>
         </tr>
         <tr>
             <th><a href = "/user/device">Просмотр устройств</a></th>
         </tr>
         </thead>
     </table>
<form action="/user/edit" method="post">
    <table class="table_blur" style="margin-top: 50px;">
        <thead>
        <tr>
            <th>Имя пользователя</th>
<#--            <th>Пароль</th>-->
            <th>Роль</th>
            <th>ФИО</th>
            <th>Телефон мобильный</th>
            <th>Телефон рабочий</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
        <tr>
            <td>${user.username}</td>
            <td><#list user.roles as role>${role}<#sep>, </#list></td>
            <td>${user.fio}</td>
            <td>${user.telephoneMobile}</td>
            <td>${user.telephoneWork}</td>
            <td></td>
            <td><input type="radio" id="id" name="id" value="${user.id}"></td>
        </tr>
        </#list>
        </tbody>
    </table>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
         <select name = "role">
             <option value="USER">USER</option>
             <option value="ADMIN">ADMIN</option>
             <option value="SUPER_ADMIN">SUPER_ADMIN</option>
         </select>
        <button type = "submit" name="button" value ="editRole" class="btn btn-info">Изменить роль</button>
        <button type = "submit" name="button" value="editUser" class="btn btn-info">Редактировать</button>
        <button type = "submit" name="button" value="addDevice" class="btn btn-info">Добавить устройство</button>
        <button type = "submit" name="button" value="deleteUser" class="btn btn-info">Удалить</button>
</form>
<form action="/user/find" method="get" class="find-wrapper" style="margin-top: 50px">
    <span class="">
            <select  name="choice" style="width: 200px;">
            <option selected disabled>Выберите поле</option>
            <option  value="fio">ФИО</option>
            <option value="email">Логин</option>
            <option value="role">Роль</option>
        </select>
        <input type="text" name="find" placeholder="" class="find-input-ares">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="submit" value="Найти" class="filter-button">
    </span>
</form>
</div>
</@c.page>
