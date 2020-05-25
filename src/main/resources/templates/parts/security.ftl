<#assign
known = Session.SPRING_SECURITY_CONTEXT??
>

<#if known>
    <#assign
    user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    name = user.getUsername()
    isAdmin = user.isAdmin()
    isSuperAdmin = user.isSuperAdmin()
    avtorisation = true
    >
<#else>
    <#assign
    avtorisation = false
    name = "unknown"
    isAdmin = false
    isSuperAdmin = false
    >
</#if>
