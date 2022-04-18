<#import "template.ftl" as layout>
<#import "forms.ftl" as forms>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        <h1 class="text-2xl font-medium">${msg("updatePasswordTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-passwd-update-form" class="flex flex-col gap-8" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

            <@forms.field
                id="password-new"
                name="password-new"
                type="password"
                label=msg("passwordNew")
                placeholder=msg("passwordNew")
                hasError=messagesPerField.existsError('password','password-confirm')
                errorMsg=kcSanitize(messagesPerField.get('password'))?no_esc
                autofocus="on"
                />

            <@forms.field
                id="password-confirm"
                name="password-confirm"
                type="password"
                label=msg("passwordConfirm")
                placeholder=msg("passwordConfirm")
                hasError=messagesPerField.existsError('password', 'password-confirm')
                errorMsg=kcSanitize(messagesPerField.get('password-confirm'))?no_esc
                autofocus="on"
                />

            <#if isAppInitiatedAction??>
                <@forms.checkbox
                    type="checkbox"
                    id="logout-sessions"
                    name="logout-sessions"
                    label="${msg('logoutOtherSessions')}"
                    value="on"
                    checked=true
                    />
            </#if>

            <#if isAppInitiatedAction??>
                <div class="flex gap-8">
                    <input class="esp-button esp-button-primary" type="submit" value="${msg("doSubmit")}" />
                    <button class="esp-button esp-button-danger" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                </div>
            <#else>
                <input class="esp-button esp-button-primary" type="submit" value="${msg("doSubmit")}" />
            </#if>
        </form>
    </#if>
</@layout.registrationLayout>