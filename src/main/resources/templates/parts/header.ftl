<#include "security.ftl">
<header>
        <#include "security.ftl">
    <div class="headerlinewraper">
        <div class="headerline">
            <div class="header-center">
                <ul class="left-list">
                    <#if isAdmin || isSuperAdmin>
                    <li><a href="/user" >Пользователи</a></li>
                    </#if>
                    <#if avtorisation>
                        <li><a href="/request">Заявки</a></li>
                    <#else >
                    <li></li>
                    </#if>
                </ul>
                <div class="triangle"></div>
                <div class="logo"><img src="../../static/img/logo999.png" alt="logo" class="logo-f"></div>
                <ul class="right-list">
                    <li></li>
                    <#if avtorisation>
                        <li><a href = "/user/area">Личный кабинет</a></li>
                    </#if>
                    <#if isSuperAdmin>
                        <li><a href = "/summary">Сводка</a></li>
                    <#else >
                    <li></li>
                    </#if>
                </ul>
            </div>
        </div>

    </div>
    <div class="logout-login-wrapper">
        <div>
            <#if avtorisation>
                <form action="/logout" method="post">
                    <input type="hidden" name = "_csrf" value = "${_csrf.token}"/>
                    <input class="login-logout-header" type="submit" value="Выйти"/>
                </form>
            </#if>
        </div>
    </div>
</header>