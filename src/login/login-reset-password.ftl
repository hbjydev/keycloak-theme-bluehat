<#import "template.ftl" as layout>
<#import "forms.ftl" as forms>

<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        <h1 class="text-2xl font-medium">${msg("emailForgotTitle")}</h1>
    <#elseif section = "form">
        <p class="text-gray-800 mb-4">
            <#if realm.duplicateEmailsAllowed>
                ${msg("emailInstructionUsername")}
            <#else>
                ${msg("emailInstruction")}
            </#if>
        </p>

        <form class="flex flex-col gap-8" action="${url.loginAction}" method="post">
            <#if !realm.loginWithEmailAllowed>
                <#assign usernameLabel = msg("username")>
                <#assign usernamePlaceholder = "john.doe">
            <#elseif !realm.registrationEmailAsUsername>
                <#assign usernameLabel = msg("usernameOrEmail")>
                <#assign usernamePlaceholder = "john.doe@company.org">
            <#else>
                <#assign usernameLabel = msg("email")>
                <#assign usernamePlaceholder = "john.doe@company.org">
            </#if>

            <@forms.field
                tabindex="1"
                id="username"
                name="username"
                label=usernameLabel
                value=auth.attemptedUsername!''
                autofocus="on"
                autocomplete="off"
                placeholder=usernamePlaceholder

                hasError=messagesPerField.existsError('username')
                errorMsg=kcSanitize(messagesPerField.getFirstError('username'))?no_esc
                />
 
            <input class="esp-button" type="submit" value="${msg("doSubmit")}" />
        </form>
    <#elseif section = "footer" >
        <div class="p-10">
            <a class="flex items-center gap-2 text-xl font-bold text-blue-500" href="${url.loginUrl}">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7 16l-4-4m0 0l4-4m-4 4h18" />
                </svg>
                <span>${msg("backToLogin")}</span>
            </a>
        </div>
    </#if>
</@layout.registrationLayout>
