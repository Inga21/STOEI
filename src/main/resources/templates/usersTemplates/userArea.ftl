<#import "../parts/common.ftl" as c>
<#import "../parts/login.ftl" as l>
<@c.page>
<div  class = "container mt-5">

         <table class="table_blur" style="margin-top: 50px;">
             <thead>
             <tr>
 <#if users.department??>
                 <th> <a href = "/user/area/edit/${users.id}/" style="color:white">Редактировать информацию о себе</a></th>
    <#else>
                 <th> <a href = "/user/area/inform" style="color:white">Заполнить информацию о себе</a></th>
    </#if>
              </tr>
              </thead>
          </table>

    <div>
        <div class="container mt-5">
        <div class="card">
            <div class="card-body">
                <div class="col-md-6 ">
                    <table class="table table-dark table-hover ">
                        <thead><tr><td><h2>Личные данные</h2></td></tr></thead>
                        <tbody>
                        <tr>
                            <td>Логин</td>
                            <td>${users.username}</td>
                        </tr>
                        <tr>
                            <td>ФИО</td>
                            <td>${users.fio}</td>
                        </tr>
                        <tr>
                            <td>Мобильный телефон</td>
                            <td>${users.telephoneMobile}</td>
                        </tr>
                        <tr>
                            <td>Рабочий телефон</td>
                            <td>${users.telephoneWork}</td>
                        </tr>
                        <#if users.department??>
                            <#if users.department.company ??>
                             <tr>
                             <td>Название организации</td>
                             <td>${users.department.company.companyTitle}</td>
                             </tr>
                             <tr>
                                 <td>Месторасположение</td>
                                 <td>${users.department.company.address}</td>
                             </tr>
                             <#else >
                             <tr>
                                 <td>Название организации</td>
                                 <td>Информация отсутствует, заполните</td>
                             </tr>
                              <tr>
                                  <td>Месторасположение</td>
                                  <td>Информация отсутствует, заполните</td>
                              </tr>
                             </#if>
                        </#if>
                     <#if users.department ??>
                            <tr>
                              <td>Название отдела</td>
                              <td>${users.department.departmentTitle}</td>
                            </tr>
                             <tr>
                                 <td>Номер кабинета</td>
                                 <td>${users.department.numberRoom}</td>
                             </tr>
                     <#else >
                             <tr>
                                 <td>Название отдела</td>
                                 <td>Информация отсутствует, заполните</td>
                             </tr>
                              <tr>
                                  <td >Номер кабинета</td>
                                  <td>Информация отсутствует, заполните</td>
                              </tr>
                     </#if>
                        </tbody>
                    </table>
                </div>
<#--
        <div class="form-group">
            <label for="formGroupExampleInput2">Логин</label>
            <input type="text" class="form-control" readonly value="${users.username}" name="subject" id="formGroupExampleInput2">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">ФИО</label>
            <input type="text" class="form-control" readonly value="${users.fio}" name="subject" id="formGroupExampleInput2">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Мобильный телефон</label>
            <input type="text" class="form-control" readonly value="${users.telephoneMobile}" name="subject" id="formGroupExampleInput2">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Рабочий</label>
            <input type="text" class="form-control" readonly value="${users.telephoneWork}" name="subject" id="formGroupExampleInput2">
        </div>
    <#if users.department.company ??>
        <div class="form-group">
            <label for="formGroupExampleInput2">Название организации</label>
            <input type="text" class="form-control" readonly value="${users.department.company.companyTitle}" name="subject" id="formGroupExampleInput2">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Месторасположение</label>
            <input type="text" class="form-control" readonly value="${users.department.company.address}" name="subject" id="formGroupExampleInput2">
        </div>
    <#else >
        <div class="form-group">
            <label for="formGroupExampleInput2">Название организации</label>
            <input type="text" class="form-control" readonly value="Информация отсутствует, заполните." name="subject" id="formGroupExampleInput2">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Месторасположение</label>
            <input type="text" class="form-control" readonly value="Информация отсутствует, заполните." name="subject" id="formGroupExampleInput2">
        </div>
    </#if>
        <#if users.department ??>
          <div class="form-group">
              <label for="formGroupExampleInput2">Название отдела</label>
              <input type="text" class="form-control" readonly value="${users.department.departmentTitle}" name="subject" id="formGroupExampleInput2">
          </div>
          <div class="form-group">
              <label for="formGroupExampleInput2">Номер кабинета</label>
              <input type="text" class="form-control" readonly value="${users.department.numberRoom}" name="subject" id="formGroupExampleInput2">
          </div>
            <#else >
        <div class="form-group">
            <label for="formGroupExampleInput2">Название отдела</label>
            <input type="text" class="form-control" readonly value="Информация отстутвует, заполните." name="subject" id="formGroupExampleInput2">
        </div>
          <div class="form-group">
              <label for="formGroupExampleInput2">Номер кабинета</label>
              <input type="text" class="form-control" readonly value="Информация отстутвует, заполните." name="subject" id="formGroupExampleInput2">
          </div>
        </#if>-->
    </div>
</div>
             </div>
    </div>
</div>
</@c.page>
