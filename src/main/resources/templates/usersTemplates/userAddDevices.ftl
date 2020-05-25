<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>

<@c.page>
<div class="container mt-5">
        <form action="/user/device/add" method="post">
        <#if id ??>
        <div>
            <input hidden type="text" name="user_id" value="${id}"/>
        </div>
        </#if>
            <div class="form-group">
                <label for="formGroupExampleInput">Табельный номер устройства:</label>
                <input type="text" name="personnelNumber" class="form-control ${(personnelNumberError??)?string('is-invalid','')}"
                       value="<#if device??>${device.personnelNumber}</#if>" id="formGroupExampleInput">
                <#if personnelNumberError??>
                    <div class="ismy-invalid">
                    ${personnelNumberError}
                </div>
                </#if>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput">Модель:</label>
                <input type="text" name="model" class="form-control ${(modelError??)?string('is-invalid','')}"
                       value="<#if device??>${device.model}</#if>" id="formGroupExampleInput">
                 <#if modelError??>
                    <div class="ismy-invalid">
                        ${modelError}
                    </div>
                 </#if>
            </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="submit" class="btn btn-info" value="Сохранить"/>
        </form>
</div>
</@c.page>