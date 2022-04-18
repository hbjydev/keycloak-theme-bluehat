<#import "template.ftl" as layout>
<#import "forms.ftl" as forms>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        <h1 class="text-2xl font-medium">${msg("doLogIn")}</h1>
    <#elseif section="form">
        <form id="kc-otp-login-form" class="flex flex-col gap-8" action="${url.loginAction}"
            method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <input id="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListInputClass!}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                            <label for="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                      <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <@forms.field
                name="otp"
                id="otp"
                autofocus="on"
                label=msg("loginOtpOneTime")
                hasError=messagesPerField.existsError('totp')
                errorMsg=kcSanitize(messagesPerField.get('totp'))?no_esc
                />

            <input
                class="esp-button esp-button-primary" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
        </form>
    </#if>
</@layout.registrationLayout>