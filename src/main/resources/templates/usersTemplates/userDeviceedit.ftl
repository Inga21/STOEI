<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>

<@c.page>
<div class="container mt-5">
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
    <br>
    <form action="/user/device/edit" method="post">
        <#if devices ??>
            <div><input  hidden type="text" name="id" value="${devices.id}"/></div>
            <div class="form-group">
                <label for="formGroupExampleInput">Табельный номер устройства:</label>
                <input type="text"  name="personnelNumber" class="form-control ${(personnelNumberError??)?string('is-invalid','')}"
                       value="<#if devices??>${devices.personnelNumber}</#if>" id="formGroupExampleInput">
            <#if personnelNumberError??>
                    <div class="ismy-invalid">
                        ${personnelNumberError}
                    </div>
            </#if>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput">Модель:</label>
                <input type="text"  class="form-control ${(modelError??)?string('is-invalid','')}"
                       value="<#if devices??>${devices.model}</#if>" name="model" id="formGroupExampleInput">
                 <#if modelError??>
                    <div class="ismy-invalid">
                        ${modelError}
                    </div>
                 </#if>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button type = "submit" name="button" value="save" class="btn btn-info">Сохранить</button>
        </#if>
    </form>
</div>
</@c.page>