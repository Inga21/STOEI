<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l >
<@c.page>
    <div class="hedgehog-logo-wrapper"><img src="../../static/img/999.png" alt="lo" class="hedgehog-logo"></div>
    <#if users??>
         <div>
             <form class="login-field-wrapper" action="/restore/newPassword" method="post">
                 <span>Восстановление пароля</span>
                 <div class="login-password-text"><input class="login-password-input" hidden type="text" value="${users.username}" name="username" placeholder="Логин"/> </label></div>
                 <div class="login-password-text"><input class="login-password-input" type="password" name="password1" placeholder="Пароль"/> </label></div>
                 <div class="login-password-text"><input class="login-password-input" type="password" name="password2" placeholder="Повторите пароль"/> </label></div>
                 <input type="hidden" name = "_csrf" value = "${_csrf.token}"/>
                 <p></p>
                 <div class=""><input class="btn btn-info" type="submit" value="Подтвердить"/></div>
             </form>
         </div>
        <#else>
        <div>
            <form class="login-field-wrapper" action="/restore/" method="post">
                <#if message ??>
                    ${message}
                </#if>
                <span>Восстановление пароля</span>
                <div class="login-password-text"><input class="login-password-input" type="text" name="email" placeholder="Логин"/> </label></div>
                <input type="hidden" name = "_csrf" value = "${_csrf.token}"/>
                <p></p>
                <div class=""><input class="btn btn-info" type="submit" value="Восстановить"/></div>
            </form>
        </div>
    </#if>
</@c.page>