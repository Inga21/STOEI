<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l >
<@c.page>
    <div class="container mt-5">
        <div class="card">
            <div class="card-body">
                        <select name="summaryChoice" id="summaryChoice">
                            <#if choice??>
                                <option disabled selected>${choice}</option>
                                <#else>
                                <option selected>Фильтрации</option>
                            </#if>
                            <option value="http://localhost:8080/summary/">Заявки по админам</option>
                            <option value="http://localhost:8080/summary/priority">Заявки по приоритету</option>
                        </select>
                <br/>
                 <div class="row mx-md-n5">
                     <div class="col px-md-5">
                         <div class="p-3 border bg-light">
                            <form action="/user/device/edit" method="get">
                                <table class="table_blur" style="margin-top: 50px;">
                                    <thead>
                                    <tr>
                                        <#if summarysAssigned??>
                                            <th>ФИО</th>
                                        <#else >
                                            <th>Приоритет</th>
                                        </#if>
                                        <th>В Работе</th>
                                        <th>Пауза</th>
                                        <th>Завершено</th>

                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#if summarysAssigned??>
                                        <#list summarysAssigned as key,val>
                                          <tr>
                                            <td>${key}</td>
                                                <#list val as vl>
                                                <td>${vl}</td>
                                                </#list>
                                          </tr>
                                          </#list>
                                    </#if>
                                    <#if summarysPriority??>
                                        <#list summarysPriority as key,val>
                                          <tr>
                                              <td>${key}</td>
                                                <#list val as vl>
                                                <td>${vl}</td>
                                                </#list>
                                          </tr>
                                        </#list>
                                    </#if>
                                    </tbody>
                                </table>
                            </form>
                         </div>
                     </div>
<#--                     <div class="row mx-md-n5">-->
                         <div class="col px-md-5">
                             <div class="p-3 border bg-light">
                                 <div id="oil" style=" height: 400px;"></div>
                             </div>
                         </div>
<#--                 </div>-->
            </div>
        </div>
    </div>
    </div>
<div id="bemn" hidden value = "${bemn}">${bemn}</div>
<div id="baza" hidden value = "${baza}">${baza}</div>
<div id="atomka" hidden value="${atomka}">${atomka}</div>
</@c.page>
    <script src="https://www.google.com/jsapi"></script>
    <script>
        google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            var bemn = parseInt(document.getElementById("bemn").getAttribute('value'));
            var baza =parseInt(document.getElementById("baza").getAttribute('value'));
            var atom =parseInt(document.getElementById("atomka").getAttribute('value'));
            var data = google.visualization.arrayToDataTable([
                ['Площадка','Бемн','База','Атомка'],
                ['',bemn,baza,atom],
            ]);
            var options = {
                title: 'Задачи по площадкам',
                hAxis: {title: 'Площадка'},
                vAxis: {title: 'Количество задач'}
            };
            var options = {
                title: 'Задачи по площадкам',
                hAxis: {title: 'Площадка'},
                vAxis: {title: 'Количество задач'}
            };
            var chart = new google.visualization.ColumnChart(document.getElementById('oil'));
            chart.draw(data, options);
        }
    </script>
<script>
    document.getElementById("summaryChoice").onchange = function() {
        if (this.selectedIndex!==0) {
            window.location.href = this.value;
        }
    };
</script>