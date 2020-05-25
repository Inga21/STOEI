<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>
<@c.page>
<div class = "container mt-5">
     <div class="add-wrapper">

        <form action="/user/area/edit" method="post" enctype="multipart/form-data">
<#--            <label>Выберите предприятие</label>
            <select name = "companyTitle">
                <#list company as compan>
                    <option value="${compan.companyTitle}">${compan.companyTitle}</option>
                </#list>
            </select>-->
            <label for="inputState">Выберете предприятие</label>
            <select name="companyTitle" id="inputState" class="form-control">
                <#if users.department?? >
                    <option selected  value="${users.department.company.companyTitle}">${users.department.company.companyTitle}</option>
                </#if>
                 <#list company as compan>
                     <option value="${compan.companyTitle}">${compan.companyTitle}</option>
                 </#list>
            </select>
     </div>
    <div class="container mt-5">
        <div class="card">
            <div class="card-body">
            <div>
                <div><input  hidden type="text" name="user_id" value="${users.id}"/></div>
                <div class="form-group"><label for="formGroupExampleInput">Логин</label>
                    <input type="text" readonly name="username" value="${users.username}" class="form-control" id="formGroupExampleInput" >
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Пароль</label>
                    <input type="password" name="password" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Повторите пароль</label>
                    <input type="password" name="password1" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Фамилия, имя, отчество</label>
                    <input type="text" name = "fio" value="${users.fio}" class="form-control${(fioError??)?string('is-invalid','')}"/>
                     <#if fioError??>
                    <div class="ismy-invalid">
                        ${fioError}
                    </div>
                     </#if>
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Мобильный телефон</label>
                    <input type="text" name="telephoneMobile" value="${users.telephoneMobile}" class="form-control" />
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Рабочий телефон</label>
                    <input type="text" name="telephoneWork ${(telephoneWorkErrors??)?string('is-invalid','')}" value="${users.telephoneWork}" class="form-control" />
                    <#if telephoneWorkError??>
                    <div class="ismy-invalid">
                        ${telephoneWorkError}
                    </div>
                    </#if>
                </div>
            </div>
            <div>
                <#if users.department ??>
                    <div>
                        <input  hidden type="text" name="department_id" value="${users.department.id}"/>
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Название отдела</label>
                        <input type="text" name="departmentTitle" value="${users.department.departmentTitle}" class="form-control"/></div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Номер кабинета</label>
                        <input type="text" pattern="[0-9]{0,10}" name="numberRoom" value="${users.department.numberRoom}" class="form-control"/>
                    </div>
                <#else >
                    <div>
                        <input  hidden type="text" name="department_id" value=""/></div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Название отдела</label> <input type="text" name="departmentTitle" value="" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Номер кабинета</label>
                        <input type="text" pattern="[0-9]{0,10}" name="numberRoom" value="" class="form-control"/>
                    </div>
                </#if>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div><input type="submit" value="Сохранить" class="filter-button"/></div>
        </form>
     </div>
</div>
    </div></div>
</div>

</@c.page>