<#import "template.ftl" as layout>
<#import "forms.ftl" as forms>

<#macro numbered_section number>
    <div class="grid grid-cols-[2rem_auto]">
        <div class="h-8 w-8 bg-blue-200 rounded-full inline flex items-center justify-center">${number}</div>
        <div class="ml-2">
            <#nested>
        </div>
    </div>
</#macro>

<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
    <#if section = "header">

        <h1 class="text-2xl font-medium">${msg("loginTotpTitle")}</h1>

    <#elseif section = "form">
        <form action="${url.loginAction}" class="flex flex-col text-gray-800 gap-8" method="post">
            <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />

            <@numbered_section number="1">
                <span>${msg("loginTotpStep1")}</span>

                <ul class="list-disc list-inside">
                    <#list totp.policy.supportedApplications as app>
                        <li>${app}</li>
                    </#list>
                </ul>
            </@numbered_section>

            <@numbered_section number="2">
                <p class="text-gray-800">${msg("loginTotpStep2")}</p>
                <div class="flex items-center">
                    <img class="h-32 w-32" id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <div class="flex flex-col text-sm">
                        <p class="text-gray-600">${msg("loginTotpUnableToScan")}</p>
                        <kbd class="p-0.5 bg-gray-100 border">${totp.totpSecretEncoded}</kbd>
                    </div>
                </div>
            </@numbered_section>

            <@numbered_section number="3">
                <p class="mb-2">${msg("loginTotpStep3")}</p>
                <@forms.field
                    name="totp"
                    id="totp"
                    required=true
                    label=msg('authenticatorCode')
                    hasError=messagesPerField.existsError('totp')
                    errorMsg=kcSanitize(messagesPerField.get('totp'))?no_esc
                    />
            </@numbered_section>

            <@numbered_section number="4">
                <p class="mb-2">${msg("loginTotpStep3DeviceName")}</p>

                <#assign nameRequired = false>
                <#if totp.otpCredentials?size gte 1>
                    <#assign nameRequired = true>
                </#if>

                <@forms.field
                    name="userLabel"
                    id="userLabel"
                    required=nameRequired
                    label=msg('loginTotpDeviceName')
                    hasError=messagesPerField.existsError('userLabel')
                    errorMsg=kcSanitize(messagesPerField.get('userLabel'))?no_esc
                    />
            </@numbered_section>

            <#if isAppInitiatedAction??>
                <div class="flex gap-8">
                    <input type="submit"
                        class="esp-button esp-button-primary"
                        id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                    <button type="submit"
                            class="esp-button esp-button-danger"
                            id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                    </button>
                </div>
            <#else>
                <input type="submit"
                       class="esp-button esp-button-primary"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
            </#if>
        </form>
    </#if>
</@layout.registrationLayout>