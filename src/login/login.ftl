<#import "template.ftl" as layout>
<#import "forms.ftl" as forms>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <h1 class="text-2xl font-medium">
            ${msg("loginAccountTitle", (realm.displayName!''))}
        </h1>
    <#elseif section = "form">

        <#if realm.password>
            <form class="flex flex-col gap-8" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">

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

                <#if !usernameHidden??>
                    <@forms.field
                        tabindex="1"
                        id="username"
                        name="username"
                        label=usernameLabel
                        value=login.username!''
                        autofocus="on"
                        autocomplete="off"
                        placeholder=usernamePlaceholder

                        hasError=messagesPerField.existsError('username','password')
                        errorMsg=kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc
                        />
                </#if>

                <@forms.field
                    tabindex="1"
                    id="password"
                    name="password"
                    type="password"
                    label=msg('password')
                    autocomplete="off"
                    placeholder="Password"
                    hasError=messagesPerField.existsError('username','password')
                    showError=usernameHidden??
                    errorMsg=kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc
                    />

                <#if realm.rememberMe || realm.resetPasswordAllowed>
                    <div class="grid grid-cols-2">
                        <div>
                            <#if realm.rememberMe && !usernameHidden??>
                                <@forms.checkbox
                                    type="checkbox"
                                    id="rememberMe"
                                    name="rememberMe"
                                    label="${msg('rememberMe')}"
                                    checked=login.rememberMe??
                                    />
                            </#if>
                        </div>
                        <div class="flex justify-end">
                            <#if realm.resetPasswordAllowed>
                                <a
                                    class="text-blue-500 underline text-sm"
                                    tabindex="5"
                                    href="${url.loginResetCredentialsUrl}"
                                >
                                    ${msg("doForgotPassword")}
                                </a>
                            </#if>
                        </div>
                    </div>
                </#if>

                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                    <input
                        tabindex="4"
                        class="esp-button esp-button-primary"
                        name="login"
                        id="kc-login"
                        type="submit"
                        value="${msg("doLogIn")}"
                    />
                </div>
            </form>
        </#if>

    <#elseif section = "footer">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration" class="p-10 text-center">
                <a
                    class="flex items-center gap-2 text-xl font-bold text-blue-500"
                    tabindex="6"
                    href="${url.registrationUrl}"
                >
                    <span>${msg("doRegister")}</span>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                    </svg>
                </a>
            </div>
        </#if>

        <#-- TODO: work out better way to show social AND info -->
        <#--  <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="p-10 text-gray-600">
                <p class="text-center mb-2">${msg("identity-provider-login-label")}</p>
                <ul class="grid gap-4 <#if social.providers?size gt 3>grid-cols-3<#else>grid-cols-2</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="w-full py-2 text-center border-gray-300 <#if !p?is_last>border-r</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>  -->
    </#if>

</@layout.registrationLayout>
