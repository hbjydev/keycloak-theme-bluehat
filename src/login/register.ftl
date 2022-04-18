<#import "template.ftl" as layout>
<#import "forms.ftl" as forms>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        <h1 class="text-2xl font-medium">${msg("registerTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-register-form" class="flex flex-col gap-8" action="${url.registrationAction}" method="post">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <@forms.field
                    name="firstName"
                    id="firstName"
                    label=msg('firstName')
                    placeholder="John"
                    required=true
                    value="${(register.formData.firstName!'')}"
                    hasError=messagesPerField.existsError('firstName')
                    errorMsg="${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}"
                    />

                <@forms.field
                    name="lastName"
                    id="lastName"
                    label=msg('lastName')
                    placeholder="Doe"
                    required=true
                    value="${(register.formData.lastName!'')}"
                    hasError=messagesPerField.existsError('lastName')
                    errorMsg="${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}"
                    />
            </div>

            <@forms.field
                name="email"
                id="email"
                type="email"
                label=msg('email')
                placeholder="john.doe@company.org"
                required=true
                value="${(register.formData.email!'')}"
                hasError=messagesPerField.existsError('email')
                errorMsg="${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}"
                />

            <#if !realm.registrationEmailAsUsername>
                <@forms.field
                    name="username"
                    id="username"
                    label=msg('username')
                    placeholder="john.doe"
                    required=true
                    value="${(register.formData.username!'')}"
                    hasError=messagesPerField.existsError('username')
                    errorMsg="${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}"
                    />
            </#if>

            <#if passwordRequired??>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <@forms.field
                        type="password"
                        name="password"
                        id="password"
                        label=msg('password')
                        placeholder=msg('password')
                        required=true
                        hasError=messagesPerField.existsError('password')
                        errorMsg="${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}"
                        />
                
                    <@forms.field
                        type="password"
                        name="password-confirm"
                        id="password-confirm"
                        label=msg('passwordConfirm')
                        placeholder=msg('passwordConfirm')
                        required=true
                        hasError=messagesPerField.existsError('password', 'password-confirm')
                        errorMsg="${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}"
                        />
                </div>
            </#if>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <input class="esp-button esp-button-primary" type="submit" value="${msg("doRegister")}"/>
            </div>
        </form>
    <#elseif section = "footer">
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