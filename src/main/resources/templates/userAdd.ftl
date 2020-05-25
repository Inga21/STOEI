<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<div class = "container mt-5" >
    <#if message??>
        <div class ="ismy-invalid">
            ${message}
        </div>
    </#if>
        <form action="/user/add" method="post">
                <div class="form-group">
                    <label for="formGroupExampleInput">Логин</label>
                    <input type="text" class="form-control ${(usernameError??)?string('is-invalid','')}"
                           value="<#if user??>${user.username}</#if>" name="username"  id="formGroupExampleInput"
                           placeholder="sample@yandex.by">
                </div>
                <#if usernameError??>
                    <div class="ismy-invalid">
                        ${usernameError}
                    </div>
                </#if>
                <div class="form-group">
                    <label for="formGroupExampleInput2">ФИО</label>
                    <input type="text" class="form-control ${(fioError??)?string('is-invalid','')}"
                           value="<#if user??>${user.fio}</#if>" name="fio" id="formGroupExampleInput2"
                           placeholder="Петров В.В.">
                </div>
                <#if fioError??>
                    <div class="ismy-invalid">
                        ${fioError}
                    </div>
                </#if>
                <div class="form-group">
                    <label for="formGroupExampleInput2" >Телефон мобильный</label>
                    <input type="text" class="form-control" placeholder="+375-xx-xxx-xx-xx"
                              value="<#if user??>${user.telephoneMobile}</#if>" name="telephoneMobile" id="formGroupExampleInput2">
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput2">Телефон рабочий</label>
                    <input type="text" class="form-control ${(telephoneWorkErrors??)?string('is-invalid','')}"
                    value="<#if user??>${user.telephoneWork}</#if>" name="telephoneWork" id="formGroupExampleInput2" placeholder="xxx-xx-xx">
                </div>
              <#if telephoneWorkError??>
                    <div class="ismy-invalid">
                        ${telephoneWorkError}
                    </div>
              </#if>
                <div class="form-group col-md-2">
                    <label for="inputState">Роль</label>
                    <select name="role" id="inputState" class="form-control">
                        <option selected value="USER">USER</option>
                        <option value="ADMIN">ADMIN</option>
                        <option value="SUPER_ADMIN">SUPER_ADMIN</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput2"> Табельный номер устройства</label>
                    <input type="text" class="form-control ${(personnelNumberError??)?string('is-invalid','')}"
                           value="<#if user??>${device.personnelNumber}</#if>"  name="personnelNumber" id="formGroupExampleInput2" >
                </div>
             <#if personnelNumberError??>
                    <div class="ismy-invalid">
                        ${personnelNumberError}
                    </div>
             </#if>
                <div class="form-group">
                    <label for="formGroupExampleInput2">Модель</label>
                    <input type="text" class="form-control ${(modelError??)?string('is-invalid','')}"
                           value="<#if user??>${device.model}</#if>" name="model" id="formGroupExampleInput2">
                </div>
             <#if modelError??>
                    <div class="ismy-invalid">
                        ${modelError}
                    </div>
             </#if>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <div><input type="submit" class="btn btn-info" value="Сохранить"/></div>
        </form>
</div>
</@c.page>